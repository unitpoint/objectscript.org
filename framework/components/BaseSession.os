BaseSession = extends Component {
	cookieName = "OSSESSION",
	cookieLifetime = 60*60*24*2,
	cookiePath = "/",
	cookieDomain = null,
	cookieSecure = null,
	cookieHttponly = null,

	init = function(){
		@prototype === BaseSession && throw "you should not create instance of BaseSession"
		super()
	},
	
	data = function(){
		throw "you have to override method ${classname}.data"
	},
	
	open = function(id){
		throw "you have to override method ${classname}.open"
	},

	close = function(){
		throw "you have to override method ${classname}.close"
	},

	get = function(name){
		throw "you have to override method ${classname}.get"
	},

	set = function(name, value){
		throw "you have to override method ${classname}.set"
	},
}

