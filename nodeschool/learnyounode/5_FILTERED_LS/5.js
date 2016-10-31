var fs = require('fs');

fs.readdir(process.argv[2], function(err, list) {
  list.forEach(function(elem) {
    var ext = elem.split('.')[1];
    if(ext === process.argv[3]) {
      console.log(elem);
    }
  });
});
