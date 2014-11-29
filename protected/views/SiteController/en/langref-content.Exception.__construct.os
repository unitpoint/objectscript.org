return {
	ret = "Exception",
	retDesc = <<<END'
Новый экземпляр исключения.
END,
	desc = <<<END"
Инициализирует новый экземпляр исключения.  
END,
	params = {
		message = {
			type = "string",
			desc = "Сообщение об ошибке.",
		},
	},
}