return {
	charset = "utf-8",
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
			classname = "CFileSession",
			
		}.merge(require("session-local.os", false)),
		/* urlManager = {
			classname = "CUrlManager",
		},
		request = {
			classname = "CHttpRequest",
		}, */
		// db = require("db-local.os"),
		db = extends require("db-local.os", false) {}, // hide db user & password while print config
	},
	params = require("config-params.os"),
}