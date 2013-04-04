mongoose = require 'mongoose'
crypto = require 'crypto'
sechash = require 'sechash'

UserSchema = new mongoose.Schema
	username:
		type: String
		required: true
		index: { unique: true, sparse: true }
		# validate: [
		# 	(username) -> return username.length > 5 
		# 	'Votre nom d\'utilisateur doit être supérieur à 5 caractères.' 
		# ]
		set: (str) -> str.toLowerCase()
	email:
		type: String
		required: true
		index: { unique: true, sparse: true }
		# validate: [
		# 	(email) -> return email.match /[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}/
		# 	'Votre email semble incorrect.'
		# ]
		set: (str) -> str.toLowerCase()
	salt:
		type: String
		required: true
	password:
		type: String
		required: true
		set: (str) -> encodePassword str, this
	valid:
		type: String
		required: true
		default: 0
	addedOn:
		type: Date
		default: Date.now

encodePassword = (pwd, obj) ->
	salt = crypto.randomBytes(256).toString 'hex'
	obj.salt = salt
	sechash.strongHashSync pwd, { algorithm: 'sha512', salt: salt }

exports.User = mongoose.model "User", UserSchema, "user"