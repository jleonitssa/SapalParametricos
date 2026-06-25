<script lang="ts" setup>
//Imports
import { ref, onMounted } from "vue";
import { api } from "boot/axios";
import { useQuasar } from "quasar";
import {
  mostrarMensaje,
  guardarLogSistema,
  revisarPermisos,
  obtenerParametroURL,
} from "../functions/funciones";

const $q = useQuasar();

//Columnas
const columns = [
  {
    name: "nombre",
    label: "Acción",
    align: "left",
    field: "nombre",
    sortable: false,
  },
  {
    name: "asociado",
    label: "Asociado",
    align: "left",
    field: "asociado",
    sortable: false,
  },
];

//Variables
const tableRef = ref();
const rows = ref([]);
const loading = ref(false);

const pagination = ref({
  sortBy: "Nombre",
  descending: false,
  page: 1,
  rowsPerPage: 100,
  rowsNumber: 100,
});

const rowNumber = ref(100);

const registro = ref({
  idPantalla: 0,
  nombre: "",
  descripcion: "",
  url: "",
});

const refNombre = ref(null);
const refUrl = ref(null);

//Permisos
const permGuardar = ref(false);

//Llamadas a servidor
function fetchFromServer() {
  const req = {
    idPantalla: registro.value.idPantalla,
  };

  return api
    .post("/accion/AccionXPantallaGrid", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        rows.value = resp.accionesXPantalla;
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
function onRequest(props) {
  const { page, rowsPerPage, sortBy, descending } = props.pagination;

  loading.value = true;

  fetchFromServer();

  // don't forget to update local pagination object
  pagination.value.page = page;
  pagination.value.rowsPerPage = rowsPerPage;
  pagination.value.sortBy = sortBy;
  pagination.value.descending = descending;
  pagination.value.rowsNumber = rowNumber.value;

  loading.value = false;
}

function ValidarFormulario() {
  refUrl.value.validate();
  refNombre.value.validate();
  return !(refUrl.value.hasError || refNombre.value.hasError);
}

function guardarPermiso(indice) {
  const req = {
    idPantalla: registro.value.idPantalla,
    idAccion: rows.value[indice].idAccion,
    checked: rows.value[indice].asociado,
  };
  api
    .post("/accion/AccionXPantallaUpdate", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        if (indice + 1 < rows.value.length) {
          guardarPermiso(indice + 1);
        } else {
          onRequest({ pagination: pagination.value });
        }
      } else {
        onRequest({ pagination: pagination.value });
        mostrarMensaje(
          "Asociar acción",
          "Error al asociar acción " +
            rows.value[0].nombre +
            ": " +
            resp.mensaje,
          "err"
        );
      }
    })
    .catch((error) => {
      onRequest({ pagination: pagination.value });
      mostrarMensaje(
        "Asociar acción",
        "Error al asociar acción " + rows.value[0].nombre + ": " + error,
        "err"
      );
    });
}

//Eventos
onMounted(() => {
  registro.value.idPantalla = parseInt(obtenerParametroURL("IDPantalla", "0"));

  if (registro.value.idPantalla != 0) {
    const req = {
      idPantalla: registro.value.idPantalla,
      nombre: "",
      descripcion: "",
      url: "",
      initRow: 1,
      endRow: 1,
      sortColumn: "IDPantalla",
      sortDir: "DESC",
    };

    api
      .post("/pantalla/PantallaSelect", req, {
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*",
        },
      })
      .then((response) => {
        var resp = response.data;

        if (resp.codigo == 1) {
          registro.value.nombre = resp.pantallas[0].nombre;
          registro.value.descripcion = resp.pantallas[0].descripcion;
          registro.value.url = resp.pantallas[0].url;

          onRequest({ pagination: pagination.value });
        } else {
          mostrarMensaje(
            "Editar pantalla",
            "Error al cargar la pantalla: " + resp.mensaje,
            "err"
          );
        }
      })
      .catch((error) => {
        mostrarMensaje(
          "Editar pantalla",
          "Error al cargar la pantalla: " + error,
          "err"
        );
      });
  }

  revisarPermisos(
    $q.localStorage.getItem("idgrupo"),
    "/Configuracion/PantallaDetalle",
    permGuardar,
    "Guardar"
  );
});

