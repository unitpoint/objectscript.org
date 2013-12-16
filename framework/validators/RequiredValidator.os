RequiredValidator = extends Validator {
	__object = {
		skipOnEmpty = false,
		requiredValue = null,
		strict = false,
		message = null,
	},

	init = function(){
		super()
		@message || @message = !@requiredValue ? _T('{attribute} cannot be blank.')	: _T('{attribute} must be "{requiredValue}".')
	},

	validateAttribute = function(object, attribute){
		if(!@validateValue(object[attribute])){
			@addError(object, attribute, @message, {
				'requiredValue' = @requiredValue,
			})
		}
	},

	validateValue = function(value){
		try{
			// echo "validateValue <pre>"; dump([value, @requiredValue, value == @requiredValue])
			if(!@requiredValue){
				if(@strict && @value || !@strict && !@isEmpty(value, true)){
					return true
				}
			}elseif(!@strict && value == @requiredValue || @strict && value === @requiredValue){
				return true
			}
		}catch(e){
			echo "catch <pre>"; dump(e)
		}
		return false
	},
}
