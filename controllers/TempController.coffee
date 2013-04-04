exports.testForm = (req, res) ->
	form = app.forms.TempForm.TempForm
	form.fields._csrf.value = req.session._csrf
	res.send '<form action="/test/traitement" method="post">' + form.toHTML() + '<button type="submit">Envoyer</button></form>'

exports.testFormTraitement = (req, res) ->
	form = app.forms.TempForm.TempForm
	form.handle req,
		success: (form) ->
			res.send form.data
		other: (form) ->
			res.send form.data
		
		
