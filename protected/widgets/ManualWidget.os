ManualWidget = extends Widget {
	content = null,
	page = null,
	pageViewPrefix = null,
	breadcrumb = null,
	
	run = function(){
		var langRE = Regexp.escape(app.lang, '#')
		var baseLangRE = Regexp.escape(app.baseLang, '#')
		var pageViewPrefix = @pageViewPrefix
		pageViewPrefix = pageViewPrefix.replace(app.resolveAliases("{views}"), '')
		pageViewPrefix = pageViewPrefix.replace('\\', '/').replace(Regexp("#/(${langRE}|${baseLangRE})/$#s"), '/')
		// echo "${@pageViewPrefix} => ${pageViewPrefix} <br />"
		
		echo @renderPartial("{widgets}/views/ManualWidgetView", {
			content = @content, 
			page = @page,
			pageViewPrefix = pageViewPrefix,
			breadcrumb = @breadcrumb,
		})
	},
}