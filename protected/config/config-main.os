return {
	charset = "utf-8",
	lang = "ru",
	// defaultController = "game",
	aliases = {
		"{components}" = "{app}/components",
		"{helpers}" = "{app}/helpers",
		"{controllers}" = "{app}/controllers",
		"{views}" = "{app}/views",
		"{langs}" = "{app}/langs",
		"{widgets}" = "{app}/widgets",
	},
	paths = {
		"{components}",
		"{helpers}",
		"{controllers}",
		"{views}",
		"{langs}",
		"{widgets}",
	},
	components = {
		session = {
			classname = "FileSession",
			
		}.merge(require("session-local.os", false)),
		urlManager = {
		
		},
		request = {
			classname = "HttpRequest",
		},
		// db = require("db-local.os"),
		db = extends require("db-local.os") {}, // hide db user & password while print config
	},
	params = require("config-params.os"),
}