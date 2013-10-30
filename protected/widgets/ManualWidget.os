ManualWidget = extends Widget {
	content = null,
	page = null,
	pageViewPrefix = null,
	breadcrumb = null,
	
	run = function(){
		echo @renderPartial("{widgets}/views/ManualWidgetView", {
			content = @content, 
			page = @page,
			pageViewPrefix = @pageViewPrefix,
			breadcrumb = @breadcrumb,
		})
	},
}