return {
	charset = "utf8",
	lang = "ru",
	// defaultController = "game",
	aliases = {
		"{components}" = "{app}/components",
		"{helpers}" = "{app}/helpers",
		"{controllers}" = "{app}/controllers",
		"{views}" = "{app}/views",
	},
	paths = {
		"{components}",
		"{helpers}",
		"{app}/langs",
		"{controllers}",
		"{views}",
	},
	components = {
		urlManager = {
		
		},
		request = {
			classname = "HttpRequest",
		},
		db = {
			classname = "DbConnection",
			tablePrefix = "ox_",
			type = "mysql",
			params = {
				user = "root",
				// password = "",
				dbname = "oxsar3-loc"			
			},
		},
	},
	params = {
		
	},
}