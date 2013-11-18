html = extends Component {
	encode = function(str){
		return str.replace { 
			// "&" = "&amp;", don't use it here
			"<" = "&lt;",
			">" = "&gt;",
			"\"" = "&quot;",
			"'" = "&#039;",
		}
	},
}
