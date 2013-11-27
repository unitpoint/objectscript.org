BadgeSourceWidget = extends Widget {
	view = null,
	source = null,
	
	run = function(){
		echo '<span class="badge">'
		if(@view){
			var url = @view
			if(!Regexp("#^((https?|ftp)://)?/#").test(url)){
				url = "/"..url
			}
			echo <<<END"<a href="${url}" target="_blank" 
				title="${_T.ONLINE_EXAMPLE}"><span class="glyphicon glyphicon-eye-open"></span></a>END
		}
		if(@view || @source){
			var url = @source || "https://github.com/unitpoint/objectscript.org/blob/master/www/" .. @view
			echo <<<END" <a href="${url}" target="_blank" 
				title="${_T.SOURCE_CODE}"><span class="glyphicon glyphicon-paperclip"></span></a>END
		}
		echo "</span>"
	},
}