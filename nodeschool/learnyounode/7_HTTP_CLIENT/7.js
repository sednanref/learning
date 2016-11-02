var http = require('http');

http.get(process.argv[2], (res) => {
  res.setEncoding('UTF-8');
  res.on("data", (data) => {
    console.log(data);
  });
});
