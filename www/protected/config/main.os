return {
	charset = "utf8",
	lang = "ru",
	// defaultController = "game",
	aliases = {
		"{componets}" = "{app}/componets",
		"{helpers}" = "{app}/helpers",
		"{controllers}" = "{app}/controllers",
		"{views}" = "{app}/views",
	},
	paths = {
		"{componets}",
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