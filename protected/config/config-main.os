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
			class = "FileSession",
			
		}.merge(require("session-local.os", false)),
		urlManager = {
			class = "UrlManager",
			rules = {
				'<action:(langref|download|manual|install)>/<page:[\w\d\.\-]+>.html' = 'site/<action>',
				'' = 'site/index',
				'<action>.html' = 'site/<action>',
				/*
                'articles' = 'post/articles',
                'apps' = 'post/apps',
                'apps/create' = 'profile/createApp',
                'presentations' = 'post/presentations',
                'presentations/create' = 'profile/createPresentation',
                'dreambook' = 'post/dreambook',
                'dreambook/create' = 'post/createDreampost',
                '<title>-p<id:\d+>' = {'post/', 'urlSuffix' = '.html'},
                'posts/<title>-<id:\d+>' = {'post/', 'urlSuffix' = '.html'},
                '<title>~<url:[\w\d\-_]+?>' = {'post/', 'urlSuffix' = '.html'},
                'posts/<title>~<url:[\w\d\-_]+?>' = {'post/', 'urlSuffix' = '.html'},
                'posts/<id:\d+>' = 'post/',
				*/
				// '<controller:\w+>/<action:\w+>' = '<controller>/<action>',
				// '<controller:\w+>/' = '<controller>/',
			},			
		},
		/* request = {
			class = "HttpRequest",
		}, */
		// db = require("db-local.os"),
		db = extends require("db-local.os", false) {}, // hide db user & password while print config
	},
	params = require("config-params.os"),
}