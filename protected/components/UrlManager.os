UrlManager = extends Component {
	routeVar = "r",
	
	__construct = function(){
		super()
	},
	
	init = function(){
		super()
	},
	
	parseUrl = function(request){
		return request.getParam(@routeVar)
	},
}