function fib(n){
  var a, b, r = 0, 1, [0];
  for(; b < n;){
	r.push(b);
	a, b = b, a+b;
  }
  return r;
}
print(fib(100));
