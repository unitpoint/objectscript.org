HttpRequest = extends Component {
	getParam = function(name){
		return _POST[name] || _GET[name]
	},
}