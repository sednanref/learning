var http = require('http');
var url1 = process.argv[2];
var url2 = process.argv[3];
var url3 = process.argv[4];
pagedata1="";
pagedata2="";
pagedata3="";
callbackcounter=0;

var printout = function (){
  console.log(pagedata1);
  console.log(pagedata2);
  console.log(pagedata3);
};


http.get(url1, function(response){
  response.setEncoding("utf8");
  response.on("data", function(data) {
    pagedata1+=data;
});
  response.on("end", function(){
    callbackcounter+=1;
    if (callbackcounter==3){
      printout();
}});
});

http.get(url2, function(response){
  response.setEncoding("utf8");
  response.on("data", function(data) {
    pagedata2+=data;
});
  response.on("end", function(){
    callbackcounter+=1;
    if (callbackcounter==3){
      printout();
}});
});

http.get(url3, function(response){
  response.setEncoding("utf8");
  response.on("data", function(data) {
    pagedata3+=data;
});
  response.on("end", function(){
    callbackcounter+=1;
    if (callbackcounter==3){
      printout();
}
});
});

/*
var http = require('http')
     var bl = require('bl')
     var results = []
     var count = 0

     function printResults () {
       for (var i = 0; i < 3; i++) {
         console.log(results[i])
       }
     }

     function httpGet (index) {
       http.get(process.argv[2 + index], function (response) {
         response.pipe(bl(function (err, data) {
           if (err) {
             return console.error(err)
           }

           results[index] = data.toString()
           count++

           if (count === 3) {
             printResults()
           }
         }))
       })
     }

     for (var i = 0; i < 3; i++) {
       httpGet(i)
     }
*/
