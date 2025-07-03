import express from 'express';
import client from 'prom-client';
const app = express();
const collectDefaultMetrics = client.collectDefaultMetrics;
collectDefaultMetrics();
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', client.register.contentType);
  res.end(await client.register.metrics());
});
app.listen(3001, () => console.log('📊 Metrics running on http://localhost:3001/metrics'));
