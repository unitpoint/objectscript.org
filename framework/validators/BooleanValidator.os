BooleanValidator = extends Validator {
	init = function(){
		super()
		@message || @message = _T('{attribute} must boolean but {value} found')
	},

	validateAttribute = function(object, attribute){
		var value = object[attribute]
		if(!@validateValue(value, object, attribute)){
			@addError(object, attribute, @message, {
				'value' = value,
			})
		}
	},

	validateValue = function(value, object, attribute){
		if(booleanOf(value)){
			return true
		}
		if(value === '1' || value === 'on' || value === 'yes'){
			object[attribute] = true
			return true
		}
		if(value === '0' || value === 'off' || value === 'no'){
			object[attribute] = false
			return true
		}
	},
}
