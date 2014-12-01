OSMultiLangUrlManager = extends UrlManager {
	createUrl = function(p){
		var url = super(p)
		return url // OSMultiLangHelper.addLangToUrl(url)
	},
}