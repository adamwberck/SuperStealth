function random_power(x0, x1, n){
	return power( (power(x1, n+1) - power(x0, (+1))*random(1) + power(x0, n+1) ), (1/(n+1)) )
}