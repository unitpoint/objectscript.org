SiteController = extends OSController {

	/* runAction = function(name){
		ob.push()
		super(name)
		var content = ob.pop()
		content = content.replace {
			[Regexp("#[ \t]+#")] = " ",
            [Regexp("#[\r\n]+ +[\r\n]+|[\r\n]+ +| +[\r\n]+#")] = "\n",
            [Regexp("#>\s+<#")] = "> <",
            [Regexp("#\s{2,}#")] = " ",
		}
		echo content
	}, */

	init = function(){
		super()
		
		app.session.start()
		_SESSION.counter = (_SESSION.counter || 0) + 1
		_SESSION.ip = _SERVER.REMOTE_ADDR
		_SESSION.userAgent = _SERVER.HTTP_USER_AGENT
		_SESSION._GET = _GET
		_SESSION._POST = _POST
	},

	actionIndex = function(){ // pass, user){
		// dump([@classname, {pass=pass, user=user}]); terminate()
		echo @render("index")
	},
	
	actionInstall = function(page){
		// @redirect{action="manual", params={page="install"}}
		echo @render("install", {page = page})
	},
	
	actionDownload = function(page){
		echo @render("download", {page = page})
	},
	
	actionManual = function(page){
		echo @render("manual", {page = page})
	},
	
	actionLangref = function(page){
		echo @render("langref", {page = page})
	},
	
}