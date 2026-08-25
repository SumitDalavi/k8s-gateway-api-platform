const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({
    service: 'auth-svc',
    status: 'ok'
  }));
});

server.listen(8080, () => {
  console.log('Auth service listening on port 8080');
});
