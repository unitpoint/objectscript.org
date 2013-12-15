DbConnection = extends Component {
	handle = null,
	tablePrefix = "",
	type = null,
	params = null,
	
	open = function(){
		// @type || throw "ODBO type is not set"
		return @handle || @handle = ODBO(@type || throw "ODBO type is not set", @params)
	},
	
	close = function(){
		if(@handle){
			@handle.close()
			@handle = null
		}
	},
	
	query = function(sql, params){
		sql = sql.replace(Regexp("#\{\{(.+?)\}\}#g"), @tablePrefix.."$1")
		return (@handle || @open()).query(sql, params)
	},
	
	execute = function(sql, params){
		return @query(sql, params).execute()
	},
	
	fetch = function(sql, params){
		return @query(sql, params).fetch()
	},
	
	fetchAll = function(sql, params){
		return @query(sql, params).fetchAll()
	},
	
	__get@lastInsertId = function(){
		return @handle.lastInsertId
	},
	
	begin = function(){
		return @handle.begin()
	},
	
	commit = function(){
		return @handle.commit()
	},
	
	rollback = function(){
		return @handle.rollback()
	},
}
