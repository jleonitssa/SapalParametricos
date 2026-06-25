import { boot } from "quasar/wrappers";
import axios from "axios";

// Be careful when using SSR for cross-request state pollution
// due to creating a Singleton instance here;
// If any client changes this (global) instance, it might be a
// good idea to move this instance creation inside of the
// "export default () => {}" function below (which runs individually
// for each client)

//Desarrollo
const api = axios.create({ baseURL: "https://localhost:7081" });
//Certificación ITSSA
//const api = axios.create({
//  baseURL: "http://187.188.214.154/APIParametricos",
//});
//Certificación SAPAL
//const api = axios.create({
//  baseURL: "https://srvndevpilotos.sapal.gob.mx/APIParametricos",
//});
//Producción
//const api = axios.create({
//  baseURL: "https://srvserviceweb.sapal.gob.mx:500/APIParametricos",
//});

export default boot(({ app }) => {
  // for use inside Vue files (Options API) through this.$axios and this.$api

  app.config.globalProperties.$axios = axios;
  // ^ ^ ^ this will allow you to use this.$axios (for Vue Options API form)
  //       so you won't necessarily have to import axios in each vue file

  app.config.globalProperties.$api = api;
  // ^ ^ ^ this will allow you to use this.$api (for Vue Options API form)
  //       so you can easily perform requests against your app's API
});

export { api };
