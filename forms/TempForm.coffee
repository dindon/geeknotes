forms = require 'forms'
fields = forms.fields
widgets = forms.widgets

TempForm = forms.create

	_csrf: fields.string
		required: true
		widget: widgets.hidden()

	nickname: fields.string
		widget: widgets.text()

	shownickname: fields.boolean
		widget: widgets.checkbox()

	rating: fields.number
		choices: { 1,2,3,4,5,6,7,8,9,10 }
		widget: widgets.select()

	comment: fields.string
		widget: widgets.textarea()

exports.TempForm = TempForm