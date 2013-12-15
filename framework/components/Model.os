Model = extends Component {
	const DEFAULT_SCENARIO = 'default',
	
	_errors = null,
	_validators = null,
	_scenario = null,
	
	__get@scenario = function(){
		return @_scenario
	},

	__set@scenario = function(value){
		@_scenario = value
	},
	
	__get@rules = function(){
		return []
	},
	
	__get@labels = function(){
		return {}
	},
	
	__get@validators = function(){
		return @_validators || @_validators = @createValidators()
	},

	__get@scenarios = function(){
		var scenarios, defaults = {}, {}
		for(var _, validator in @validators){
			if(#validator.on == 0){
				for(var _, attribute in validator.attributes){
					defaults[attribute] = true
				}
			}else{
				for(var _, scenario in validator.on){
					for(var _, attribute in validator.attributes){
						(scenarios[scenario] || scenarios[scenario] = {})[attribute] = true
					}
				}
			}
		}
		for(var scenario, attributes in scenarios){
			for(var attribute in defaults){
				attributes[attribute] = true
			}
			scenarios[scenario] = attributes.keys
		}
		scenarios[@DEFAULT_SCENARIO] = defaults.keys
		echo "scenarios <pre>"; dump(scenarios)
		return scenarios
	},
	
	__get@attributes = function(names, except){
		var values = names ? names.flip() : @{
			var names = {}
			for(var name, value in this){
				if(!functionOf(value) && typeOf(name) == "string" && name.sub(0, 1) != "_"){
					names[name] = true 
				}
			}
			return names
		}
		for(var _, name in except){
			delete values[name]
		}
		return values.keys
	},

	__set@attributes = function(values, safeOnly){
		if(values){
			var attributes = (safeOnly !== false ? @getActiveAttributes() : @attributes).flip()
			// echo "__set@attributes <pre>"; dump(attributes)
			for(var name, value in values){
				if(attributes[name]){
					this[name] = value
				}elseif(safeOnly !== false){
					@onUnsafeAttribute(name, value)
				}
			}
		}
	},
	
	onUnsafeAttribute = function(name, value){
		throw "Failed to set unsafe attribute '${name}' in '${@classname}'"
	},
	
	createValidators = function(){
		var validators = []
		for(var _, rule in @rules){
			if(rule is Validator){
				validators[] = rule
			}elseif((arrayOf(rule) || objectOf(rule)) && rule[0] && rule[1]){ // attributes, validator type
				validators[] = Validator.createValidator(rule[1], this, toArray(rule[0]), rule.sub(2))
			}else{
				throw "Invalid validation rule: a rule (${rule}, ${@rules}) must specify both attribute names and validator type."
			}
		}
		return validators
	},
	
	getActiveValidators = function(attribute){
		var validators, scenario = [], @scenario
		for(var _, validator in @validators){
			// echo "check validators <pre>"; dump(validator)
			if(validator.isActive(scenario) && (!attribute || attribute in validator.attributes)){
				validators[] = validator
			}
		}
		echo "getActiveValidators <pre>"; dump(validators)
		return validators
	},
	
	validate = function(attributes, clearErrors){
		clearErrors !== false && @clearErrors()
		attributes || attributes = @getActiveAttributes()
		echo "validate attributes <pre>"; dump(attributes)
		// echo "validate getActiveValidators <pre>"; dump(@getActiveValidators())
		for(var _, validator in @getActiveValidators()){
			validator.validate(this, attributes)
		}
		return !@hasErrors()
	},
	
	hasErrors = function(attribute){
		return attribute ? !!@_errors[attribute] : #@_errors > 0
	},
	
	addError = function(attribute, error){
		((@_errors || @_errors = {})[attribute] || @_errors[attribute] = {})[] = error || "unknown error"
	},
	
	clearErrors = function(attribute){
		if(!attribute){
			@_errors = null
		}else{
			delete @_errors[attribute]
		}
	},
	
	getActiveAttributes = function(){
		var scenario, scenarios = @scenario || @DEFAULT_SCENARIO, @scenarios
		var attributes = scenarios[scenario] || return []
		/* for(var i, attribute in attributes){
			if(attribute.sub(0, 1) === '!'){
				attributes[i] = attribute.sub(1)
			}
		} */
		return attributes
	},
	
	getLabel = function(attribute){
		return @labels[attribute] || @genLabel(attribute)
	},
	
	genLabel = function(name){
		return (stringOf(name) || throw "string required").replace(
			Regexp('/(?<![A-Z])[A-Z]/'), ' $0').trim().flower()
	},
	
}
