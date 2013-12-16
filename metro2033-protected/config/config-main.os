return {
	charset = "utf-8",
	lang = "ru",
	defaultController = "site",
	aliases = {
		"{app}" = path.dirname(__DIR__),
		"{components}" = "{app}/components",
		"{helpers}" = "{app}/helpers",
		"{controllers}" = "{app}/controllers",
		"{widgets}" = "{app}/widgets",
		"{langs}" = "{app}/langs",
		"{views}" = "{app}/views",
		"{models}" = "{app}/models",
	},
	paths = {
		"{components}",
		"{helpers}",
		"{controllers}",
		"{widgets}",
		"{langs}",
		"{views}",
		"{models}",
	},
	components = {
		session = {
			class = "FileSession",
			
		}.merge(require("session-local.os", false)),
		urlManager = {
			class = "UrlManager",
			rules = {
				'<controller:\w+>/<action:\w+>' = '<controller>/<action>',
				'<controller:\w+>/' = '<controller>/',
			},			
		},
		user = {
			class = "GameWebUser",
		},
		db = extends require("db-local.os", false) {}, // hide db user & password while print config
		// db = require("db-local.os", false),
	},
	params = require("config-params.os"),
}