CookieSession = extends Component {
	cookieName = "OSSESSION",
	cookieLifetime = 60*60*24*2,
	cookiePath = "/",
	cookieDomain = null,
	cookieSecure = null,
	cookieHttponly = null,

	init = function(){
		@prototype === CookieSession && throw "you should not create instance of CookieSession"
		super()
	},
}

