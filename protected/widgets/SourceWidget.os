SourceWidget = extends Widget {
	source = null,
	width = null,
	
	run = function(){
		echo @renderPartial("{widgets}/views/SourceWidget", {
			source = @source,
			width = @width,
		})
	},
}