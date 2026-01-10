/**
 * Wrapper tolérant : évite les warnings Rollup "is not exported".
 * On importe tout le module puis on choisit la meilleure source dispo.
 */
import * as mod from "./services.luxe.js";

const services =
  mod.services ??
  mod.luxeServices ??
  mod.data ??
  mod.default ??
  [];

export { services };
export default services;
