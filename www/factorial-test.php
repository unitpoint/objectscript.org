<?php

function factorial($a)
{
	return $a <= 1 ? 1 : $a*factorial($a-1);
}

$num = 20;
for($i = 0; $i < 500; $i++){
	echo sprintf("[step %d] calculate factorial of %d = %s<br />", $i, $num, factorial($num));
}