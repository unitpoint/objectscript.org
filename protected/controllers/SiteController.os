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

	actionIndex = function(){ // pass, user){
		// dump([@classname, {pass=pass, user=user}]); terminate()
		echo @render("index")
	},
	
	actionInstall = function(){
		echo @render("install")
	},
}