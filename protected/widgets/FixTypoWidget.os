var basePath = path.dirname(_SERVER.DOCUMENT_ROOT)

FixTypoWidget = extends Widget {
	file = null,
	
	run = function(){
		if(@file.find(basePath) == 0){
			echo @renderPartial("{widgets}/views/FixTypoWidget", {
				source = "https://github.com/unitpoint/objectscript.org/blob/master"..@file.sub(#basePath),
			})
		}
	},
}