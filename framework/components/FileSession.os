FileSession = extends BaseSession {
	savePath = OS_CACHE_PATH,
	hashFunc = "md5",
	gcProbability = 0.001,
	gcLifetime = 60*60*24*2,
	
	_id = null,
	_filename = null,
	_shutdownRunner = null,
	_clenupRunner = null,
	_data = null,
	
	__get@id = function(){
		return @_id
	},
	__set@id = function(value){
		@_id = value
		@_filename = "${@savePath}/os-sess-${@_id}.json"
	},
	
	__get@filename = function(){
		return @_filename
	},
	
	__set@filename = function(){
		throw "error to set filename, set id instead of"
	},
	
	init = function(){
		super()
	},

	genId = function(){
		if(functionOf(hashlib[@hashFunc])){
			return hashlib[@hashFunc](DateTime.now() .. math.random())
		}
		throw "function required but hashlib.${@hashFunc} is not "..(hashlib[@hashFunc] ? "function" : "found")
	},
	
	__get@data = function(){
		return @open()
	},
	
	__set@data = function(value){
		@open()
		@_data = value
	},
	
	__get@isOpen = function(){
		return !!@_filename
	},
	
	new = function(id){
		@close()
		return @open(id)
	},

	open = function(id){
		if(!@isOpen || (id && id !== @id)){
			@id = id || _COOKIE[@cookieName] || @genId()
			@_data = objectOf(json.decode(File.readContents(@filename))) || {}
			if(#@_data == 0 && @id == _COOKIE[@cookieName] && !fs.exists(@filename)){
				@id = @genId()
			}
			
			setCookie(@cookieName, @id, @cookieLifetime && DateTime.now() + @cookieLifetime/(60*60*24), 
				@cookiePath, @cookieDomain, @cookieSecure, @cookieHttponly)	
			
			var self = this
			// unregisterShutdownFunction(@_shutdownRunner)
			registerShutdownFunction(@_shutdownRunner = {|| self.close() })
		}
		return @_data
	},
	
	delete = function(){
		if(@isOpen){
			setCookie(@cookieName, null)
			fs.unlink(@_filename)
			@_id, @_filename, @_data, _COOKIE[@cookieName] = null
		}
	},

	close = function(){
		if(@isOpen){
			var filename, data = @_filename, @_data
			@_id, @_filename, @_data, _COOKIE[@cookieName] = null
			
			var self = this
			// unregisterCleanupFunction(@_clenupRunner)
			registerCleanupFunction(@_clenupRunner = {|| 
				File.writeContents(filename, json.encode(data))
				self._cleanup() 
			})
		}
	},
	
	_cleanup = function(){
		if(math.random() <= @gcProbability){
			
		}
	},

	get = function(name){
		return @_data[name]
	},

	set = function(name, value){
		@_data[name] = value
	},
}

