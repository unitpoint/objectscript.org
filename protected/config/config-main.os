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
	},
	paths = {
		"{components}",
		"{helpers}",
		"{controllers}",
		"{views}",
		"{langs}",
	},
	components = {
		urlManager = {
		
		},
		request = {
			classname = "HttpRequest",
		},
		db = require("db-local.os"),
	},
	params = {
		CLIENT_VERSION = 2,
	},
}