passport = require 'passport'

app.get '/identification', app.controllers.UserController.login 
app.post '/identification/traitement', passport.authenticate 'local', { successRedirect: '/', failureRedirect: '/identification', failureFlash: true  }
app.get '/inscription', app.controllers.UserController.registration
app.post '/inscription/traitement', app.controllers.UserController.create
app.get '/inscription/validation/:token', app.controllers.UserController.validAccount
app.all '/deconnexion', app.controllers.UserController.logout 

# TEST
app.get '/administrator', (req,res) ->
	res.send 'hellow administrator ...'