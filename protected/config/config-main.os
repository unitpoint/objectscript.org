return {
	charset = "utf-8",
	baseLang = "ru",
	lang = "ru",
	// defaultController = "game",
	aliases = {
		"{app}" = path.dirname(__DIR__),
		"{components}" = "{app}/components",
		"{helpers}" = "{app}/helpers",
		"{controllers}" = "{app}/controllers",
		"{widgets}" = "{app}/widgets",
		"{langs}" = "{app}/langs",
		"{views}" = "{app}/views",
	},
	paths = {
		"{components}",
		"{helpers}",
		"{controllers}",
		"{widgets}",
		"{langs}",
		"{views}",
	},
	components = {
		session = {
			class = "FileSession",
			
		}.merge(require("session-local.os", false)),
		urlManager = {
			class = "OSMultiLangUrlManager",
			ruleClass = 'OSMultiLangUrlRule',
			rules = {
				'<action:(langref|download|manual|install)>/<page:[\w\d\.\-]+>.html' = 'site/<action>',
				'' = 'site/index',
				'<action>.html' = 'site/<action>',
				// '<controller:\w+>/<action:\w+>' = '<controller>/<action>',
				// '<controller:\w+>/' = '<controller>/',
			},			
		},
		request = {
			class = "OSMultiLangHttpRequest",
		},
		// db = require("db-local.os"),
		db = extends require("db-local.os", false) {}, // hide db user & password while print config
	},
	params = require("config-params.os"),
}