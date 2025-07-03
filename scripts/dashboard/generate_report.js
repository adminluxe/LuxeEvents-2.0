// scripts/dashboard/generate_report.js
// Exemple simplifié : collecte GA4 via BigQuery et emails via Sendinblue
import { BigQuery } from '@google-cloud/bigquery';
import SibApiV3Sdk from 'sib-api-v3-sdk';

async function fetchGA4() {
  const bq = new BigQuery();
  const [rows] = await bq.query({
    query: `SELECT event_name, COUNT(*) as count FROM \`myproject.ga4.events\`
            WHERE event_date BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
            GROUP BY event_name;`
  });
  return rows;
}

async function fetchEmailStats() {
  const api = new SibApiV3Sdk.TransactionalEmailsApi();
  SibApiV3Sdk.ApiClient.instance.authentications['api-key'].apiKey = process.env.SIB_API_KEY;
  const stats = await api.getTransacEmailsReport('2025-07-01', '2025-07-31');
  return stats;
}

(async ()=> {
  const ga4 = await fetchGA4();
  const email = await fetchEmailStats();
  console.log('➡️ GA4 events:', ga4);
  console.log('➡️ Email stats:', email);
  // Ici : formate en CSV/JSON ou pousse dans Notion/Slack/Email
})();
