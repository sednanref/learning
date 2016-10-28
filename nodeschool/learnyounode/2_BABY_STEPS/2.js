var a = 0;

numbers = process.argv.splice(2);

numbers.forEach(function(number){
	a = a + parseInt(number);
});

console.log(a);
