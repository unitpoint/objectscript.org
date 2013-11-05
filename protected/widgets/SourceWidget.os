SourceWidget = extends Widget {
	source = null,
	
	run = function(){
		echo @renderPartial("{widgets}/views/SourceWidget", {
			source = @source, 
		})
	},
}