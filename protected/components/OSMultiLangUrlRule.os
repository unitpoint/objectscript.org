OSMultiLangUrlRule = extends UrlRule {
	createUrl = function(manager, route, params){
		var url = super(manager, route, params)
		return OSMultiLangHelper.addLangToUrl(url)
	},
}
