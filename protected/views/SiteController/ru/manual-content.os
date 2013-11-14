return {
	"getting-started" = {
		"Приступая к работе", {
			intro = {
				"Введение", {
					"intro.whatisos" = "Что такое OS?",
					"intro.whatcando" = "Возможности OS",
					"intro.utf8support" = "Поддержка UTF-8 в OS",
				},
			},
			tutorial = {
				"Простой учебник", {
					"tutorial.firstpage" = "Первая страница на OS",
					"tutorial.useful" = "Делаем что-нибудь полезное",
					"tutorial.forms" = "Работа с формами",
				},
			},
		}
	},
	/* install = {
		"Установка и настройка", 
		url = {controller="site", action="install"},
	}, */
	"langref.basic-syntax" = {
		"Основы синтаксиса", {
			"langref.basic-syntax.tags" = "Теги OS",
			"langref.basic-syntax.html" = "Изолирование от HTML",
			"langref.basic-syntax.separation" = "Пробелы и точки с запятой",
			"langref.basic-syntax.comments" = "Комментарии",
			"langref.basic-syntax.concat" = "Конкатецация строк",
			"langref.basic-syntax.functions-call" = {
				"Вызов функции", {
					"langref.basic-syntax.functions-call.intro" = "Введение",
					"langref.basic-syntax.functions-call.common" = "Обычный вызов функции",
					"langref.basic-syntax.functions-call.object" = "Вызов функции с одним параметром - объектом",
					"langref.basic-syntax.functions-call.chain" = "Цепочный вызов",
					"langref.basic-syntax.functions-call.auto" = "Автоматический вызов функции с одним параметром",
					"langref.basic-syntax.functions-call.ret-as-func" = "Вызов результата функции",
				},
			},
			// string concat
			"langref.basic-syntax.output" = {
				"Функции вывода информации", {
					"langref.basic-syntax.output-intro" = "Введение",
					"langref.basic-syntax.output.echo" = "echo",
					"langref.basic-syntax.output.print" = "print",
					"langref.basic-syntax.output.printf" = "printf",
				},
			},
		},
	},
	langref = {
		"Справочник языка", {
			"langref.types" = {
				"Типы", {
					"langref.types.intro" = "Введение",
					"langref.types.bool" = "Булев",
					"langref.types.number" = "Числа",
					"langref.types.string" = "Строки",
					"langref.types.array" = "Массивы",
					"langref.types.object" = "Объекты",
					"langref.types.function" = "Функции",					
					// "langref.types.userdata" = "Данные из C++",
					"langref.types.null" = "Пустое значение (null)",
				},
			},
			"langref.variables" = {
				"Переменные", {
					"langref.variables.basics" = "Основы",
					"langref.variables.predefined" = "Предопределенные переменные",
					"langref.variables.scope" = "Область видимости переменной",
					"langref.variables.external" = "Переменные извне OS",
				},
			},
			"langref.constants.predefined" = "Волшебные константы",
			// "langref.expressions" = "Выражения",
			"langref.operators" = {
				"Операторы", {
					"langref.operators.precedence" = "Приоритет операторов",
					"langref.operators.assignment" = "Оператор присваивания",
					"langref.operators.arithmetic" = "Арифметические операторы",
					"langref.operators.bitwise" = "Побитовые операторы",
					"langref.operators.comparison" = "Операторы сравнения",
					"langref.operators.increment" = "Операторы инкремента и декремента",
					"langref.operators.logical" = "Логические операторы",
					"langref.operators.special" = {
						"Специальные операторы", {
							"langref.operators.ternary" = "Тернарный оператор (? :)",
							"langref.operators.concat" = "Строковый оператор (..)",
							"langref.operators.len" = "Оператор длины (#)",
							"langref.operators.type" = "Оператор проверки типа (is)",
							"langref.operators.in" = "Оператор вхождения (in)",
							"langref.operators.delete" = "Оператор удаления элемента (delete)",
							// "langref.operators.arguments" = "Операторы получения аргументов",
							"langref.operators.extends" = "Оператор расширения класса (extends)",
						},
					},
				},
			},
			"langref.control-structures" = {
				"Управляющие конструкции", {
					// "langref.control-structures.intro" = "Введение",
					"langref.control-structures.if" = "if / else / elseif",
					"langref.control-structures.for" = "for / for in",
					"langref.control-structures.break" = "break / continue",
					"langref.control-structures.return" = "return",
				},
			},
			"langref.functions" = {
				"Функции", {
					"langref.functions.arguments" = "Аргументы функции",
					"langref.functions.anonymous" = "Анонимные функции",
					"langref.functions.first-class" = "Функции первого класса",
					"langref.functions.returning-values" = "Возврат значений",
					"langref.functions.closures" = "Вложенные функции и замыкания",
					"langref.functions.sugar" = "Немного сахара",
					// окружение функции - _E
				},
			},
			"langref.oop" = {
				"ООП", {
					"langref.oop.intro" = "Введение",
					"langref.oop.basics" = "Основы",
					"langref.oop.std" = "Стандартные классы",
					"langref.oop.new" = "Создание экземпляра объекта",
					"langref.oop.inheritance-encapsulation" = "Наследование и Инкапсуляции",
					"langref.oop.properties" = {
						"Свойства", {
							"langref.oop.properties.intro" = "Введение",
							"langref.oop.properties.named" = "Именованный геттер/сеттер",
							"langref.oop.properties.common" = "Общий геттер/сеттер",
							"langref.oop.properties.dim" = "Многомерные свойства",
							"langref.oop.properties.empty" = "Пустое свойство",
							"langref.oop.properties.delete" = {
								"Удаление свойств", {
									"langref.oop.properties.delete.syntax" = "Синтаксис",
									"langref.oop.properties.delete.named" = "Именованное удаление свойства",
									"langref.oop.properties.delete.common" = "Общее удаление свойства",
									"langref.oop.properties.delete.dim" = "Удаление многомерного свойства",
									"langref.oop.properties.delete.empty" = "Удаление пустого свойства",
								},
							},
							"langref.oop.properties.isset" = "Проверка существования свойства",
						},
					},
					// "langref.oop.constructor" = "Конструкторы и деструкторы",
					"langref.oop.iterations" = "Итерация",
					"langref.oop.magic-methods" = "Магические методы",
					"langref.oop.clone" = "Клонирование объектов",
					"langref.oop.type-check" = "Контроль типа",
					"langref.oop.sugar-this" = "Сахарный this",
					"langref.oop.autoload" = "Автоматическая загрузка классов",
					// __object
					// super call, super access
					// Number.times
				},
			},
			"langref.include-files" = "Механизм подключения файлов",
			"langref.exceptions" = "Исключения",
			"langref.intergation-cpp" = {
				"Интеграция с C++", {
					"langref.intergation-cpp.classes" = "Подключение классов из C++",
				},
			},
			// "langref.name-convention" = "Соглашение об именовании",
			"langref.modules-and-classes" = "Модули и классы",
		},
	},
	"langref.os-files" = "Файлы osh, os, osc, ost",
}