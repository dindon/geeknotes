exports.username = (form, field, callback) -> 
	if field.data.length < 5
		callback 'Votre nom d\'utilisateur doit contenir 6 caractères au minimum'
	else
		{User} = app.models.UserModel
		User.findOne {'username': field.data}, (err, user) -> if user then  callback 'Le nom d\'utilisateur est déjà utilisé.' else callback()

exports.email = (form, field, callback) -> 
	if field.data.match /[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}/ 
		{User} = app.models.UserModel
		User.findOne {'email': field.data}, (err, user) -> if user then  callback 'L\'adresse email est déjà utilisée.' else callback()
	else 
		callback 'L\'adresse email est incorrect.'

exports.password = (form, field, callback) -> 
	if field.data.length < 6 then callback 'Le mot de passe doit contenir 6 caractères au minimum.' 
	else
		if form.fields.password_again.data != field.data then callback 'Les mots de passes ne correspondent pas.' else callback()