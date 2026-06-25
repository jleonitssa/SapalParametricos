<script lang="ts" setup>
//Imports
import { ref, onMounted } from "vue";
import { api } from "boot/axios";
import { useQuasar } from "quasar";
import {
  mostrarMensaje,
  guardarLogSistema,
  revisarPermisos,
} from "../functions/funciones";

const $q = useQuasar();

const registro = ref({
  idConfiguracion: 1,
  tiempoCierreSesion: 20,
  smtp: "",
  puerto: 21,
  ssl: true,
  usuario: "",
  contrasena: "",
  minimoCaracteres: 1,
  minimoMayusculas: 1,
  minimoMinusculas: 1,
  minimoNumeros: 1,
  minimoCarEspecial: 1,
  intentosPassword: 3,
  correoBienvenida: "",
  correoRegenerar: "",
  correoNotificacionCita: "",
  tallerTrabajaSabado: false,
  correoCancelacionCita: "",
  correoRecepcionUnidad: "",
  correoProrrogaUnidad: "",
  correoEntregaUnidad: "",
  correoTerminoUnidad: "",
  correoRecordatorio: "",
  correoCancelacionManual: "",
  diasAntesRecordatorio: 0,
  tipoEnvioCorreo: 0,
  usuarioServicioCorreo: "",
  contrasenaServicioCorreo: "",
  tokenBotTelegram: "",
  apiKeyGPS: "",
  apiKeyGRP: "",
  fromCorreoSistema: "",
  correoTerminoTaller: "",
  correoOrdenTrabajo: "",
  correoOrdenTrabajoAprobado: "",
  correoOrdenTrabajoRechazado: "",
  emailAlmacen: "",
});

const refCaracteres = ref(null);
const refMayusculas = ref(null);
const refMinusculas = ref(null);
const refNumeros = ref(null);
const refCarespecial = ref(null);
const refIntentos = ref(null);
const refDiasNotificacion = ref(null);

const refSmtp = ref(null);
const refPuerto = ref(null);
const refUsuario = ref(null);
const refContrasena = ref(null);

const opcionesTipoEnvio = ref([
  {
    id: 1,
    nombre: "SMTP Externo",
  },
  {
    id: 2,
    nombre: "Servicio SAPAL",
  },
]);
const modelTipoEnvio = ref({
  id: 1,
  nombre: "SMTP Externo",
});

//Permisos
const permGuardar = ref(false);

//Llamadas a servidor
function cargarConfiguracion() {
  const req = {};

  return api
    .post("/configuracion/ConfiguracionSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        registro.value = resp.configs[0];

        modelTipoEnvio.value = opcionesTipoEnvio.value.filter((ob) => {
          return ob.id == registro.value.tipoEnvioCorreo;
        })[0];
      } else {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    })
    .finally(() => {});
}

//Otras funciones
function validarFormulario() {
  refCaracteres.value.validate();
  refMayusculas.value.validate();
  refMinusculas.value.validate();
  refNumeros.value.validate();
  refCarespecial.value.validate();
  refIntentos.value.validate();
  refSmtp.value.validate();
  refPuerto.value.validate();
  refUsuario.value.validate();
  refContrasena.value.validate();
  refDiasNotificacion.value.validate();

  return !(
    refCaracteres.value.hasError ||
    refMayusculas.value.hasError ||
    refMinusculas.value.hasError ||
    refNumeros.value.hasError ||
    refCarespecial.value.hasError ||
    refIntentos.value.hasError ||
    refSmtp.value.hasError ||
    refPuerto.value.hasError ||
    refUsuario.value.hasError ||
    refContrasena.value.hasError ||
    refDiasNotificacion.value.hasError
  );
}

//Eventos
onMounted(() => {
  cargarConfiguracion();

  revisarPermisos(
    $q.localStorage.getItem("idgrupo"),
    "/Configuracion/PantallaDetalle",
    permGuardar,
    "Guardar"
  );
});

