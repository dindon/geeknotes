# Modules serveur
express = require 'express'
http = require 'http'
path = require 'path'
global.app = express()

# Nos modules
stylus = require 'stylus'
coffee = require 'coffee-script'
load = require 'express-load'
flash = require 'connect-flash'
mongoose = require 'mongoose'
passport = require 'passport'
parameters = require './config/parameters'

# Connexion mongoose
db = mongoose.connect parameters.creds.mongoose_auth

# Stylus compile
compile = (str, path) -> stylus(str).set('filename', path).set 'compress', true
app.use stylus.middleware { src: __dirname+'/public/stylus', dest: __dirname+'/public', compile: compile, compress: true }


# Configuration du serveur
app.configure ->
    app.set 'port', process.env.PORT || 3000
    app.set 'views', __dirname + '/views'
    app.set 'view engine', 'jade'
    app.use express.favicon()
    app.use express.logger 'dev'
    app.use express.cookieParser()
    app.use express.session {secret: 'secret'}
    app.use passport.initialize()
    app.use passport.session()
    app.use flash()
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.csrf()
    app.use app.router
    app.use express.static path.join __dirname, 'public'
    app.use express.favicon __dirname + '/public/favicon.ico'

app.configure 'development', ->
    app.use express.errorHandler()        

# Express Loader : l'ordre est MEGA important
load('controllers')
.then('models')
.then('forms')
.then('services')
.then('routing')
.into(app)

# Lancement du serveur
http.createServer(app).listen app.get('port'), ->
    console.log "Express server listening on port " + app.get 'port'