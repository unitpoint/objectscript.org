CFileSession = extends CCookieSession {
	savePath = OS_CACHE_PATH,
	hashFunc = "md5",
	gcProbability = 0.001,
	gcLifetime = 60*60*24*2,
	
	_id = null,
	_filename = null,
	_shutdownRunner = null,
	_clenupRunner = null,
	
	// data = null,
	
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
	
	init = function(){
		super()
	},

	genId = function(){
		if(functionOf(hashlib[@hashFunc])){
			return hashlib[@hashFunc](DateTime.now() .. math.random())
		}
		throw "function required but hashlib.${@hashFunc} is not "..(hashlib[@hashFunc] ? "function" : "found")
	},
	
	start = function(id){
		@id = id || _COOKIE[@cookieName] || @genId()
		_SESSION = objectOf(json.decode(File.readContents(@filename))) || {}
		if(#_SESSION == 0 && !path.exists(@filename) && @id == _COOKIE[@cookieName]){
			@id = @genId()
		}
		
		setCookie(@cookieName, @id, @cookieLifetime && DateTime.now() + @cookieLifetime/(60*60*24), 
			@cookiePath, @cookieDomain, @cookieSecure, @cookieHttponly)	
		
		var self = this
		// unregisterShutdownFunction(@_shutdownRunner)
		registerShutdownFunction(@_shutdownRunner = {|| self.stop() })
	},

	stop = function(){
		if(@_filename){
			var filename, data = @_filename, _SESSION
			@_id, @_filename, _SESSION, _COOKIE[@cookieName] = null
			
			var self = this
			unregisterCleanupFunction(@_clenupRunner)
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

	__get@isOpen = function(){
		return !!@_filename
	},

	get = function(name){
		return _SESSION[name]
	},

	set = function(name, value){
		_SESSION[name] = value
	},
}

