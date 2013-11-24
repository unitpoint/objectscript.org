var function checkProps(val){
	if(val.hasOwnProperty()){ 
		printf("<%s:%d> ", typeOf(val), val.__id)
		return true
	}
}

function dump(val){
	var dump_recurse_check = {}
	function(val, deep, is_key){
		echo is_key ? "  " * deep : ""
		// don't allow userdata, so let's check exact type
		if(typeOf(val) == "object" || checkProps(val)){
			if(val in dump_recurse_check){
				echo "<<RECURSE>>\n"
			}else{
				dump_recurse_check[val] = true
				echo "{\n"
				for(var k, v in val.dumpIter()){
					_F(k, deep+1, true)
					echo " = "
					_F(v, deep+1)
				}
				echo("  " * deep, "}\n")
			}
		}else{
			echo(val, !is_key ? "\n" : "")
		}
	}(val, 0)
}
