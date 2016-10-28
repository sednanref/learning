var fs = require('fs');

var fileContent = fs.readFileSync(process.argv[2], 'UTF-8').split('\n').length - 1;

console.log(fileContent);