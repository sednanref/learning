var fs = require('fs');
var content = "";
fs.readFile(process.argv[2], 'UTF-8', function(err, chunk){
  if(err) {
    return console.log(err);
  }
  console.log(chunk.split('\n').length -1);
});
