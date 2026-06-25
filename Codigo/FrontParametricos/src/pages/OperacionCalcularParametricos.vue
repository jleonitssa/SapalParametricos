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

const Metros = ref(0);
const Total = ref(0);

const formatterMXN = new Intl.NumberFormat("es-MX", {
  style: "currency",
  currency: "MXN",
});

const calcularHabilitado = ref(true);

const opcionesLinea = ref([
  { idLineaTrabajo: 0, nombre: "", incluye: "", idClaveTrabajo: 0 },
]);
const modelLinea = ref({
  idLineaTrabajo: 0,
  nombre: "",
  incluye: "",
  idClaveTrabajo: 0,
});

const opcionesExcavacion = ref([{ idExcavacion: 0, nombre: "" }]);
const modelExcavacion = ref({
  idExcavacion: 0,
  nombre: "",
});

const opcionesMaterial = ref([{ idTipoMaterial: 0, nombre: "", imagen: "" }]);
const modelMaterial = ref({
  idTipoMaterial: 0,
  nombre: "",
  imagen: "",
});

const opcionesObra = ref([{ idTipoObra: 0, idClaveTrabajo: 0, nombre: "" }]);
const modelObra = ref({
  idTipoObra: 0,
  idClaveTrabajo: 0,
  nombre: "",
});

const opcionesTuberia = ref([
  {
    idRelacion: 0,
    idLineaTrabajo: 0,
    idTipoObra: 0,
    idTuberia: 0,
    tuberia: "",
  },
]);
const modelTuberia = ref({
  idRelacion: 0,
  idLineaTrabajo: 0,
  idTipoObra: 0,
  idTuberia: 0,
  tuberia: "",
});

const opcionesDiametro = ref([
  {
    idRelacion: 0,
    idRelacionObra: 0,
    idDiametro: 0,
    diametro: "",
  },
]);
const modelDiametro = ref({
  idRelacion: 0,
  idRelacionObra: 0,
  idDiametro: 0,
  diametro: "",
});

const modelPrecio = ref({
  idRelacion: 0,
  idRelacionDiametro: 0,
  idTipoMaterial: 0,
  idExcavacion: 0,
  precio: 0,
  descripcion: "",
});

//Permisos

//Computed
const cPrecio = computed(() => {
  return formatterMXN.format(modelPrecio.value.precio);
});
const cTotal = computed(() => {
  return formatterMXN.format(Total.value);
});

//Watchers
watch(modelLinea, async () => {
  const req = { idClaveTrabajo: modelLinea.value.idClaveTrabajo };

  api
    .post("/parametricos/TipoObraSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        opcionesObra.value = resp.tiposObra;
        modelObra.value = resp.tiposObra[0];
      } else {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    })
    .finally(() => {});
});

watch(modelObra, async () => {
  const req = {
    idLineaTrabajo: modelLinea.value.idLineaTrabajo,
    idTipoObra: modelObra.value.idTipoObra,
  };

  api
    .post("/parametricos/RelacionLineaObraTuberiaSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        opcionesTuberia.value = resp.relacionesLineaObraTuberia;
        modelTuberia.value = resp.relacionesLineaObraTuberia[0];
      } else {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    })
    .finally(() => {});
});

watch(modelTuberia, async () => {
  const req = {
    idRelacionObra: modelTuberia.value.idRelacion,
  };

  api
    .post("/parametricos/RelacionObraDiametroSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        opcionesDiametro.value = resp.relacionesObraDiametro;
        modelDiametro.value = resp.relacionesObraDiametro[0];
      } else {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    })
    .finally(() => {});
});

watch(modelMaterial, async () => {
  encontrarPrecioFinal();
});

watch(modelExcavacion, async () => {
  encontrarPrecioFinal();
});

watch(modelDiametro, async () => {
  encontrarPrecioFinal();
});

//Llamadas a servidor
async function cargarCombosInicio() {
  const req = {};

  api
    .post("/parametricos/LineaTrabajoSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        opcionesLinea.value = resp.lineasTrabajo;
        modelLinea.value = resp.lineasTrabajo[0];
      } else {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    })
    .finally(() => {});

  api
    .post("/parametricos/TipoMaterialSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        opcionesMaterial.value = resp.tiposMaterial;
        modelMaterial.value = resp.tiposMaterial[0];
      } else {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    })
    .finally(() => {});

  api
    .post("/parametricos/ExcavacionSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        opcionesExcavacion.value = resp.excavaciones;
        modelExcavacion.value = resp.excavaciones[0];
      } else {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    })
    .finally(() => {});
}

