Model = extends Component {
	const DEFAULT_SCENARIO = 'default',
	
	_errors = null,
	_messages = null,
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
	
	__get@placeHolders = function(){
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
		// echo "scenarios <pre>"; dump(scenarios)
		return scenarios
	},
	
	getAttributes = function(names, except){
		var values = {}
		if(names){
			for(var _, name in names){
				var value = this[name] 
				if(!functionOf(value) && typeOf(name) == "string" && name.sub(0, 1) != "_"){
					values[name] = value 
				}
			}
		}else{
			for(var name, value in this){
				if(!functionOf(value) && typeOf(name) == "string" && name.sub(0, 1) != "_"){
					values[name] = value 
				}
			}
		}
		for(var _, name in except){
			delete values[name]
		}
		return values // .keys
	},
	
	setAttributes = function(values, safeOnly){
		if(values){
			objectOf(values) || throw "object required for values"
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
	
	__get@attributes = function(){
		return @getAttributes()
	},

	__set@attributes = function(values){
		@setAttributes(values)
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
		// echo "getActiveValidators <pre>"; dump(validators)
		return validators
	},
	
	validate = function(attributes, clearErrors){
		clearErrors !== false && @clearErrors()
		attributes || attributes = @getActiveAttributes()
		// echo "validate attributes <pre>"; dump(attributes)
		// echo "validate getActiveValidators <pre>"; dump(@getActiveValidators())
		for(var _, validator in @getActiveValidators()){
			validator.validate(this, attributes)
		}
		return !@hasErrors()
	},
	
	hasErrors = function(attribute){
		return attribute ? !!@_errors[attribute] : #@_errors > 0
	},
	
	getError = function(attribute){
		return @_errors[attribute][0]
	},
	
	addError = function(attribute, error, params){
		params && error = error.replace(Regexp("#\{(\w+)\}#is"), {|m| params[m[1]] })
		;((@_errors || @_errors = {})[attribute] || @_errors[attribute] = {})[] = error || "unknown error"
	},
	
	clearErrors = function(attribute){
		if(!attribute){
			@_errors = null
		}else{
			delete @_errors[attribute]
		}
	},
	
	hasMessages = function(attribute){
		return attribute ? !!@_messages[attribute] : #@_messages > 0
	},
	
	getMessage = function(attribute){
		return @_messages[attribute][0]
	},
	
	addMessage = function(attribute, message, params){
		params && message = message.replace(Regexp("#\{(\w+)\}#is"), {|m| params[m[1]] })
		;((@_messages || @_messages = {})[attribute] || @_messages[attribute] = {})[] = message || "unknown message"
	},
	
	clearMessages = function(attribute){
		if(!attribute){
			@_messages = null
		}else{
			delete @_messages[attribute]
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
	
	genLabel = function(attribute){
		return (stringOf(attribute) || throw "string required for attribute").replace(
			Regexp('/(?<![A-Z])[A-Z]/'), ' $0').trim().flower()
	},
	
	getPlaceHolder = function(attribute){
		return @placeHolders[attribute] || @getLabel(attribute)
	},
	
	__get@tableName = function(){
		return "{{"..(Object.getName.call(this) || @classname)
			.replace(Regexp('/(?<![A-Z])[A-Z]/'), '_$0')
			.replace(Regexp('/^_/'), '').lower().."}}"
	},

	find = function(where, params){
		// echo "Model.find: ${@name}"; dump(this)
		if(objectOf(where)){
			where, params = [], where			
			for(var k, v in params){
				where[] = "${k}=:${k}"
			}
			where = where.join(" and ")
		}else{
		}
		var row = app.db.fetch("select * from ${@tableName}"..(where != "" ? " where ${where}" : ""), params)
		if(row){
			var model = _G[Object.getName.call(this) || @classname]()
			for(var k, v in row){
				model[k] = v
			}
			model.init()
			return model
		}
	},

	insert = function(params){	
		var names, valueNames = [], []
		for(var k, v in params){
			valueNames[] = k.sub(0, 1) == ":" ? k : ":"..k
			names[] = valueNames.last.sub(1)
		}
		app.db.execute("insert into ${@tableName} (${names.join(',')}) values(${valueNames.join(',')})", params)
		return app.db.lastInsertId
	},
}