function onClickGuardar() {
  if (validarFormulario()) {
    const req = {
      tiempoCierreSesion: 30,
      smtp: registro.value.smtp,
      puerto: registro.value.puerto,
      ssl: registro.value.ssl,
      usuario: registro.value.usuario,
      contrasena: registro.value.contrasena,
      minimoCaracteres: registro.value.minimoCaracteres,
      minimoMayusculas: registro.value.minimoMayusculas,
      minimoMinusculas: registro.value.minimoMinusculas,
      minimoNumeros: registro.value.minimoNumeros,
      minimoCarEspecial: registro.value.minimoCarEspecial,
      intentosPassword: registro.value.intentosPassword,
      correoBienvenida: registro.value.correoBienvenida,
      correoRegenerar: registro.value.correoRegenerar,
      correoNotificacionCita: registro.value.correoNotificacionCita,
      tallerTrabajaSabado: registro.value.tallerTrabajaSabado,
      correoCancelacionCita: registro.value.correoCancelacionCita,
      correoRecepcionUnidad: registro.value.correoRecepcionUnidad,
      correoProrrogaUnidad: registro.value.correoProrrogaUnidad,
      correoEntregaUnidad: registro.value.correoEntregaUnidad,
      correoTerminoUnidad: registro.value.correoTerminoUnidad,
      correoRecordatorio: registro.value.correoRecordatorio,
      correoCancelacionManual: registro.value.correoCancelacionManual,
      diasAntesRecordatorio: registro.value.diasAntesRecordatorio,
      tipoEnvioCorreo: modelTipoEnvio.value.id,
      usuarioServicioCorreo: registro.value.usuarioServicioCorreo,
      contrasenaServicioCorreo: registro.value.contrasenaServicioCorreo,
      tokenBotTelegram: registro.value.tokenBotTelegram,
      apiKeyGPS: registro.value.apiKeyGPS,
      apiKeyGRP: registro.value.apiKeyGRP,
      fromCorreoSistema: registro.value.fromCorreoSistema,
      correoTerminoTaller: registro.value.correoTerminoTaller,
      correoOrdenTrabajo: registro.value.correoOrdenTrabajo,
      correoOrdenTrabajoAprobado: registro.value.correoOrdenTrabajoAprobado,
      correoOrdenTrabajoRechazado: registro.value.correoOrdenTrabajoRechazado,
      emailAlmacen: registro.value.emailAlmacen,
    };

    //console.log(req);

    api
      .post("/configuracion/configuracionUpdate", req, {
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*",
        },
      })
      .then((response) => {
        var resp = response.data;

        if (resp.resultado > 0) {
          guardarLogSistema(
            $q.localStorage.getItem("idusuario"),
            "/Configuracion/ConfiguracionConfiguracion",
            "Guardar configuración",
            "Configuración guardada con éxito",
            "Información"
          );
        } else {
          mostrarMensaje(
            "Guardar configuración",
            "Ocurrió un error al guardar la configuración: " + resp.mensaje,
            "err"
          );
        }
      })
      .catch((error) => {
        mostrarMensaje(
          "Guardar configuración",
          "Ocurrió un error al guardar la configuración: " + error,
          "err"
        );
      });
  }
}
</script>

