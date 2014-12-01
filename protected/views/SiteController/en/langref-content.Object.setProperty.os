﻿return {
	ret = "void",
	desc = <<<END"
Устанавливает значений свойства объекта. Позволяет отключить использование магических методов.
END,	
	params = {
		name = {
			type = "string",
			desc = "Назвние свойства",
		},
		value = {
			type = "mixed",
			desc = "Новое значение свойства.",
		},
		getterEnabled = {
			type = "boolean",
			def = "false",
			desc = "При необходимости вызывать магические методы для доступа к свойству или нет.",
		},
	},
}