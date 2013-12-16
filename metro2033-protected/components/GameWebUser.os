GameWebUser = extends WebUser {
	
	_updateLastTime = function(){
		if(@user){
			app.db.execute("update {{user}} set last_visit_time=:last_visit_time where id=:id", {
				last_visit_time = (@user.last_visit_time = DateTime.now()),
				id = @user.id,
				
			})
		}
	},
	
	init = function(){
		super()
		@_updateLastTime()
	},
	
	login = function(user, duration){
		if(super(user, duration)){
			@_updateLastTime()
			return true
		}	
	},
}
