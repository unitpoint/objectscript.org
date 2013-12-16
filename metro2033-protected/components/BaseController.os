BaseController = extends Controller {
	pageTitle = "Metro 2033 Title",
	
	pageAuthor = "Evgeniy Golovin",
	
	pageDesc = <<<END'
Metro 2033 новая многопользовательская стратегическая браузерная игра
END,
	
	pageKeywords = "Metro 2033 новая многопользовательская стратегическая браузерная игра",
	
	init = function(){
		super()
		header("Expires: "..(DateTime.now()-1).format("R"))
		header("Last-Modified: "..(DateTime.now()-2).format("R"))
	},
}