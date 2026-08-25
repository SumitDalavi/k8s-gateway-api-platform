const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({
    service: 'payment-svc',
    status: 'ok'
  }));
});

server.listen(8080, () => {
  console.log('Payment service listening on port 8080');
});
