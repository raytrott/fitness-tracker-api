// Express docs: http://expressjs.com/en/api.html
const express = require('express')
// Passport docs: http://www.passportjs.org/docs/
const passport = require('passport')

// pull in Mongoose model for workouts
const Workout = require('../models/workout')

// this is a collection of methods that help us detect situations when we need
// to throw a custom error
const customErrors = require('../../lib/custom_errors')

// we'll use this function to send 404 when non-existant document is requested
const handle404 = customErrors.handle404
// we'll use this function to send 401 when a user tries to modify a resource
// that's owned by someone else
const requireOwnership = customErrors.requireOwnership

// this is middleware that will remove blank fields from `req.body`, e.g.
// { example: { title: '', text: 'foo' } } -> { example: { text: 'foo' } }
const removeBlanks = require('../../lib/remove_blank_fields')
// passing this as a second argument to `router.<verb>` will make it
// so that a token MUST be passed for that route to be available
// it will also set `req.user`
const requireToken = passport.authenticate('bearer', { session: false })

// instantiate a router (mini app that only handles routes)
const router = express.Router()

// INDEX
// GET /workouts
router.get('/workouts', requireToken, (req, res, next) => {
  Workout.find({ owner: req.user.id }).sort({date: 1})
    .then(workouts => {
      // `workouts` will be an array of Mongoose documents
      // we want to convert each one to a POJO, so we use `.map` to
      // apply `.toObject` to each one
      return workouts.map(workout => workout.toObject())
    })
    // respond with status 200 and JSON of the workouts
    .then(workouts => res.status(200).json({ workouts: workouts }))
    // if an error occurs, pass it to the handler
    .catch(next)
})

// SHOW
// GET /workouts/5a7db6c74d55bc51bdf39793
router.get('/workouts/:id', requireToken, (req, res, next) => {
  // req.params.id will be set based on the `:id` in the route
  Workout.findById(req.params.id)
    .then(handle404)
    .then(workout => requireOwnership(req, workout))
    // if `findById` is succesful, respond with 200 and "workout" JSON
    .then(workout => res.status(200).json({ workout: workout.toObject() }))
    // if an error occurs, pass it to the handler
    .catch(next)
})

// CREATE
// POST /workouts
router.post('/workouts', requireToken, (req, res, next) => {
  // set owner of new workout to be current user
  const workout = req.body.workout

  workout.owner = req.user.id

  Workout.create(workout)
    // respond to succesful `create` with status 201 and JSON of new "workout"
    .then(workout => {
      res.status(201).json({ workout: workout.toObject() })
    })
    // if an error occurs, pass it off to our error handler
    // the error handler needs the error message and the `res` object so that it
    // can send an error message back to the client
    .catch(next)
})

// UPDATE
// PATCH /workouts/5a7db6c74d55bc51bdf39793
router.patch('/workouts/:id', requireToken, removeBlanks, (req, res, next) => {
  // if the client attempts to change the `owner` property by including a new
  // owner, prevent that by deleting that key/value pair
  delete req.body.workout.owner

  const id = req.params.id
  const workoutData = req.body.workout

  Workout.findById(id)
    .then(handle404)
    .then(workout => requireOwnership(req, workout))
    .then(workout => {
      Object.assign(workout, workoutData)
      return workout.save()
    })
    .then(() => res.sendStatus(204))
    .catch(next)
})

// DESTROY
// DELETE /workouts/5a7db6c74d55bc51bdf39793
router.delete('/workouts/:id', requireToken, (req, res, next) => {
  const id = req.params.id
  Workout.findById(id)
    .then(handle404)
    .then(workout => requireOwnership(req, workout))
    .then(workout => {
      workout.deleteOne()
    })
    .then(() => res.sendStatus(204))
    .catch(next)
})

module.exports = router