function encontrarPrecioFinal() {
  const req = {
    idRelacionDiametro: modelDiametro.value.idRelacion,
    idTipoMaterial: modelMaterial.value.idTipoMaterial,
    idExcavacion: modelExcavacion.value.idExcavacion,
  };

  api
    .post("/parametricos/RelacionFinalPrecioSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        if (resp.relacionesFinalPrecio.length > 0) {
          modelPrecio.value = resp.relacionesFinalPrecio[0];
          calcularHabilitado.value = true;
        } else {
          modelPrecio.value = {
            idRelacion: 0,
            idRelacionDiametro: 0,
            idTipoMaterial: 0,
            idExcavacion: 0,
            precio: 0,
            descripcion: "NO HAY PRECIO PARA LAS ESPECIFICACIONES INGRESADAS",
          };
          calcularHabilitado.value = false;
        }
        Total.value = 0;
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

//Eventos
onMounted(() => {
  cargarCombosInicio();
});

function onClickCalcular() {
  Total.value = Metros.value * modelPrecio.value.precio;
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
                DETERMINACIÓN DE COSTOS DEL METRO DE CONSTRUCCIÓN MEDIANTE
                PARAMÉTRICOS
              </div>
            </td>
          </tr>
        </table>
      </q-card-section>
      <q-separator />
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-6">
            <q-select
              outlined
              v-model="modelLinea"
              :options="opcionesLinea"
              label="Línea de Trabajo"
              option-label="nombre"
              option-value="idLineaTrabajo"
            />
          </div>
          <div class="q-pa-sm col-12 col-md-6">
            <q-select
              outlined
              v-model="modelMaterial"
              :options="opcionesMaterial"
              label="Tipo de Material"
              option-label="nombre"
              option-value="idTipoMaterial"
            />
          </div>
        </div>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-6">
            <q-select
              outlined
              v-model="modelObra"
              :options="opcionesObra"
              label="Tipo de Obra"
              option-label="nombre"
              option-value="idTipoObra"
            />
          </div>
          <div class="q-pa-sm col-12 col-md-6">
            <q-select
              outlined
              v-model="modelTuberia"
              :options="opcionesTuberia"
              label="Tipo de Tubería"
              option-label="tuberia"
              option-value="idRelacion"
            />
          </div>
        </div>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-6">
            <q-select
              outlined
              v-model="modelDiametro"
              :options="opcionesDiametro"
              label="Diámetro de Tubería"
              option-label="diametro"
              option-value="idRelacion"
            />
          </div>
          <div class="q-pa-sm col-12 col-md-6">
            <q-select
              outlined
              v-model="modelExcavacion"
              :options="opcionesExcavacion"
              label="Excavación en"
              option-label="nombre"
              option-value="idExcavacion"
            />
          </div>
        </div>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-6">
            <img
              :src="urlImagenes + '/imagenes/' + modelMaterial.imagen"
              style="width: 100%"
            />
          </div>
          <div class="q-pa-sm col-12 col-md-6">
            <div class="row">
              <div class="q-pa-sm col-12 col-md-12">
                <q-input
                  color="primary"
                  v-model="modelLinea.incluye"
                  outlined
                  label="Incluye"
                  clearable
                  clear-icon="close"
                  type="textarea"
                  :disable="true"
                ></q-input>
              </div>
            </div>
            <div class="row">
              <div class="q-pa-sm col-12 col-md-12">
                <q-input
                  color="primary"
                  v-model="modelPrecio.descripcion"
                  outlined
                  label="Descripción"
                  clearable
                  clear-icon="close"
                  type="textarea"
                  :disable="true"
                ></q-input>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-6">
            <q-input
              color="primary"
              v-model="cPrecio"
              outlined
              label="Precio por Metro"
              clearable
              clear-icon="close"
              :disable="true"
            ></q-input>
          </div>
          <div class="q-pa-sm col-12 col-md-6">
            <q-input
              color="primary"
              v-model="Metros"
              outlined
              type="number"
              label="Metros"
              clearable
              clear-icon="close"
            ></q-input>
          </div>
        </div>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-6">
            <q-input
              color="primary"
              v-model="cTotal"
              outlined
              label="Total sin IVA"
              clearable
              clear-icon="close"
              :disable="true"
            ></q-input>
          </div>
        </div>
      </q-card-section>
      <q-separator />
      <q-card-actions align="center">
        <q-btn
          label="Calcular"
          color="primary"
          icon="calculate"
          @click="onClickCalcular"
          :disable="!calcularHabilitado"
          style="width: 250px"
        />
      </q-card-actions>
    </q-card>
  </q-page>
</template>

<style lang="css" scoped></style>
