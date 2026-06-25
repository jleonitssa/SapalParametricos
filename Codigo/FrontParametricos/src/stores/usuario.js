import { defineStore } from "pinia";

export const useUsuarioStore = defineStore("usuario", {
  state: () => ({
    idusuario: 0,
    login: "",
    nombre: "",
    apellidopaterno: "",
    apellidomaterno: "",
    idgrupo: 0,
    grupo: "",
    iniciosesion: "",
  }),

  getters: {},

  actions: {},
});
