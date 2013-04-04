forms = require 'forms'
fields = forms.fields
validators = forms.validators
widgets = forms.widgets

loginForm = forms.create
	_csrf: fields.string
		required: true
		widget: widgets.hidden()

	username: fields.string
		required: true
		widget: widgets.text
			placeholder: "Identifiant ..."
			required: "required"
	password: fields.password
		required: true
		widget: widgets.password
			placeholder: "Mot de passe ..."
			required: "required"

LoginForm = exports.LoginForm = loginForm