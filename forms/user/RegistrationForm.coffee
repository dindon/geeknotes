forms = require 'forms'
validate = require './validators/RegistrationValidator'
fields = forms.fields
widgets = forms.widgets

registrationForm = forms.create

	_csrf: fields.string
		required: true
		widget: widgets.hidden()

	username: fields.string
		required: true
		validators: [validate.username]
		widget: widgets.text
			placeholder: "Identifiant ..."
			required: "required"
			classes: ["span12"]


	email: fields.string
		required: true
		validators: [validate.email]
		widget: widgets.text
			placeholder: "Email ..."
			required: "required"
			classes: ["span12"]


	password: fields.password
		required: true
		validators: [validate.password]
		widget: widgets.password
			placeholder: "Mot de passe ..."
			required: "required"
			classes: ["span12"]


	password_again: fields.password
		required: true
		widget: widgets.password
			placeholder: "Verification ..."
			required: "required"
			classes: ["span12"]

RegistrationForm = exports.RegistrationForm = registrationForm