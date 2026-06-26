<script lang="ts" setup>
//Imports
import { ref, onMounted, watch, computed } from "vue";
import { api } from "boot/axios";
import { useQuasar } from "quasar";
import { mostrarMensaje } from "../functions/funciones";

const $q = useQuasar();

//Variables
const urlImagenes = ref($q.localStorage.getItem("urlImagenes"));

const loading = ref(false);

const data = ref([]);
const uploader = ref();

const mensaje = ref("Actualización realizada con éxito");
const mensajes = ref([]);
const estatus = ref(0);

const mostrarSubida = ref(false);
const mostrarCargandoSubida = ref(false);

//Otras funciones
function file_selected(files) {
  files.forEach((element) => {
    data.value.push(element);
  });
}

function file_removed(files) {
  files.forEach((element) => {
    removerArchivo(element.name);
  });

  console.log(data.value);
}

function removerArchivo(archivo) {
  var index = data.value.findIndex((item) => item.name === archivo);
  data.value.splice(index, 1);
}

function file_rejected(files) {
  mostrarMensaje(
    "Agregar evidencia",
    "Sólo se permite la subida de un archivo de excel (xlsx) de máximo 4mb",
    "err"
  );
}

function uploadFiles() {
  mostrarSubida.value = false;
  mostrarCargandoSubida.value = true;

  if (data.value.length > 0) subirArchivo();
}

function subirArchivo() {
  let config = {
    headers: {
      "Content-Type": "multipart/form-data",
    },
  };

  let fd = new FormData();
  fd.append("file", data.value[0]);
  api
    .post("/parametricos/ActualizarParametricos", fd, config)
    .then((response) => {
      if (response.status == 200) {
        mensajes.value = response.data.errores;
        if (response.data.resultado == "OK") {
          estatus.value = 1;
          mensaje.value = "Se ha actualizado la información con éxito";
        } else {
          estatus.value = 2;
          mensaje.value =
            "Se presentaron errores durante la actualización de datos";
        }
        data.value = [];
      }
    })
    .catch((error) => {
      mostrarMensaje(
        "Cargar evidencia",
        "Ocurrió un error al agregar evidencia: " + error,
        "err"
      );
    })
    .finally(() => {
      mostrarCargandoSubida.value = false;
    });
}

//Eventos
onMounted(() => {});

function onClickDescargar() {
  window.open(
    urlImagenes.value + "/plantillas/LayoutParametros.xlsx",
    "_blank"
  );
}
</script>

<template>
  <q-page class="bg-grey-3 qpage">
    <q-card class="q-pa-md q-gutter-sm" bordered
      ><q-card-section>
        <table style="border: none; width: 100%">
          <tr>
            <td style="text-align: center">
              <img src="../assets/logo-sapal.png" />
            </td>
          </tr>
          <tr>
            <td style="text-align: center">
              <div class="text-grey-9 text-weight-bold" style="font-size: 16pt">
                ACTUALIZACIÓN DE PARÁMETROS PARA CÁLCULO
              </div>
            </td>
          </tr>
        </table>
      </q-card-section>

      <q-separator v-if="estatus > 0" />
      <q-card-section v-if="estatus > 0">
        <div class="row">
          <div class="q-pa-sm col-12 col-md-12">
            <q-input
              color="primary"
              v-model="mensaje"
              outlined
              label=""
              clearable
              clear-icon="close"
              :disable="true"
              :bg-color="estatus == 1 ? 'green-2' : 'red-3'"
            ></q-input>
          </div>
        </div>
        <div v-for="item in mensajes" :key="item.error" class="row">
          <div class="q-pa-sm col-12 col-md-12">
            <q-input
              color="primary"
              v-model="item.error"
              outlined
              label=""
              clearable
              clear-icon="close"
              :disable="true"
            ></q-input>
          </div></div
      ></q-card-section>

      <q-separator />
      <q-card-actions align="center">
        <q-btn
          label="Descargar Layout"
          color="primary"
          icon="dataset"
          @click="onClickDescargar"
          style="width: 250px"
        />
        <q-btn
          icon="add"
          color="green-10"
          label="Cargar Archivo de Actualización"
          @click="mostrarSubida = true"
        ></q-btn>
      </q-card-actions>
    </q-card>
  </q-page>

  <q-dialog v-model="mostrarSubida">
    <q-card style="width: 50%; max-width: 95%">
      <q-card-section class="bg-grey-4"
        ><div class="row">
          <div class="text-h6">Subir Archivo de Actualización</div>
          <q-space />
          <q-btn icon="close" flat round dense v-close-popup />
        </div>
      </q-card-section>
      <q-separator />
      <q-card-section class="q-pa-none">
        <div class="row">
          <div class="col-12 col-md-12">
            <q-uploader
              label="Cargar archivo"
              color="primary"
              style="width: 100%"
              accept=".xlsx"
              max-file-size="4194304"
              bordered
              :hide-upload-btn="true"
              :no-thumbnails="true"
              @added="file_selected"
              @rejected="file_rejected"
              @removed="file_removed"
              ref="uploader"
            />
          </div>
        </div>
      </q-card-section>
      <q-separator />
      <q-card-actions align="right" class="text-primary">
        <q-btn
          label="Cancelar"
          color="red-10"
          icon="arrow_back"
          @click="mostrarSubida = false"
        />
        <q-btn
          label="Guardar"
          color="primary"
          @click="uploadFiles()"
          icon="check"
        />
      </q-card-actions>
    </q-card>
  </q-dialog>

  <q-dialog v-model="mostrarCargandoSubida">
    <q-card style="width: 350px; max-width: 350px">
      <q-card-section class="bg-grey-4"
        ><div class="row">
          <div class="text-h6">Cargando Actualización...</div>
          <q-space />
        </div>
      </q-card-section>
      <q-separator />
      <q-card-section class="q-pa-none" style="text-align: center">
        <div class="row" style="text-align: center">
          <div class="col-12 col-md-12" style="text-align: center">
            <img src="../assets/loading.gif" />
          </div>
        </div>
      </q-card-section>
    </q-card>
  </q-dialog>
</template>

<style lang="css" scoped></style>
