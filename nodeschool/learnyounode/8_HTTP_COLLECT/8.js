var http = require('http');

http.get(process.argv[2], (response) => {
  response.setEncoding('UTF-8');
  content = '';
  response.on('data', (data) => {
    content += data;
  });
  response.on('end', () => {
    console.log(content.length);
    console.log(content);
  })
});
