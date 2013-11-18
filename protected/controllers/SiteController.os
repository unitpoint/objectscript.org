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
		
		var data = app.session.data()
		data.counter = (data.counter || 0) + 1
		data.ip = _SERVER.REMOTE_ADDR
		data.userAgent = _SERVER.HTTP_USER_AGENT
		data._GET = _GET
		data._POST = _POST
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