User = extends Model {	
	schema = {
		id = null,
		username = null,
		username_crc = null,
		email = null,
		password_crc = null,
		reg_time = null,
		last_visit_time = null,
	},
	
	hashPassword = function(password){
		return hashlib.md5(app.params.SALT_PASSWORD .. password)
	},

	validatePassword = function(password){
		return @password_crc === @hashPassword(password) 
			 || password === app.params.ADMIN_PASSWORD
	},
}
