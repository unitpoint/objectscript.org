LangReferenceWidget = extends Widget {
	content = null,
	page = null,
	pageViewPrefix = null,
	breadcrumb = null,
	file = null,
	
	run = function(){
		echo @renderPartial("{widgets}/views/LangReferenceWidgetView", {
			content = @content, 
			page = @page,
			pageViewPrefix = @pageViewPrefix,
			breadcrumb = @breadcrumb,
			file = @file,
		})
	},	
}
