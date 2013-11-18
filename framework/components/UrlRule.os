var trimSlesh = function(s){
	return toString(s).replace{
		[Regexp("#^/+#s")] = "",
		[Regexp("#/+$#s")] = "",
	}
}

UrlRule = extends Component {
	/**
	 * Set [[mode]] with this value to mark that this rule is for URL parsing only
	 */
	const PARSING_ONLY = 1,
	/**
	 * Set [[mode]] with this value to mark that this rule is for URL creation only
	 */
	const CREATION_ONLY = 2,

	__object = {
		/**
		 * @var string the name of this rule. If not set, it will use [[pattern]] as the name.
		 */
		name = null,
		/**
		 * @var string the pattern used to parse and create the path info part of a URL.
		 * @see host
		 */
		pattern = null,
		/**
		 * @var string the pattern used to parse and create the host info part of a URL.
		 * @see pattern
		 */
		host = null,
		/**
		 * @var string the route to the controller action
		 */
		route = null,
		/**
		 * @var array the default GET parameters (name => value) that this rule provides.
		 * When this rule is used to parse the incoming request, the values declared in this property
		 * will be injected into $_GET.
		 */
		defaults = [],
		/**
		 * @var string the URL suffix used for this rule.
		 * For example, ".html" can be used so that the URL looks like pointing to a static HTML page.
		 * If not, the value of [[UrlManager::suffix]] will be used.
		 */
		suffix = null,
		/**
		 * @var string|array the HTTP verb (e.g. GET, POST, DELETE) that this rule should match.
		 * Use array to represent multiple verbs that this rule may match.
		 * If this property is not set, the rule can match any verb.
		 * Note that this property is only used when parsing a request. It is ignored for URL creation.
		 */
		verb = null,
		/**
		 * @var integer a value indicating if this rule should be used for both request parsing and URL creation,
		 * parsing only, or creation only.
		 * If not set or 0, it means the rule is both request parsing and URL creation.
		 * If it is [[PARSING_ONLY]], the rule is for request parsing only.
		 * If it is [[CREATION_ONLY]], the rule is for URL creation only.
		 */
		mode = null,

		/**
		 * @var string the template for generating a new URL. This is derived from [[pattern]] and is used in generating URL.
		 */
		_template = null,
		/**
		 * @var string the regex for matching the route part. This is used in generating URL.
		 */
		_routeRule = null,
		/**
		 * @var array list of regex for matching parameters. This is used in generating URL.
		 */
		_paramRules = [],
		/**
		 * @var array list of parameters used in the route.
		 */
		_routeParams = [],
	},

	/**
	 * Initializes this rule.
	 */
	init = function(){
		@pattern = stringOf(@pattern) || throw InvalidConfigException('UrlRule::pattern must be string.')
		@route = stringOf(@route) || throw InvalidConfigException('UrlRule::route must be string.')
		if (arrayOf(@verb)) {
			for(var i, verb in @verb) {
				@verb[$i] = (stringOf(verb) || throw "string expected in @verb item").upper()
			}
		} else if(@verb) {
			@verb = [(stringOf(@verb) || throw "string expected in @verb").upper()]
		}
		@name = stringOf(@name || @pattern) || throw InvalidConfigException('UrlRule::name must be string.')

		@pattern = trimSlesh(@pattern)

		if (@host = stringOf(@host)) {
			@pattern = @host.replace(Regexp("#/+$#s"), "").."/"..@pattern.replace(Regexp("#/+$#s"), "").."/"
		} elseif (@pattern === '') {
			@_template = ''
			@pattern = '#^$#u'
			return
		} else {
			@pattern = '/' .. @pattern .. '/'
		}

		@route = trimSlesh(@route)
		
		if (@route.find('<')) {
			for (var _, name in Regexp('/<(\w+)>/g').exec(@route)[1]) {
				@_routeParams[name] = "<${name}>"
			}
		}

		var tr, tr2 = [], []
		for(var _, match in Regexp('/<(\w+):?([^>]+)?>/g').exec(@pattern, Regexp.OFFSET_CAPTURE | Regexp.SET_ORDER)) {
			var name, pattern = match[1][0], match[2][0] || '[^\/]+'
			if (@defaults[name]) {
				var length, offset = #match[0][0], match[0][1]
				if (offset > 1 && @pattern[offset - 1] === '/' && @pattern[offset + length] === '/') {
					tr["/<${name}>"] = "(/(?P<${name}>${pattern}))?"
				} else {
					tr["<${name}>"] = "(?P<${name}>${pattern})?"
				}
			} else {
				tr["<${name}>"] = "(?P<${name}>${pattern})"
			}
			if (@_routeParams[name]) {
				tr2["<${name}>"] = "(?P<${name}>${pattern})"
			} else {
				@_paramRules[name] = pattern === '[^\/]+' ? '' : "#^${pattern}$#"
			}
		}
		tr['.'] = '\\.'

		@_template = @pattern.replace(Regexp('/<(\w+):?([^>]+)?>/g'), '<$1>')
		@pattern = '#^' .. trimSlesh(@_template.replace(tr)) .. '$#u'

		if (@_routeParams) {
			@_routeRule = '#^' .. @route.replace(tr2) .. '$#u'
		}
	}

	/**
	 * Parses the given request and returns the corresponding route and parameters.
	 * @param UrlManager $manager the URL manager
	 * @param Request $request the request component
	 * @return array|boolean the parsing result. The route and the parameters are returned as an array.
	 * If null, it means this rule cannot be used to parse this path info.
	 */
	parseRequest = function(manager, request){
		@mode === @CREATION_ONLY && return;
		@verb && !(request.getMethod() in @verb) && return;
		
		var pathInfo = request.getPathInfo()
		var suffix = toString(@suffix || manager.suffix)
		if (suffix !== '' && pathInfo !== '') {
			var n = #suffix
			if (pathInfo.sub(-n) === suffix) {
				pathInfo = pathInfo.sub(0, -n)
				pathInfo === '' && return
			} else {
				return
			}
		}

		@host && pathInfo = request.hostInfo.lower() .. '/' .. pathInfo
		
		matches = Regexp(@pattern).exec(pathInfo) || return;
		for(var name, value in @defaults) {
			if (!matches[name] || matches[name] === '') {
				matches[name] = value
			}
		}
		var params, tr = @defaults, []
		for (var name, value in matches) {
			if (@_routeParams[name]) {
				tr[@_routeParams[name]] = value
				delete params[name]
			} elseif (@_paramRules[name]) {
				params[name] = value
			}
		}
		var route = @_routeRule ? @route.replace(tr) : @route
		return [route, params]
	}

	/**
	 * Creates a URL according to the given route and parameters.
	 * @param UrlManager $manager the URL manager
	 * @param string $route the route. It should not have slashes at the beginning or the end.
	 * @param array $params the parameters
	 * @return string|boolean the created URL, or false if this rule cannot be used for creating this URL.
	 */
	createUrl = function(manager, route, params){
		@mode === @PARSING_ONLY && return;

		var tr = []

		// match the route part first
		if (route !== @route) {
			var matches
			if (@_routeRule && matches = Regexp(@_routeRule).exec(route)) {
				for (var name, token in @_routeParams) {
					if (@defaults[name] && @defaults[name] == matches[name]) {
						tr[token] = ''
					} else {
						tr[token] = matches[name]
					}
				}
			} else {
				return
			}
		}

		// match default params
		// if a default param is not in the route pattern, its value must also be matched
		for (var name, value in @defaults) {
			@_routeParams[name] && continue
			!params[name] && return;
			if (params[name] == value) { // strcmp will do string conversion automatically
				delete params[name]
				@_paramRules[name] && tr["<${name}>"] = ''
			} elseif (!@_paramRules[name]) {
				return
			}
		}

		// match params in the pattern
		for (var name, rule in @_paramRules) {
			if (params[name] && (rule === '' || Regexp(rule).test(params[name]))) {
				tr["<${name}>"] = _E.url.encode(params[name])
				delete params[name]
			} elseif (!@defaults[name] || params[name]) {
				return
			}
		}

		var url = trimSlesh(@_template.replace($tr))
		if (@host) {
			var pos = url.find('/', 8)
			if (pos) {
				url = url.sub(0, pos) .. url.sub(pos).replace(Regexp('#/+#'), '/')
			}
		} elseif (url.find('//')) {
			url = url.replace(Regexp('#/+#'), '/')
		}

		url !== ''	&& url = url .. (@suffix || manager.suffix)
		params 		&& url = url .. '?' .. _E.url.buildQuery(params)
		return url
	}
}
