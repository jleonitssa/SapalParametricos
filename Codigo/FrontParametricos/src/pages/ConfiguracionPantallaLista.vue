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

//Columnas
const columns = [
  {
    name: "nombre",
    label: "Nombre",
    align: "left",
    field: "nombre",
    sortable: true,
  },
  {
    name: "descripcion",
    label: "Descripción",
    align: "left",
    field: "descripcion",
    sortable: true,
  },
  {
    name: "url",
    label: "URL",
    align: "left",
    field: "url",
    sortable: true,
  },
];

//Variables
const tableRef = ref();
const rows = ref([]);
const loading = ref(false);

const pagination = ref({
  sortBy: "nombre",
  descending: false,
  page: 1,
  rowsPerPage: 100,
  rowsNumber: 0,
});

const rowNumber = ref(0);
const selected = ref([]);

const filtroNombre = ref("");

//Permisos
const permNuevo = ref(false);
const permEliminar = ref(false);

//Llamadas a servidor
function fetchFromServer(page, rowsPerPage, sortBy, descending) {
  const req = {
    idPantalla: 0,
    nombre: filtroNombre.value ?? "",
    descripcion: "",
    url: "",
    initRow: (page - 1) * rowsPerPage + 1,
    endRow: (page - 1) * rowsPerPage + rowsPerPage,
    sortColumn: sortBy,
    sortDir: descending ? "DESC" : "ASC",
  };

  return api
    .post("/pantalla/PantallaSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        rows.value = resp.pantallas;
      } else {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    })
    .finally(() => {});
}

function getRowsNumberCount() {
  const req = {
    idPantalla: 0,
    nombre: filtroNombre.value ?? "",
    descripcion: "",
    url: "",
  };

  return api
    .post("/pantalla/PantallaCount", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        rowNumber.value = resp.resultado;
      } else {
        console.log(resp.mensaje);
        rowNumber.value = 0;
      }
    })
    .catch((error) => {
      console.log(error);
      rowNumber.value = 0;
    });
}

//Otras funciones
function onRequest(props) {
  const { page, rowsPerPage, sortBy, descending } = props.pagination;

  loading.value = true;

  getRowsNumberCount()
    .then((response) => {
      // fetch data from "server"
      fetchFromServer(page, rowsPerPage, sortBy, descending)
        .then((response) => {
          // don't forget to update local pagination object
          pagination.value.page = page;
          pagination.value.rowsPerPage = rowsPerPage;
          pagination.value.sortBy = sortBy;
          pagination.value.descending = descending;
          pagination.value.rowsNumber = rowNumber.value;
        })
        .catch((error) => {
          console.log(error);
        })
        .finally(() => {});
    })
    .catch((error) => {
      console.log(error);
    })
    .finally(() => {
      // ...and turn of loading indicator
      loading.value = false;
    });
}

function getSelectedString() {
  return selected.value.length === 0
    ? ""
    : `${selected.value.length} registro(s) seleccionado(s) de ${rows.value.length}`;
}

//Eventos
onMounted(() => {
  onRequest({ pagination: pagination.value });

  revisarPermisos(
    $q.localStorage.getItem("idgrupo"),
    "/Configuracion/PantallaLista",
    permEliminar,
    "Eliminar",
    permNuevo,
    "Nuevo"
  );
});

function onClickBuscar() {
  onRequest({ pagination: pagination.value });
}

function seleccionarRegistro(e, obj, index) {
  window.location.href =
    "#/Configuracion/PantallaDetalle?IDPantalla=" + obj.idPantalla;
}

function onClickNuevo() {
  window.location.href = "#/Configuracion/PantallaDetalle?IDPantalla=0";
}

function onClickEliminar() {
  if (selected.value.length == 0) {
    mostrarMensaje(
      "Eliminar pantallas",
      "No se ha seleccionado pantallas para eliminar",
      "adv"
    );
  } else {
    $q.dialog({
      title: "Eliminar pantallas",
      message: "¿Confirma que desea eliminar las pantallas seleccionadas?",
      ok: "Aceptar",
      cancel: "Cancelar",
      persistent: true,
    })
      .onOk(() => {
        Eliminar(0);
      })
      .onCancel(() => {});
  }
}

function Eliminar(indice) {
  const req = {
    idPantalla: selected.value[indice].idPantalla,
  };

  api
    .post("/pantalla/PantallaDelete", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        guardarLogSistema(
          $q.localStorage.getItem("idusuario"),
          "/Configuracion/PantallaLista",
          "Eliminar pantalla",
          "Pantalla " + selected.value[indice].nombre + " eliminada con éxito",
          "Información"
        );

        if (indice + 1 < selected.value.length) {
          Eliminar(indice + 1);
        } else {
          onClickBuscar();
        }
      } else {
        onClickBuscar();
        mostrarMensaje(
          "Eliminar pantallas",
          "Error al eliminar pantalla " +
            selected.value[0].nombre +
            ": " +
            resp.mensaje,
          "err"
        );
      }
    })
    .catch((error) => {
      onClickBuscar();
      mostrarMensaje(
        "Eliminar pantallas",
        "Error al eliminar pantalla " + selected.value[0].nombre + ": " + error,
        "err"
      );
    });
}
</script>

<template>
  <q-page class="bg-grey-3 qpage">
    <q-card class="q-pa-md q-gutter-sm" bordered
      ><q-card-section>
        <div class="text-h6">Pantallas de Sistema</div>
      </q-card-section>
      <q-separator />
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-10 col-md-4">
            <q-input
              color="primary"
              v-model="filtroNombre"
              outlined
              label="Nombre"
              clearable
              clear-icon="close"
            ></q-input>
          </div>
          <div class="q-pa-sm col-1 col-md-1">
            <q-btn
              icon="search"
              color="primary"
              @click="onClickBuscar"
              size="lg"
            >
            </q-btn>
          </div>
        </div> </q-card-section
      ><q-card-actions>
        <q-btn
          icon="add"
          color="green-10"
          label="Agregar Pantalla"
          @click="onClickNuevo"
          v-if="permNuevo"
        >
        </q-btn>
        <q-btn
          icon="delete"
          color="red-10"
          label="Eliminar Pantalla"
          @click="onClickEliminar"
          v-if="permEliminar"
        >
        </q-btn>
      </q-card-actions>
      <q-card-section>
        <q-table
          bordered
          ref="tableRef"
          :rows="rows"
          :columns="columns"
          row-key="idPantalla"
          v-model:pagination="pagination"
          :loading="loading"
          binary-state-sort
          @request="onRequest"
          selection="multiple"
          v-model:selected="selected"
          no-data-label="No hay registros de pantallas"
          :rows-per-page-options="[0]"
          :selected-rows-label="getSelectedString"
          separator="cell"
          class="cursor-pointer"
          @row-click="seleccionarRegistro"
          table-header-class="bg-blue-3"
        >
        </q-table>
      </q-card-section>
    </q-card>
  </q-page>
</template>

<style lang="css" scoped></style>
