FormGroupWidget = extends Widget {
	model = null,
	attribute = null,
	inputType = null,
	showState = true,
	
	run = function(){
		echo @renderPartial("{widgets}/views/FormGroupWidget", {
			model = @model,
			attribute = @attribute,
			inputType = @inputType || (@attribute === "email" || @attribute === "password") && @attribute,
			showState = @showState,
		})
	},
}