function onClickGuardar() {
  if (ValidarFormulario()) {
    if (registro.value.idPantalla == 0) {
      const req = {
        nombre: registro.value.nombre,
        descripcion: registro.value.descripcion,
        url: registro.value.url,
      };

      api
        .post("/pantalla/PantallaInsert", req, {
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
          },
        })
        .then((response) => {
          var resp = response.data;

          if (resp.resultado > 0) {
            registro.value.idPantalla = resp.resultado;

            guardarLogSistema(
              $q.localStorage.getItem("idusuario"),
              "/Configuracion/PantallaDetalle",
              "Agregar pantalla",
              "Pantalla " + registro.value.nombre + " creada con éxito",
              "Información"
            );

            onRequest({ pagination: pagination.value });
          } else {
            mostrarMensaje(
              "Guardar pantalla",
              "Ocurrió un error al agregar la pantalla: " + resp.mensaje,
              "err"
            );
          }
        })
        .catch((error) => {
          mostrarMensaje(
            "Guardar pantalla",
            "Ocurrió un error al agregar la pantalla: " + error,
            "err"
          );
        });
    } else {
      const req = {
        idPantalla: registro.value.idPantalla,
        nombre: registro.value.nombre,
        descripcion: registro.value.descripcion,
        url: registro.value.url,
      };

      api
        .post("/pantalla/PantallaUpdate", req, {
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
          },
        })
        .then((response) => {
          var resp = response.data;

          if (resp.resultado > 0) {
            registro.value.idPantalla = resp.resultado;

            guardarLogSistema(
              $q.localStorage.getItem("idusuario"),
              "/Configuracion/PantallaDetalle",
              "Modificar pantalla",
              "Pantalla " + registro.value.nombre + " modificada con éxito",
              "Información"
            );
            guardarPermiso(0);
          } else {
            mostrarMensaje(
              "Guardar pantalla",
              "Ocurrió un error al modificar la pantalla: " + resp.mensaje,
              "err"
            );
          }
        })
        .catch((error) => {
          mostrarMensaje(
            "Guardar pantalla",
            "Ocurrió un error al modificar la pantalla: " + error,
            "err"
          );
        });
    }
  }
}

function onClickCancelar() {
  window.location.href = "#/Configuracion/PantallaLista";
}
</script>

<template>
  <q-page class="bg-grey-3 items-center qpage">
    <q-card class="q-pa-md mi-card" bordered
      ><q-card-section>
        <div class="text-h6">Detalle de Pantalla</div>
      </q-card-section>
      <q-separator />
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-12">
            <q-input
              color="primary"
              v-model="registro.nombre"
              outlined
              label="Nombre de pantalla"
              clearable
              clear-icon="close"
              ref="refNombre"
              :rules="[(val) => !!val || 'El nombre es requerido']"
            ></q-input>
          </div>
          <div class="q-pa-sm col-12 col-md-12">
            <q-input
              color="primary"
              v-model="registro.descripcion"
              outlined
              label="Descripción"
              clearable
              clear-icon="close"
            ></q-input>
          </div>
          <div class="q-pa-sm col-12 col-md-12">
            <q-input
              color="primary"
              v-model="registro.url"
              outlined
              label="URL"
              clearable
              clear-icon="close"
              ref="refUrl"
              :rules="[(val) => !!val || 'La URL es requerida']"
            ></q-input>
          </div>
        </div>
      </q-card-section>
      <q-separator v-if="registro.idPantalla > 0" />
      <q-card-section>
        <div class="text-h6" v-if="registro.idPantalla > 0">Acciones</div>
      </q-card-section>
      <q-card-section v-if="registro.idPantalla > 0">
        <q-table
          bordered
          ref="tableRef"
          :rows="rows"
          :columns="columns"
          row-key="idAccion"
          v-model:pagination="pagination"
          :loading="loading"
          binary-state-sort
          @request="onRequest"
          no-data-label="No hay registros de pantallas"
          :rows-per-page-options="[0]"
          separator="cell"
          table-header-class="bg-blue-3"
          :hide-pagination="true"
          ><template v-slot:body="props">
            <q-tr :props="props">
              <q-td>
                {{ props.row.nombre }}
              </q-td>
              <q-td>
                <q-toggle
                  v-model="props.row.asociado"
                  checked-icon="check"
                  unchecked-icon="clear"
                ></q-toggle>
              </q-td>
            </q-tr>
          </template>
        </q-table>
      </q-card-section>
      <q-card-actions align="right" class="text-primary">
        <q-btn
          label="Cancelar"
          color="grey-10"
          icon="arrow_back"
          @click="onClickCancelar"
        />
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
