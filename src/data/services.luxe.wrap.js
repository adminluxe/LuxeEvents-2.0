import * as S from './services.luxe.js';
const services =
  (S && (S.services || S.default || S.luxeServices || S.data)) || [];
export { services };
export default services;
