function dump(val){
	var dump_recurse_check = {}
	var function checkProps(val){
		if(val.hasOwnProperty()){ 
			printf("<%s:%d> ", typeOf(val), val.id)
			return true
		}
	}
	function(val, deep, is_key){
		echo is_key ? "  " * deep : ""
		if(objectOf(val) || checkProps(val)){
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
