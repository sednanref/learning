var pathFilter = require('./my_module.js');

path = process.argv[2];
ext = process.argv[3];

pathFilter(path, ext, function(err, list){
    if (err) {
      console.log(err);
    } else {
      list.forEach(function(listItem) {
        console.log(listItem);
      });
    }
});
