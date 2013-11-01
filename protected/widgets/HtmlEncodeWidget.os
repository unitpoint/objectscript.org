HtmlEncodeWidget = extends Widget {
	init = function(){
		super()
		ob.push()
	},
	run = function(){
		echo ob.popContent().replace { "<" = "&lt;", ">" = "&gt;" }
	},
}