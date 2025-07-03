// scripts/emails/drip.js
import SibApiV3Sdk from 'sib-api-v3-sdk';
const api = new SibApiV3Sdk.TransactionalEmailsApi();
SibApiV3Sdk.ApiClient.instance.authentications['api-key'].apiKey = process.env.SIB_API_KEY;
export default async function sendDrip(to, name) {
  await api.sendTransacEmail({
    sender: { name: 'LuxeEvents', email: 'no-reply@luxeevents.com' },
    to: [{ email: to, name }],
    templateId: 5,
    params: {}
  });
}
