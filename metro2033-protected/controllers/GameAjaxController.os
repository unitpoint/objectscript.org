GameAjaxController = extends BaseController {

	init = function(){
		super()
		header "Content-Type: application/json"
		app.user.isLogged || @echoJson{error="required user.isLogged"}
		app.request.isAjax || @echoJson{error="required request.isAjax"}
	},
	
	echoJson = function(data, end){
		echo(json.encode(data))
		end !== false && app.end()
	},

	actionStationInfo = function(id){
		var station = app.params.map.stations[id]
		@echoJson{station=station}
	},
}