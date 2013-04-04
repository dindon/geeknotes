exports.login = (req, res) ->
	form = app.forms.user.LoginForm.LoginForm
	form.fields._csrf.value = req.session._csrf
	res.render 'user/login',
		errors: req.flash 'error'
		user: req.user
		form: form

exports.registration = (req, res) ->
	form = app.forms.user.RegistrationForm.RegistrationForm
	form.fields._csrf.value = req.session._csrf
	res.render 'user/registration',
		form: form

exports.create = (req, res) ->
	form = app.forms.user.RegistrationForm.RegistrationForm
	form.handle req,
		success: (form) ->
			{User} = app.models.UserModel
			user = new User form.data
			user.save (err) -> res.redirect '/identification'
		other: (form) ->
			res.render 'user/registration',
				form: form

exports.validAccount = (req, res) ->
	{User} = app.models.UserModel
	User.findOne {_id: req.query.token}, (err, user) ->
		if user then user.update {valid: '1'}, (err) -> res.redirect '/identification' else res.send null, 404

exports.logout = (req, res) ->
	req.logout()
	res.redirect '/'