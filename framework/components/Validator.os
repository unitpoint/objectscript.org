Validator = extends Component {

	__object = {
		attributes = [],
		message = null,
		on = [],
		except = [],
		skipOnError = true,
		skipOnEmpty = true,
		// enableClientValidation = true,	
	},
	
	init = function(){
		super()
		arrayOf(@except) || throw "array required in 'except' but ${@except.classname} found"
		arrayOf(@on) || throw "array required in 'on' but ${@on.classname} found"
	},
	
	createValidator = function(type, model, attributes, params){
		params = {}.merge(params, {attributes=attributes})
		if(type in model){
			functionOf(model[type]) || throw "Function required for ${type} in model ${model.classname}"
			// params.model = model
			params.method = type
			return app.createValidator("InlineValidator", params)
		}
		return app.createValidator(type.flower().."Validator", params)
	},
	
	isActive = function(scenario){
		return !(scenario in @except) && (#@on == 0 || scenario in @on)
	},
	
	isEmpty = function(value, trim){
		return !value || value === '' || value === 0 || @{
			var scalar = typeOf(value) in ["boolean", "number", "string"]
			return (!scalar && #value === 0) || trim && stringOf(value).trim() === ''
		}
	},

	addError = function(object, attribute, message, params){
		var value = object[attribute]
		objectOf(params) || params = {}
		params.attribute = object.getLabel(attribute)
		params.value = value; // arrayOf(value) ? '[]' : value;
		object.addError(attribute, message.replace(Regexp("#\{(\w+)\}#is"), {|m| params[m[1]] }))
	},
	
	validate = function(object, attributes){
		if(attributes){
			var attrs = attributes;	attributes = []
			for(var _, attribute in attrs){
				if(attribute in @attributes){
					attributes[] = attribute
				}
			}
		}else{
			attributes = @attributes
		}
		for(var _, attribute in attributes){
			var skip = @skipOnError && object.hasErrors(attribute)
				|| @skipOnEmpty && @isEmpty(object[attribute])
			if(!skip){
				@validateAttribute(object, attribute)
			}
		}
	},
	
	validateAttribute = function(object, attribute){
	},
}