<template>
  <q-page class="bg-grey-3 items-center qpage">
    <q-card class="q-pa-md mi-card" bordered
      ><q-card-section>
        <div class="text-h6">Configuración de Contraseña</div>
      </q-card-section>
      <q-separator />
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-6 col-md-3">
            <q-input
              color="primary"
              v-model="registro.minimoCaracteres"
              outlined
              label="No. mínimo de caracteres"
              type="number"
              ref="refCaracteres"
              :rules="[(val) => !!val || 'El campo es requerido']"
            ></q-input>
          </div>
          <div class="q-pa-sm col-6 col-md-3">
            <q-input
              color="primary"
              v-model="registro.minimoMayusculas"
              outlined
              label="No. mínimo de mayúsculas"
              type="number"
              ref="refMayusculas"
              :rules="[(val) => !!val || 'El campo es requerido']"
            ></q-input>
          </div>
          <div class="q-pa-sm col-6 col-md-3">
            <q-input
              color="primary"
              v-model="registro.minimoMinusculas"
              outlined
              label="No. mínimo de minúsculas"
              type="number"
              ref="refMinusculas"
              :rules="[(val) => !!val || 'El campo es requerido']"
            ></q-input>
          </div>
          <div class="q-pa-sm col-6 col-md-3">
            <q-input
              color="primary"
              v-model="registro.minimoNumeros"
              outlined
              label="No. mínimo de números"
              type="number"
              ref="refNumeros"
              :rules="[(val) => !!val || 'El campo es requerido']"
            ></q-input>
          </div>
        </div>
        <div class="row">
          <div class="q-pa-sm col-6 col-md-3">
            <q-input
              color="primary"
              v-model="registro.minimoCarEspecial"
              outlined
              label="No. mínimo de car. especiales"
              type="number"
              ref="refCarespecial"
              :rules="[(val) => !!val || 'El campo es requerido']"
            ></q-input>
          </div>
          <div class="q-pa-sm col-6 col-md-3">
            <q-input
              color="primary"
              v-model="registro.intentosPassword"
              outlined
              label="No. de intentos antes de bloqueo"
              type="number"
              ref="refIntentos"
              :rules="[(val) => !!val || 'El campo es requerido']"
            ></q-input>
          </div>
        </div>
      </q-card-section>
      <q-card-section>
        <div class="text-h6">Configuración de Taller</div>
      </q-card-section>
      <q-separator />
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-6 col-md-3">
            <q-toggle
              label="¿Se permite registrar citas en sábado?"
              v-model="registro.tallerTrabajaSabado"
              left-label
            ></q-toggle>
          </div>
          <div class="q-pa-sm col-6 col-md-3">
            <q-input
              color="primary"
              v-model="registro.diasAntesRecordatorio"
              outlined
              label="Días para recordatorio de cita"
              type="number"
              ref="refDiasNotificacion"
              :rules="[(val) => !!val || 'El campo es requerido']"
            ></q-input>
          </div>
        </div>
      </q-card-section>
      <q-card-section>
        <div class="text-h6">Configuración de Correo Electrónico</div>
      </q-card-section>
      <q-separator />
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-6 col-md-3">
            <q-select
              outlined
              v-model="modelTipoEnvio"
              :options="opcionesTipoEnvio"
              label="Tipo de Envío de Correo"
              option-label="nombre"
              option-value="id"
            />
          </div>
        </div>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-6">
            <q-input
              color="primary"
              v-model="registro.smtp"
              outlined
              label="SMTP"
              clearable
              clear-icon="close"
              ref="refSmtp"
              :rules="[(val) => !!val || 'El campo es requerido']"
            ></q-input>
          </div>
          <div class="q-pa-sm col-6 col-md-3">
            <q-input
              color="primary"
              v-model="registro.puerto"
              outlined
              label="Puerto"
              type="number"
              ref="refPuerto"
              :rules="[(val) => !!val || 'El campo es requerido']"
            ></q-input>
          </div>
          <div class="q-pa-sm col-6 col-md-3">
            <q-toggle
              color="primary"
              v-model="registro.ssl"
              label="¿Usa SSL?"
            ></q-toggle>
          </div>
        </div>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-6">
            <q-input
              color="primary"
              v-model="registro.fromCorreoSistema"
              outlined
              label="Remitente (From)"
              clearable
              clear-icon="close"
            ></q-input>
          </div>
          <div class="q-pa-sm col-6 col-md-3">
            <q-input
              color="primary"
              v-model="registro.usuario"
              outlined
              label="Usuario"
              clearable
              clear-icon="close"
              ref="refUsuario"
              :rules="[(val) => !!val || 'El campo es requerido']"
            ></q-input>
          </div>
          <div class="q-pa-sm col-6 col-md-3">
            <q-input
              color="primary"
              v-model="registro.contrasena"
              outlined
              label="Contraseña"
              clearable
              clear-icon="close"
              ref="refContrasena"
              type="password"
              :rules="[(val) => !!val || 'El campo es requerido']"
            ></q-input>
          </div>
        </div>
        <div class="row">
          <div class="q-pa-sm col-6 col-md-3">
            <q-input
              color="primary"
              v-model="registro.usuarioServicioCorreo"
              outlined
              label="Usuario de Servicio Correo"
              clearable
              clear-icon="close"
            ></q-input>
          </div>
          <div class="q-pa-sm col-6 col-md-3">
            <q-input
              color="primary"
              v-model="registro.contrasenaServicioCorreo"
              outlined
              label="Contraseña de Servicio Correo"
              clearable
              clear-icon="close"
              type="password"
            ></q-input>
          </div>
        </div>
      </q-card-section>
      <q-card-section>
        <div class="text-h6">Configuración de API's</div>
      </q-card-section>
      <q-separator />
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-4 col-md-4">
            <q-input
              color="primary"
              v-model="registro.tokenBotTelegram"
              outlined
              label="Token Bot Telegram"
              clearable
              clear-icon="close"
            ></q-input>
          </div>
          <div class="q-pa-sm col-4 col-md-4">
            <q-input
              color="primary"
              v-model="registro.apiKeyGPS"
              outlined
              label="API Key GPS"
              clearable
              clear-icon="close"
            ></q-input>
          </div>
          <div class="q-pa-sm col-4 col-md-4">
            <q-input
              color="primary"
              v-model="registro.apiKeyGRP"
              outlined
              label="API Key GRP"
              clearable
              clear-icon="close"
            ></q-input>
          </div>
        </div>
      </q-card-section>

      <q-card-section>
        <div class="text-h6">Configuración de Mensajes</div>
      </q-card-section>
      <q-separator />
      <q-card-section>
        <div class="text-h7">Correo de Bienvenida</div>
      </q-card-section>
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-12">
            <q-editor
              v-model="registro.correoBienvenida"
              :dense="$q.screen.lt.md"
              :toolbar="[
                [
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    list: 'only-icons',
                    options: ['left', 'center', 'right', 'justify'],
                  },
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    options: ['left', 'center', 'right', 'justify'],
                  },
                ],
                [
                  'bold',
                  'italic',
                  'strike',
                  'underline',
                  'subscript',
                  'superscript',
                ],
                ['token', 'hr', 'link', 'custom_btn'],
                ['print', 'fullscreen'],
                [
                  {
                    label: $q.lang.editor.formatting,
                    icon: $q.iconSet.editor.formatting,
                    list: 'no-icons',
                    options: ['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'code'],
                  },
                  {
                    label: $q.lang.editor.fontSize,
                    icon: $q.iconSet.editor.fontSize,
                    fixedLabel: true,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'size-1',
                      'size-2',
                      'size-3',
                      'size-4',
                      'size-5',
                      'size-6',
                      'size-7',
                    ],
                  },
                  {
                    label: $q.lang.editor.defaultFont,
                    icon: $q.iconSet.editor.font,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'default_font',
                      'arial',
                      'arial_black',
                      'comic_sans',
                      'courier_new',
                      'impact',
                      'lucida_grande',
                      'times_new_roman',
                      'verdana',
                    ],
                  },
                  'removeFormat',
                ],
                ['quote', 'unordered', 'ordered', 'outdent', 'indent'],

                ['undo', 'redo'],
                ['viewsource'],
              ]"
              :fonts="{
                arial: 'Arial',
                arial_black: 'Arial Black',
                comic_sans: 'Comic Sans MS',
                courier_new: 'Courier New',
                impact: 'Impact',
                lucida_grande: 'Lucida Grande',
                times_new_roman: 'Times New Roman',
                verdana: 'Verdana',
              }"
            />
          </div>
        </div>
      </q-card-section>
      <q-card-section>
        <div class="text-h7">Correo de Regeneración</div>
      </q-card-section>
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-12">
            <q-editor
              v-model="registro.correoRegenerar"
              :dense="$q.screen.lt.md"
              :toolbar="[
                [
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    list: 'only-icons',
                    options: ['left', 'center', 'right', 'justify'],
                  },
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    options: ['left', 'center', 'right', 'justify'],
                  },
                ],
                [
                  'bold',
                  'italic',
                  'strike',
                  'underline',
                  'subscript',
                  'superscript',
                ],
                ['token', 'hr', 'link', 'custom_btn'],
                ['print', 'fullscreen'],
                [
                  {
                    label: $q.lang.editor.formatting,
                    icon: $q.iconSet.editor.formatting,
                    list: 'no-icons',
                    options: ['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'code'],
                  },
                  {
                    label: $q.lang.editor.fontSize,
                    icon: $q.iconSet.editor.fontSize,
                    fixedLabel: true,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'size-1',
                      'size-2',
                      'size-3',
                      'size-4',
                      'size-5',
                      'size-6',
                      'size-7',
                    ],
                  },
                  {
                    label: $q.lang.editor.defaultFont,
                    icon: $q.iconSet.editor.font,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'default_font',
                      'arial',
                      'arial_black',
                      'comic_sans',
                      'courier_new',
                      'impact',
                      'lucida_grande',
                      'times_new_roman',
                      'verdana',
                    ],
                  },
                  'removeFormat',
                ],
                ['quote', 'unordered', 'ordered', 'outdent', 'indent'],

                ['undo', 'redo'],
                ['viewsource'],
              ]"
              :fonts="{
                arial: 'Arial',
                arial_black: 'Arial Black',
                comic_sans: 'Comic Sans MS',
                courier_new: 'Courier New',
                impact: 'Impact',
                lucida_grande: 'Lucida Grande',
                times_new_roman: 'Times New Roman',
                verdana: 'Verdana',
              }"
            />
          </div>
        </div>
      </q-card-section>
      <q-card-section>
        <div class="text-h7">Correo de Notificación de Cita</div>
      </q-card-section>
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-12">
            <q-editor
              v-model="registro.correoNotificacionCita"
              :dense="$q.screen.lt.md"
              :toolbar="[
                [
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    list: 'only-icons',
                    options: ['left', 'center', 'right', 'justify'],
                  },
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    options: ['left', 'center', 'right', 'justify'],
                  },
                ],
                [
                  'bold',
                  'italic',
                  'strike',
                  'underline',
                  'subscript',
                  'superscript',
                ],
                ['token', 'hr', 'link', 'custom_btn'],
                ['print', 'fullscreen'],
                [
                  {
                    label: $q.lang.editor.formatting,
                    icon: $q.iconSet.editor.formatting,
                    list: 'no-icons',
                    options: ['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'code'],
                  },
                  {
                    label: $q.lang.editor.fontSize,
                    icon: $q.iconSet.editor.fontSize,
                    fixedLabel: true,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'size-1',
                      'size-2',
                      'size-3',
                      'size-4',
                      'size-5',
                      'size-6',
                      'size-7',
                    ],
                  },
                  {
                    label: $q.lang.editor.defaultFont,
                    icon: $q.iconSet.editor.font,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'default_font',
                      'arial',
                      'arial_black',
                      'comic_sans',
                      'courier_new',
                      'impact',
                      'lucida_grande',
                      'times_new_roman',
                      'verdana',
                    ],
                  },
                  'removeFormat',
                ],
                ['quote', 'unordered', 'ordered', 'outdent', 'indent'],

                ['undo', 'redo'],
                ['viewsource'],
              ]"
              :fonts="{
                arial: 'Arial',
                arial_black: 'Arial Black',
                comic_sans: 'Comic Sans MS',
                courier_new: 'Courier New',
                impact: 'Impact',
                lucida_grande: 'Lucida Grande',
                times_new_roman: 'Times New Roman',
                verdana: 'Verdana',
              }"
            />
          </div>
        </div>
      </q-card-section>
      <q-card-section>
        <div class="text-h7">Correo de Recordatorio de Cita</div>
      </q-card-section>
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-12">
            <q-editor
              v-model="registro.correoRecordatorio"
              :dense="$q.screen.lt.md"
              :toolbar="[
                [
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    list: 'only-icons',
                    options: ['left', 'center', 'right', 'justify'],
                  },
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    options: ['left', 'center', 'right', 'justify'],
                  },
                ],
                [
                  'bold',
                  'italic',
                  'strike',
                  'underline',
                  'subscript',
                  'superscript',
                ],
                ['token', 'hr', 'link', 'custom_btn'],
                ['print', 'fullscreen'],
                [
                  {
                    label: $q.lang.editor.formatting,
                    icon: $q.iconSet.editor.formatting,
                    list: 'no-icons',
                    options: ['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'code'],
                  },
                  {
                    label: $q.lang.editor.fontSize,
                    icon: $q.iconSet.editor.fontSize,
                    fixedLabel: true,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'size-1',
                      'size-2',
                      'size-3',
                      'size-4',
                      'size-5',
                      'size-6',
                      'size-7',
                    ],
                  },
                  {
                    label: $q.lang.editor.defaultFont,
                    icon: $q.iconSet.editor.font,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'default_font',
                      'arial',
                      'arial_black',
                      'comic_sans',
                      'courier_new',
                      'impact',
                      'lucida_grande',
                      'times_new_roman',
                      'verdana',
                    ],
                  },
                  'removeFormat',
                ],
                ['quote', 'unordered', 'ordered', 'outdent', 'indent'],

                ['undo', 'redo'],
                ['viewsource'],
              ]"
              :fonts="{
                arial: 'Arial',
                arial_black: 'Arial Black',
                comic_sans: 'Comic Sans MS',
                courier_new: 'Courier New',
                impact: 'Impact',
                lucida_grande: 'Lucida Grande',
                times_new_roman: 'Times New Roman',
                verdana: 'Verdana',
              }"
            />
          </div>
        </div>
      </q-card-section>
      <q-card-section>
        <div class="text-h7">Correo de Cancelación de Cita (Sistema)</div>
      </q-card-section>
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-12">
            <q-editor
              v-model="registro.correoCancelacionCita"
              :dense="$q.screen.lt.md"
              :toolbar="[
                [
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    list: 'only-icons',
                    options: ['left', 'center', 'right', 'justify'],
                  },
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    options: ['left', 'center', 'right', 'justify'],
                  },
                ],
                [
                  'bold',
                  'italic',
                  'strike',
                  'underline',
                  'subscript',
                  'superscript',
                ],
                ['token', 'hr', 'link', 'custom_btn'],
                ['print', 'fullscreen'],
                [
                  {
                    label: $q.lang.editor.formatting,
                    icon: $q.iconSet.editor.formatting,
                    list: 'no-icons',
                    options: ['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'code'],
                  },
                  {
                    label: $q.lang.editor.fontSize,
                    icon: $q.iconSet.editor.fontSize,
                    fixedLabel: true,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'size-1',
                      'size-2',
                      'size-3',
                      'size-4',
                      'size-5',
                      'size-6',
                      'size-7',
                    ],
                  },
                  {
                    label: $q.lang.editor.defaultFont,
                    icon: $q.iconSet.editor.font,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'default_font',
                      'arial',
                      'arial_black',
                      'comic_sans',
                      'courier_new',
                      'impact',
                      'lucida_grande',
                      'times_new_roman',
                      'verdana',
                    ],
                  },
                  'removeFormat',
                ],
                ['quote', 'unordered', 'ordered', 'outdent', 'indent'],

                ['undo', 'redo'],
                ['viewsource'],
              ]"
              :fonts="{
                arial: 'Arial',
                arial_black: 'Arial Black',
                comic_sans: 'Comic Sans MS',
                courier_new: 'Courier New',
                impact: 'Impact',
                lucida_grande: 'Lucida Grande',
                times_new_roman: 'Times New Roman',
                verdana: 'Verdana',
              }"
            />
          </div>
        </div>
      </q-card-section>
      <q-card-section>
        <div class="text-h7">Correo de Cancelación de Cita (Manual)</div>
      </q-card-section>
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-12">
            <q-editor
              v-model="registro.correoCancelacionManual"
              :dense="$q.screen.lt.md"
              :toolbar="[
                [
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    list: 'only-icons',
                    options: ['left', 'center', 'right', 'justify'],
                  },
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    options: ['left', 'center', 'right', 'justify'],
                  },
                ],
                [
                  'bold',
                  'italic',
                  'strike',
                  'underline',
                  'subscript',
                  'superscript',
                ],
                ['token', 'hr', 'link', 'custom_btn'],
                ['print', 'fullscreen'],
                [
                  {
                    label: $q.lang.editor.formatting,
                    icon: $q.iconSet.editor.formatting,
                    list: 'no-icons',
                    options: ['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'code'],
                  },
                  {
                    label: $q.lang.editor.fontSize,
                    icon: $q.iconSet.editor.fontSize,
                    fixedLabel: true,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'size-1',
                      'size-2',
                      'size-3',
                      'size-4',
                      'size-5',
                      'size-6',
                      'size-7',
                    ],
                  },
                  {
                    label: $q.lang.editor.defaultFont,
                    icon: $q.iconSet.editor.font,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'default_font',
                      'arial',
                      'arial_black',
                      'comic_sans',
                      'courier_new',
                      'impact',
                      'lucida_grande',
                      'times_new_roman',
                      'verdana',
                    ],
                  },
                  'removeFormat',
                ],
                ['quote', 'unordered', 'ordered', 'outdent', 'indent'],

                ['undo', 'redo'],
                ['viewsource'],
              ]"
              :fonts="{
                arial: 'Arial',
                arial_black: 'Arial Black',
                comic_sans: 'Comic Sans MS',
                courier_new: 'Courier New',
                impact: 'Impact',
                lucida_grande: 'Lucida Grande',
                times_new_roman: 'Times New Roman',
                verdana: 'Verdana',
              }"
            />
          </div>
        </div>
      </q-card-section>
      <q-card-section>
        <div class="text-h7">Correo de Recepción de Vehículo</div>
      </q-card-section>
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-12">
            <q-editor
              v-model="registro.correoRecepcionUnidad"
              :dense="$q.screen.lt.md"
              :toolbar="[
                [
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    list: 'only-icons',
                    options: ['left', 'center', 'right', 'justify'],
                  },
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    options: ['left', 'center', 'right', 'justify'],
                  },
                ],
                [
                  'bold',
                  'italic',
                  'strike',
                  'underline',
                  'subscript',
                  'superscript',
                ],
                ['token', 'hr', 'link', 'custom_btn'],
                ['print', 'fullscreen'],
                [
                  {
                    label: $q.lang.editor.formatting,
                    icon: $q.iconSet.editor.formatting,
                    list: 'no-icons',
                    options: ['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'code'],
                  },
                  {
                    label: $q.lang.editor.fontSize,
                    icon: $q.iconSet.editor.fontSize,
                    fixedLabel: true,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'size-1',
                      'size-2',
                      'size-3',
                      'size-4',
                      'size-5',
                      'size-6',
                      'size-7',
                    ],
                  },
                  {
                    label: $q.lang.editor.defaultFont,
                    icon: $q.iconSet.editor.font,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'default_font',
                      'arial',
                      'arial_black',
                      'comic_sans',
                      'courier_new',
                      'impact',
                      'lucida_grande',
                      'times_new_roman',
                      'verdana',
                    ],
                  },
                  'removeFormat',
                ],
                ['quote', 'unordered', 'ordered', 'outdent', 'indent'],

                ['undo', 'redo'],
                ['viewsource'],
              ]"
              :fonts="{
                arial: 'Arial',
                arial_black: 'Arial Black',
                comic_sans: 'Comic Sans MS',
                courier_new: 'Courier New',
                impact: 'Impact',
                lucida_grande: 'Lucida Grande',
                times_new_roman: 'Times New Roman',
                verdana: 'Verdana',
              }"
            />
          </div>
        </div>
      </q-card-section>
      <q-card-section>
        <div class="text-h7">Correo de Retraso de entrega de Vehículo</div>
      </q-card-section>
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-12">
            <q-editor
              v-model="registro.correoProrrogaUnidad"
              :dense="$q.screen.lt.md"
              :toolbar="[
                [
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    list: 'only-icons',
                    options: ['left', 'center', 'right', 'justify'],
                  },
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    options: ['left', 'center', 'right', 'justify'],
                  },
                ],
                [
                  'bold',
                  'italic',
                  'strike',
                  'underline',
                  'subscript',
                  'superscript',
                ],
                ['token', 'hr', 'link', 'custom_btn'],
                ['print', 'fullscreen'],
                [
                  {
                    label: $q.lang.editor.formatting,
                    icon: $q.iconSet.editor.formatting,
                    list: 'no-icons',
                    options: ['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'code'],
                  },
                  {
                    label: $q.lang.editor.fontSize,
                    icon: $q.iconSet.editor.fontSize,
                    fixedLabel: true,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'size-1',
                      'size-2',
                      'size-3',
                      'size-4',
                      'size-5',
                      'size-6',
                      'size-7',
                    ],
                  },
                  {
                    label: $q.lang.editor.defaultFont,
                    icon: $q.iconSet.editor.font,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'default_font',
                      'arial',
                      'arial_black',
                      'comic_sans',
                      'courier_new',
                      'impact',
                      'lucida_grande',
                      'times_new_roman',
                      'verdana',
                    ],
                  },
                  'removeFormat',
                ],
                ['quote', 'unordered', 'ordered', 'outdent', 'indent'],

                ['undo', 'redo'],
                ['viewsource'],
              ]"
              :fonts="{
                arial: 'Arial',
                arial_black: 'Arial Black',
                comic_sans: 'Comic Sans MS',
                courier_new: 'Courier New',
                impact: 'Impact',
                lucida_grande: 'Lucida Grande',
                times_new_roman: 'Times New Roman',
                verdana: 'Verdana',
              }"
            />
          </div>
        </div>
      </q-card-section>
      <q-card-section>
        <div class="text-h7">Correo de Termino de Servicio</div>
      </q-card-section>
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-12">
            <q-editor
              v-model="registro.correoTerminoUnidad"
              :dense="$q.screen.lt.md"
              :toolbar="[
                [
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    list: 'only-icons',
                    options: ['left', 'center', 'right', 'justify'],
                  },
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    options: ['left', 'center', 'right', 'justify'],
                  },
                ],
                [
                  'bold',
                  'italic',
                  'strike',
                  'underline',
                  'subscript',
                  'superscript',
                ],
                ['token', 'hr', 'link', 'custom_btn'],
                ['print', 'fullscreen'],
                [
                  {
                    label: $q.lang.editor.formatting,
                    icon: $q.iconSet.editor.formatting,
                    list: 'no-icons',
                    options: ['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'code'],
                  },
                  {
                    label: $q.lang.editor.fontSize,
                    icon: $q.iconSet.editor.fontSize,
                    fixedLabel: true,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'size-1',
                      'size-2',
                      'size-3',
                      'size-4',
                      'size-5',
                      'size-6',
                      'size-7',
                    ],
                  },
                  {
                    label: $q.lang.editor.defaultFont,
                    icon: $q.iconSet.editor.font,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'default_font',
                      'arial',
                      'arial_black',
                      'comic_sans',
                      'courier_new',
                      'impact',
                      'lucida_grande',
                      'times_new_roman',
                      'verdana',
                    ],
                  },
                  'removeFormat',
                ],
                ['quote', 'unordered', 'ordered', 'outdent', 'indent'],

                ['undo', 'redo'],
                ['viewsource'],
              ]"
              :fonts="{
                arial: 'Arial',
                arial_black: 'Arial Black',
                comic_sans: 'Comic Sans MS',
                courier_new: 'Courier New',
                impact: 'Impact',
                lucida_grande: 'Lucida Grande',
                times_new_roman: 'Times New Roman',
                verdana: 'Verdana',
              }"
            />
          </div>
        </div>
      </q-card-section>
      <q-card-section>
        <div class="text-h7">Correo de Entrega de Vehículo</div>
      </q-card-section>
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-12">
            <q-editor
              v-model="registro.correoEntregaUnidad"
              :dense="$q.screen.lt.md"
              :toolbar="[
                [
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    list: 'only-icons',
                    options: ['left', 'center', 'right', 'justify'],
                  },
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    options: ['left', 'center', 'right', 'justify'],
                  },
                ],
                [
                  'bold',
                  'italic',
                  'strike',
                  'underline',
                  'subscript',
                  'superscript',
                ],
                ['token', 'hr', 'link', 'custom_btn'],
                ['print', 'fullscreen'],
                [
                  {
                    label: $q.lang.editor.formatting,
                    icon: $q.iconSet.editor.formatting,
                    list: 'no-icons',
                    options: ['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'code'],
                  },
                  {
                    label: $q.lang.editor.fontSize,
                    icon: $q.iconSet.editor.fontSize,
                    fixedLabel: true,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'size-1',
                      'size-2',
                      'size-3',
                      'size-4',
                      'size-5',
                      'size-6',
                      'size-7',
                    ],
                  },
                  {
                    label: $q.lang.editor.defaultFont,
                    icon: $q.iconSet.editor.font,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'default_font',
                      'arial',
                      'arial_black',
                      'comic_sans',
                      'courier_new',
                      'impact',
                      'lucida_grande',
                      'times_new_roman',
                      'verdana',
                    ],
                  },
                  'removeFormat',
                ],
                ['quote', 'unordered', 'ordered', 'outdent', 'indent'],

                ['undo', 'redo'],
                ['viewsource'],
              ]"
              :fonts="{
                arial: 'Arial',
                arial_black: 'Arial Black',
                comic_sans: 'Comic Sans MS',
                courier_new: 'Courier New',
                impact: 'Impact',
                lucida_grande: 'Lucida Grande',
                times_new_roman: 'Times New Roman',
                verdana: 'Verdana',
              }"
            />
          </div>
        </div>
      </q-card-section>
      <q-card-section>
        <div class="text-h7">
          Correo de Término de Mantenimiento (Para encargado(s) de taller)
        </div>
      </q-card-section>
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-12">
            <q-editor
              v-model="registro.correoTerminoTaller"
              :dense="$q.screen.lt.md"
              :toolbar="[
                [
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    list: 'only-icons',
                    options: ['left', 'center', 'right', 'justify'],
                  },
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    options: ['left', 'center', 'right', 'justify'],
                  },
                ],
                [
                  'bold',
                  'italic',
                  'strike',
                  'underline',
                  'subscript',
                  'superscript',
                ],
                ['token', 'hr', 'link', 'custom_btn'],
                ['print', 'fullscreen'],
                [
                  {
                    label: $q.lang.editor.formatting,
                    icon: $q.iconSet.editor.formatting,
                    list: 'no-icons',
                    options: ['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'code'],
                  },
                  {
                    label: $q.lang.editor.fontSize,
                    icon: $q.iconSet.editor.fontSize,
                    fixedLabel: true,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'size-1',
                      'size-2',
                      'size-3',
                      'size-4',
                      'size-5',
                      'size-6',
                      'size-7',
                    ],
                  },
                  {
                    label: $q.lang.editor.defaultFont,
                    icon: $q.iconSet.editor.font,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'default_font',
                      'arial',
                      'arial_black',
                      'comic_sans',
                      'courier_new',
                      'impact',
                      'lucida_grande',
                      'times_new_roman',
                      'verdana',
                    ],
                  },
                  'removeFormat',
                ],
                ['quote', 'unordered', 'ordered', 'outdent', 'indent'],

                ['undo', 'redo'],
                ['viewsource'],
              ]"
              :fonts="{
                arial: 'Arial',
                arial_black: 'Arial Black',
                comic_sans: 'Comic Sans MS',
                courier_new: 'Courier New',
                impact: 'Impact',
                lucida_grande: 'Lucida Grande',
                times_new_roman: 'Times New Roman',
                verdana: 'Verdana',
              }"
            />
          </div>
        </div>
      </q-card-section>
      <q-card-section>
        <div class="text-h7">Correo de Creación de Pedido de Trabajo</div>
      </q-card-section>
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-12">
            <q-editor
              v-model="registro.correoOrdenTrabajo"
              :dense="$q.screen.lt.md"
              :toolbar="[
                [
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    list: 'only-icons',
                    options: ['left', 'center', 'right', 'justify'],
                  },
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    options: ['left', 'center', 'right', 'justify'],
                  },
                ],
                [
                  'bold',
                  'italic',
                  'strike',
                  'underline',
                  'subscript',
                  'superscript',
                ],
                ['token', 'hr', 'link', 'custom_btn'],
                ['print', 'fullscreen'],
                [
                  {
                    label: $q.lang.editor.formatting,
                    icon: $q.iconSet.editor.formatting,
                    list: 'no-icons',
                    options: ['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'code'],
                  },
                  {
                    label: $q.lang.editor.fontSize,
                    icon: $q.iconSet.editor.fontSize,
                    fixedLabel: true,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'size-1',
                      'size-2',
                      'size-3',
                      'size-4',
                      'size-5',
                      'size-6',
                      'size-7',
                    ],
                  },
                  {
                    label: $q.lang.editor.defaultFont,
                    icon: $q.iconSet.editor.font,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'default_font',
                      'arial',
                      'arial_black',
                      'comic_sans',
                      'courier_new',
                      'impact',
                      'lucida_grande',
                      'times_new_roman',
                      'verdana',
                    ],
                  },
                  'removeFormat',
                ],
                ['quote', 'unordered', 'ordered', 'outdent', 'indent'],

                ['undo', 'redo'],
                ['viewsource'],
              ]"
              :fonts="{
                arial: 'Arial',
                arial_black: 'Arial Black',
                comic_sans: 'Comic Sans MS',
                courier_new: 'Courier New',
                impact: 'Impact',
                lucida_grande: 'Lucida Grande',
                times_new_roman: 'Times New Roman',
                verdana: 'Verdana',
              }"
            />
          </div>
        </div>
      </q-card-section>

      <q-card-section>
        <div class="text-h7">Correo de Aprobación de Pedido de Trabajo</div>
      </q-card-section>
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-12">
            <q-editor
              v-model="registro.correoOrdenTrabajoAprobado"
              :dense="$q.screen.lt.md"
              :toolbar="[
                [
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    list: 'only-icons',
                    options: ['left', 'center', 'right', 'justify'],
                  },
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    options: ['left', 'center', 'right', 'justify'],
                  },
                ],
                [
                  'bold',
                  'italic',
                  'strike',
                  'underline',
                  'subscript',
                  'superscript',
                ],
                ['token', 'hr', 'link', 'custom_btn'],
                ['print', 'fullscreen'],
                [
                  {
                    label: $q.lang.editor.formatting,
                    icon: $q.iconSet.editor.formatting,
                    list: 'no-icons',
                    options: ['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'code'],
                  },
                  {
                    label: $q.lang.editor.fontSize,
                    icon: $q.iconSet.editor.fontSize,
                    fixedLabel: true,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'size-1',
                      'size-2',
                      'size-3',
                      'size-4',
                      'size-5',
                      'size-6',
                      'size-7',
                    ],
                  },
                  {
                    label: $q.lang.editor.defaultFont,
                    icon: $q.iconSet.editor.font,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'default_font',
                      'arial',
                      'arial_black',
                      'comic_sans',
                      'courier_new',
                      'impact',
                      'lucida_grande',
                      'times_new_roman',
                      'verdana',
                    ],
                  },
                  'removeFormat',
                ],
                ['quote', 'unordered', 'ordered', 'outdent', 'indent'],

                ['undo', 'redo'],
                ['viewsource'],
              ]"
              :fonts="{
                arial: 'Arial',
                arial_black: 'Arial Black',
                comic_sans: 'Comic Sans MS',
                courier_new: 'Courier New',
                impact: 'Impact',
                lucida_grande: 'Lucida Grande',
                times_new_roman: 'Times New Roman',
                verdana: 'Verdana',
              }"
            />
          </div>
        </div>
      </q-card-section>

      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-12">
            <q-input
              color="primary"
              v-model="registro.emailAlmacen"
              outlined
              label="Correos de almacen para notificación de órdenes aprobadas"
            ></q-input>
          </div>
        </div>
      </q-card-section>

      <q-card-section>
        <div class="text-h7">Correo de Rechazo de Pedido de Trabajo</div>
      </q-card-section>
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-12">
            <q-editor
              v-model="registro.correoOrdenTrabajoRechazado"
              :dense="$q.screen.lt.md"
              :toolbar="[
                [
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    list: 'only-icons',
                    options: ['left', 'center', 'right', 'justify'],
                  },
                  {
                    label: $q.lang.editor.align,
                    icon: $q.iconSet.editor.align,
                    fixedLabel: true,
                    options: ['left', 'center', 'right', 'justify'],
                  },
                ],
                [
                  'bold',
                  'italic',
                  'strike',
                  'underline',
                  'subscript',
                  'superscript',
                ],
                ['token', 'hr', 'link', 'custom_btn'],
                ['print', 'fullscreen'],
                [
                  {
                    label: $q.lang.editor.formatting,
                    icon: $q.iconSet.editor.formatting,
                    list: 'no-icons',
                    options: ['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'code'],
                  },
                  {
                    label: $q.lang.editor.fontSize,
                    icon: $q.iconSet.editor.fontSize,
                    fixedLabel: true,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'size-1',
                      'size-2',
                      'size-3',
                      'size-4',
                      'size-5',
                      'size-6',
                      'size-7',
                    ],
                  },
                  {
                    label: $q.lang.editor.defaultFont,
                    icon: $q.iconSet.editor.font,
                    fixedIcon: true,
                    list: 'no-icons',
                    options: [
                      'default_font',
                      'arial',
                      'arial_black',
                      'comic_sans',
                      'courier_new',
                      'impact',
                      'lucida_grande',
                      'times_new_roman',
                      'verdana',
                    ],
                  },
                  'removeFormat',
                ],
                ['quote', 'unordered', 'ordered', 'outdent', 'indent'],

                ['undo', 'redo'],
                ['viewsource'],
              ]"
              :fonts="{
                arial: 'Arial',
                arial_black: 'Arial Black',
                comic_sans: 'Comic Sans MS',
                courier_new: 'Courier New',
                impact: 'Impact',
                lucida_grande: 'Lucida Grande',
                times_new_roman: 'Times New Roman',
                verdana: 'Verdana',
              }"
            />
          </div>
        </div>
      </q-card-section>

      <q-separator />
      <q-card-actions align="right" class="text-primary">
        <q-btn
          label="Guardar"
          color="primary"
          @click="onClickGuardar"
          v-if="permGuardar"
          icon="check"
        />
      </q-card-actions>
    </q-card>
  </q-page>
</template>

<style lang="css" scoped></style>
