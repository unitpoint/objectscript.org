
var specialAttributes = {
	'checked' = 1
	'declare' = 1
	'defer' = 1
	'disabled' = 1
	'ismap' = 1
	'multiple' = 1
	'nohref' = 1
	'noresize' = 1
	'readonly' = 1
	'selected' = 1
}

Html = {
	tag = function(tag, htmlOptions, content, closeTag){
		// htmlOptions = htmlOptions || {}
		closeTag = closeTag || true
		
		var html = '<' .. tag .. @renderAttributes(htmlOptions)
		if(!content)
			return closeTag ? html..' />' : html..'>';
		else
			return closeTag ? html..'>'..content..'</'..tag..'>' : html..'>'..content;
	}
	
	encode = function(str){
		return str
	}

	renderAttributes = function(htmlOptions){
		if(!objectOf(htmlOptions) || #htmlOptions == 0){
			return ''
		}
		
		var raw = !htmlOptions.getProperty('encode')
		delete htmlOptions.encode

		var html = Buffer()
		for(var name, value in htmlOptions){
			if(name in specialAttributes){
				if(value)
					html.append(' ', name, '="', raw ? name : @encode(name), '"')
			}else if(value !== null)
				html.append(' ', name, '="', value, '"')
		}
		return toString(html)
	}

}