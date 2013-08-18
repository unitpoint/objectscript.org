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
			classname = "HttpRequest"
		},
	},
	params = {
		
	},
}