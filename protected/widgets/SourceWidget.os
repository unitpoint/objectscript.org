SourceWidget = extends Widget {
	source = null,
	width = null,
	lang = null,
	row = true,
	
	run = function(){
		echo @renderPartial("{widgets}/views/SourceWidget", {
			source = @source,
			width = @width,
			lang = @lang,
			row = @row,
		})
	},
}