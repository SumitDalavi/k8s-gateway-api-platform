'use strict';
const http = require('http');
const VERSION = process.env.APP_VERSION || 'v2';
const PORT = parseInt(process.env.PORT || '8080', 10);

http.createServer((req, res) => {
  // v2 adds new "features" field to demonstrate version differences
  const body = JSON.stringify({
    version: VERSION,
    path: req.url,
    host: require('os').hostname(),
    features: ['dark-mode', 'new-dashboard', 'faster-api'],
    latency_ms: Math.floor(Math.random() * 20),
  });
  res.writeHead(200, { 'Content-Type': 'application/json', 'X-App-Version': VERSION });
  res.end(body);
}).listen(PORT, () => console.log(`[app-${VERSION}] listening on :${PORT}`));
