CCookieSession = extends CComponent {
	cookieName = "OSSESSION",
	cookieLifetime = 60*60*24*2,
	cookiePath = "/",
	cookieDomain = null,
	cookieSecure = null,
	cookieHttponly = null,

	init = function(){
		@prototype === CCookieSession && throw "you should not create instance of CookieSession"
		super()
	},
	
	start = function(id){
		throw "you have to override method ${classname}.start"
	},

	stop = function(){
		throw "you have to override method ${classname}.stop"
	},
}

