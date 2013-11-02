HtmlEncodeWidget = extends Widget {
	init = function(){
		super()
		ob.push()
	},
	run = function(){
		echo html.encode(ob.popContent())
	},
}