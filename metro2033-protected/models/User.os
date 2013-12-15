User = extends Model {
	
	id = null,
	username = null,
	password = null,
	authKey = null,

	_users = {
		'100' = {
			'id' = '100',
			'username' = 'admin',
			'password' = 'admin',
			'authKey' = 'test100key',
		},
		'101' = {
			'id' = '101',
			'username' = 'demo',
			'password' = 'demo',
			'authKey' = 'test101key',
		},
	},

	findIdentity = function(id){
		return @_users[id] && @{
			var user = User()
			for(var k, v in @_users[id]){
				user[k] = v
			}
			user.init();
			return user
		}
	},

	findByUsername = function(username){
		for(var id, user in @_users){
			if(user.username.lower() == username.lower()){
				return @findIdentity(id)
			}
		}
	},

	validateAuthKey = function(authKey){
		return @authKey === authKey
	},

	validatePassword = function(password){
		return @password === password
	},
}
