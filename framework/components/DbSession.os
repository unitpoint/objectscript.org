DbSession = extends BaseSession {
	// savePath = OS_CACHE_PATH,
	// filenamePrefix = "os-sess-",
	sessionTable = "{{session}}",
	hashFunc = "md5",
	gcProbability = 0.001,
	gcLifetime = 60*60*24*2,
	
	_id = null,
	// _filename = null,
	_data = null,
	
	__get@id = function(){
		return @_id
	},
	__set@id = function(value){
		@_id = value
		// @_filename = "${@savePath}/${@filenamePrefix}${@_id}.json"
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
		return !!@_id
	},
	
	new = function(id){
		@close()
		return @open(id)
	},

	open = function(id){
		if(!@isOpen || (id && id !== @id)){
			@id = id || _COOKIE[@cookieName] || @genId()
			var row = app.db.fetch("select * from ${@sessionTable} where id=:id and expire>:expire", {
				id = @id,
				expire = DateTime.now(),
			})
			@_data = objectOf(json.decode(row.data)) || {}
			if(#@_data == 0 && @id == _COOKIE[@cookieName] && !row){
				@id = @genId()
			}
			
			setCookie(@cookieName, @id, @cookieLifetime && DateTime.now() + @cookieLifetime/(60*60*24), 
				@cookiePath, @cookieDomain, @cookieSecure, @cookieHttponly)	
			
			registerShutdownFunction(delegate(this, @close))
		}
		return @_data
	},
	
	close = function(){
		if(@isOpen){
			var id, data = @_id, @_data
			@_id, @_data, _COOKIE[@cookieName] = null
			
			registerCleanupFunction(delegate(this, {|| 
				app.db.execute("replace into ${@sessionTable} set id=:id, expire=:expire, data=:data", {
					id = id,
					expire = DateTime.now() + @gcLifetime,
					data = json.encode(data),
				})
				if(math.random() <= @gcProbability){
					app.db.execute("delete from ${@sessionTable} where expire<=:expire", {expire = DateTime.now()})
				}
			}))
		}
	},
	
	delete = function(){
		// @open()
		if(@isOpen){
			setCookie(@cookieName, null)
			app.db.execute("delete from ${@sessionTable} where id=:id", {id = @_id})
			@_id, @_data, _COOKIE[@cookieName] = null
		}
	},

	get = function(name){
		return @_data[name]
	},

	set = function(name, value){
		@_data[name] = value
	},
}

