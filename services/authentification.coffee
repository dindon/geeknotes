passport = require 'passport'
LocalStrategy = require('passport-local').Strategy
sechash = require('sechash')

passport.serializeUser (user, callback) ->
    callback null, user.id

passport.deserializeUser (id, callback) ->
    {User} = app.models.UserModel
    User.findOne { _id: id }, (err, user) ->
        callback err, user

passport.use new LocalStrategy (username, password, done) ->
    process.nextTick ->
        {User} = app.models.UserModel
        User.findOne { username: username }, (err, user) ->
            if user && !err
                sechash.testHash password, user.password, { algorithm: 'sha512', salt: user.salt }, (err, isMatch) ->
                    if isMatch
                        if user.valid == '0' then return done null, false, { message: 'Votre compte n\'est pas activé.'} else return done null, user
                    else
                        return done null, false, { message: 'Identifiant ou mot de passe incorrect.' }
            else
                return done null, false, { message: 'Identifiant ou mot de passe incorrect.' }