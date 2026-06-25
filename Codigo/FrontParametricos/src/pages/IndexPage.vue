<script setup>
import { ref, onMounted } from "vue";
import { useQuasar } from "quasar";
import { api } from "boot/axios";
import { mostrarMensaje, guardarLogSistema } from "../functions/funciones";

const $q = useQuasar();

const isPwd = ref(true);

const loading1 = ref(false);

const loginRef = ref(null);
const passRef = ref(null);

const usuario = ref("");
const contrasena = ref("");

var correcto = false;

function ValidarUsuario() {
  loading1.value = true;
  mostrarMensaje.value = false;

  loginRef.value.validate();
  passRef.value.validate();

  if (!(loginRef.value.hasError || passRef.value.hasError)) {
    const req = {
      login: usuario.value,
      pass: contrasena.value,
    };

    api
      .post("/usuario/usuariovalidarsesion", req, {
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*",
        },
      })
      .then((response) => {
        var resp = response.data;

        if (resp.resultado == 1) {
          correcto = true;

          $q.localStorage.set("idusuario", resp.usuarios[0].idUsuario);
          $q.localStorage.set("login", resp.usuarios[0].login);
          $q.localStorage.set("apellidos", resp.usuarios[0].apellidos);
          $q.localStorage.set("nombre", resp.usuarios[0].nombre);
          $q.localStorage.set("grupo", resp.usuarios[0].grupo);
          $q.localStorage.set("idgrupo", resp.usuarios[0].idGrupo);
          $q.localStorage.set(
            "iddepartamento",
            resp.usuarios[0].idDepartamento ?? 0
          );
          $q.localStorage.set("idempleado", resp.usuarios[0].idEmpleado ?? 0);

          $q.localStorage.set(
            "idempleado",
            resp.usuarios[0].idEmpleado == null
              ? 0
              : resp.usuarios[0].idEmpleado
          );
          $q.localStorage.set(
            "iddepartamento",
            resp.usuarios[0].idDepartamento == null
              ? 0
              : resp.usuarios[0].idDepartamento
          );
          $q.localStorage.set(
            "idtaller",
            resp.usuarios[0].idTaller == null ? 0 : resp.usuarios[0].idTaller
          );

          guardarLogSistema(
            resp.usuarios[0].idUsuario,
            "/Login",
            "Iniciar Sesión",
            "Usuario inició sesión",
            "Información"
          );

          //Desarrollo
          $q.localStorage.set("urlImagenes", "https://localhost:7081");
          //Certificación ITSSA
          //$q.localStorage.set(
          //  "urlImagenes",
          //  "http://187.188.214.154/APIParametricos"
          //);
          //Certificación SAPAL
          //$q.localStorage.set(
          //  "urlImagenes",
          //  "https://srvndevpilotos.sapal.gob.mx/APIParametricos"
          //);
          //Producción
          //$q.localStorage.set(
          //  "urlImagenes",
          //  "https://srvserviceweb.sapal.gob.mx:500/APIParametricos"
          //);

          //Desarrollo
          $q.localStorage.set("urlPlantillas", "https://localhost:7081");
          //Certificación ITSSA
          //$q.localStorage.set(
          //  "urlPlantillas",
          //  "http://187.188.214.154/APIParametricos"
          //);
          //Certificación SAPAL
          //$q.localStorage.set(
          //  "urlPlantillas",
          //  "https://srvndevpilotos.sapal.gob.mx/APIParametricos"
          //);
          //Producción
          //$q.localStorage.set(
          //  "urlPlantillas",
          //  "https://srvserviceweb.sapal.gob.mx:500/APIParametricos"
          //);

          //Desarrollo
          window.location = "/#/PaginaInicio";
          //Certificación ITSSA
          //window.location = "/Parametricos/#/PaginaInicio";
          //Certificación SAPAL
          //window.location = "/Parametricos/#/PaginaInicio";
          //Producción
          //window.location = "/Parametricos/#/PaginaInicio";
        } else {
          if (!correcto) {
            mostrarMensaje("Iniciar sesión", resp.mensaje, "err");
          }
        }
      })
      .catch((error) => {
        mostrarMensaje("Iniciar sesión", resp.mensaje, "err");
      })
      .finally(() => {
        loading1.value = false;
      });
  }
}

//Eventos
onMounted(() => {
  //if (($q.localStorage.getItem("idusuario") ?? "0") != "0") {
  //  guardarLogSistema(
  //    parseInt($q.localStorage.getItem("idusuario")),
  //    "/Login",
  //    "Iniciar Sesión",
  //    "Usuario inició sesión",
  //    "Información"
  //  );

  //Desarrollo
  window.location = "/#/Operacion/CalcularParametricos";
  //Certificación ITSSA
  //window.location = "/Parametricos/#/PaginaInicio";
  //Certificación SAPAL
  //window.location = "/Parametricos/#/PaginaInicio";
  //Producción
  //window.location = "/Parametricos/#/PaginaInicio";
  //}
});

const handleEnterKey = () => {
  ValidarUsuario();
};
</script>

<template>
  <q-page class="flex flex-center">
    <q-layout view="lHh Lpr lFf">
      <q-page-container>
        <q-page class="flex flex-center bg-grey-2">
          <q-card class="q-pa-md shadow-2 my_card" bordered>
            <q-card-section class="text-center">
              <img src="../assets/logo-sapal.png" /><br /><br />
              <div class="text-grey-9 text-h5 text-weight-bold">
                Iniciar Sesión
              </div>
            </q-card-section>
            <q-card-section>
              <q-input
                dense
                outlined
                v-model="usuario"
                label="Usuario"
                :rules="[(val) => !!val || 'El usuario es requerido']"
                ref="loginRef"
                @keyup.enter="handleEnterKey"
                ><template v-slot:prepend> <q-icon name="person" /> </template
              ></q-input>
              <q-input
                dense
                outlined
                class="q-mt-md"
                v-model="contrasena"
                label="Contraseña"
                :type="isPwd ? 'password' : 'text'"
                :rules="[(val) => !!val || 'La contraseña es requerida']"
                ref="passRef"
                @keyup.enter="handleEnterKey"
                ><template v-slot:prepend> <q-icon name="lock" /> </template
                ><template v-slot:append>
                  <q-icon
                    :name="isPwd ? 'visibility_off' : 'visibility'"
                    class="cursor-pointer"
                    @click="isPwd = !isPwd"
                  /> </template
              ></q-input>
            </q-card-section>
            <q-card-section>
              <q-btn
                style="border-radius: 8px"
                color="primary"
                rounded
                size="md"
                label="Iniciar Sesión"
                no-caps
                class="full-width"
                @click="ValidarUsuario"
                :loading="loading1"
              ></q-btn>
            </q-card-section>
            <q-card-section class="text-center q-pt-none">
              <div class="text-grey-8">
                Si aún no tiene una cuenta, contacte al administrador <br />
                del sistema para que le sea proporcionado el acceso
              </div>
            </q-card-section>
          </q-card>
        </q-page>
      </q-page-container>
    </q-layout>
  </q-page>
</template>

<style lang="sass"></style>
