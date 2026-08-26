'use strict';
const http = require('http');
const VERSION = process.env.APP_VERSION || 'v1';
const PORT = parseInt(process.env.PORT || '8080', 10);

http.createServer((req, res) => {
  const body = JSON.stringify({ version: VERSION, path: req.url, host: require('os').hostname() });
  res.writeHead(req.url === '/health' ? 200 : 200, { 'Content-Type': 'application/json', 'X-App-Version': VERSION });
  res.end(body);
}).listen(PORT, () => console.log(`[app-${VERSION}] listening on :${PORT}`));
