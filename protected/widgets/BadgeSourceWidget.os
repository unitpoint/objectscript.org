BadgeSourceWidget = extends Widget {
	view = null,
	source = null,
	
	run = function(){
		echo '<span class="badge">'
		if(@view){
			echo "<a href=\"${@view}\" target=\"_blank\" title=\"${_T.ONLINE_EXAMPLE}\"><span class=\"glyphicon glyphicon-eye-open\"></span></a>"
		}
		if(@view || @source){
			var url = @source || "https://github.com/unitpoint/objectscript.org/blob/master/www/" .. @view
			echo " <a href=\"${url}\" target=\"_blank\" title=\"${_T.SOURCE_CODE}\"><span class=\"glyphicon glyphicon-paperclip\"></span></a>"
		}
		echo "</span>"
	},
}