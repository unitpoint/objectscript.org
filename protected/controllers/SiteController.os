SiteController = extends Controller {

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
		
		var data = app.session.start()
		data.counter = (data.counter || 0) + 1
		data.ip = _SERVER.REMOTE_ADDR
	},

	actionIndex = function(){ // pass, user){
		// dump([@classname, {pass=pass, user=user}]); terminate()
		echo @render("index")
	},
	
	actionInstall = function(page){
		// @redirect{action="manual", params={page="install"}}
		echo @render("install", {page = page})
	},
	
	actionDownload = function(){
		echo @render("download")
	},
	
	actionManual = function(page){
		echo @render("manual", {page = page})
	},
}