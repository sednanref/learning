var fs = require('fs');

module.exports = function(path, extention, callback) {

  fs.readdir(path, function(err, list) {
    callbackList = [];
    if(err){
      return callback(err);
    } else {
      list.forEach(function(file){
        if(file.split('.')[1] === extention) {
          callbackList.push(file);
        }
      });
      callback(null, callbackList);
    }
  });

}
