InlineValidator = extends Validator {
	model = null,
	method = null,
	params = null,
	
	validateAttribute = function(object, attribute){
		return object[@method](attribute, @params)
	},
}
