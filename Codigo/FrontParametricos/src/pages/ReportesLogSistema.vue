<script lang="ts" setup>
//Imports
import { ref, onMounted } from "vue";
import { api } from "boot/axios";
import { useQuasar } from "quasar";
import { formatoFechaBD, formatoFechaHora } from "../functions/funciones";

const $q = useQuasar();

//Columnas
const columns = [
  {
    name: "fecha",
    label: "Fecha",
    align: "left",
    field: "fecha",
    sortable: true,
    format: (val) => formatoFechaHora(new Date(val), true),
  },
  {
    name: "login",
    label: "Usuario",
    align: "left",
    field: "login",
    sortable: true,
  },
  {
    name: "grupo",
    label: "Grupo",
    align: "left",
    field: "grupo",
    sortable: true,
  },
  {
    name: "pantalla",
    label: "Pantalla",
    align: "left",
    field: "pantalla",
    sortable: true,
  },
  {
    name: "accion",
    label: "Acción",
    align: "left",
    field: "accion",
    sortable: true,
  },
  ,
  {
    name: "descripcion",
    label: "Descripción",
    align: "left",
    field: "descripcion",
    sortable: true,
  },
  ,
  {
    name: "tipo",
    label: "Tipo",
    align: "left",
    field: "tipo",
    sortable: true,
  },
  ,
  {
    name: "ip",
    label: "IP",
    align: "left",
    field: "ip",
    sortable: true,
  },
];

//Variables
const tableRef = ref();
const rows = ref([]);
const loading = ref(false);

const pagination = ref({
  sortBy: "fecha",
  descending: true,
  page: 1,
  rowsPerPage: 100,
  rowsNumber: 0,
});

const rowNumber = ref(0);

const opcionesGrupoLista = ref([{ idGrupo: 0, nombre: "Cualquiera" }]);
const opcionesPantallaLista = ref([{ idPantalla: 0, nombre: "Cualquiera" }]);

const filtroDescripcion = ref("");
const filtroLogin = ref("");
const filtroFechaIni = ref(formatoFechaBD(new Date()));
const filtroFechaFin = ref(formatoFechaBD(new Date()));
const filtroGrupo = ref({ idGrupo: 0, nombre: "Cualquiera" });
const filtroPantalla = ref({ idPantalla: 0, nombre: "Cualquiera" });

//Llamadas a servidor
function fetchFromServer(page, rowsPerPage, sortBy, descending) {
  const req = {
    idLogSistema: 0,
    tipo: "",
    idPantalla: filtroPantalla.value.idPantalla,
    fechaInicial: filtroFechaIni.value,
    fechaFinal: filtroFechaFin.value,
    descripcion: filtroDescripcion.value ?? "",
    usuario: filtroLogin.value ?? "",
    ip: "",
    accion: "",
    idUsuario: 0,
    idGrupo: filtroGrupo.value.idGrupo,
    initRow: (page - 1) * rowsPerPage + 1,
    endRow: (page - 1) * rowsPerPage + rowsPerPage,
    sortColumn: sortBy,
    sortDir: descending ? "DESC" : "ASC",
  };

  //console.log(req);

  return api
    .post("/logSistema/LogSistemaSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        rows.value = resp.logs;
        //console.log(resp.logs);
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
    idLogSistema: 0,
    tipo: "",
    idPantalla: filtroPantalla.value.idPantalla,
    fechaInicial: filtroFechaIni.value,
    fechaFinal: filtroFechaFin.value,
    descripcion: filtroDescripcion.value ?? "",
    usuario: filtroLogin.value ?? "",
    ip: "",
    accion: "",
    idUsuario: 0,
    idGrupo: filtroGrupo.value.idGrupo,
  };

  //console.log(req);

  return api
    .post("/logSistema/LogSistemaCount", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      //console.log(response.data);

      if (resp.codigo == 1) {
        rowNumber.value = resp.resultado;
      } else {
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

//Eventos
onMounted(() => {
  const req = {
    idGrupo: 0,
    nombre: "",
    initRow: 1,
    endRow: 1000,
    sortColumn: "Nombre",
    sortDir: "ASC",
  };

  const reqp = {
    idPantalla: 0,
    nombre: "",
    descripcion: "",
    url: "",
    initRow: 1,
    endRow: 1000,
    sortColumn: "Nombre",
    sortDir: "ASC",
  };

  api
    .post("/grupo/GrupoSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        opcionesGrupoLista.value.splice(1, 0, ...resp.grupos);
      } else {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    });

  api
    .post("/pantalla/PantallaSelect", reqp, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        opcionesPantallaLista.value.splice(1, 0, ...resp.pantallas);
      } else {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    });

  onRequest({ pagination: pagination.value });
});

function onClickBuscar() {
  onRequest({ pagination: pagination.value });
}
</script>

<template>
  <div>
    <q-page class="qpage">
      <q-card class="q-pa-md q-gutter-sm"
        ><q-card-section>
          <div class="text-h6">Log del Sistema</div>
        </q-card-section>
        <q-separator />
        <q-card-section>
          <div class="row">
            <div class="q-pa-sm col-12 col-md-6">
              <q-input
                color="primary"
                v-model="filtroLogin"
                outlined
                label="Login"
                clearable
                clear-icon="close"
              ></q-input>
            </div>
            <div class="q-pa-sm col-12 col-md-6">
              <q-input
                color="primary"
                v-model="filtroDescripcion"
                outlined
                label="Descripción"
                clearable
                clear-icon="close"
              ></q-input>
            </div>
            <div class="q-pa-sm col-12 col-md-6">
              <q-input
                color="primary"
                v-model="filtroFechaIni"
                outlined
                label="Fecha Inicio"
                clearable
                clear-icon="close"
                type="date"
              ></q-input>
            </div>
            <div class="q-pa-sm col-12 col-md-6">
              <q-input
                color="primary"
                v-model="filtroFechaFin"
                outlined
                label="Fecha Fin"
                clearable
                clear-icon="close"
                type="date"
              ></q-input>
            </div>
            <div class="q-pa-sm col-10 col-md-6">
              <q-select
                outlined
                v-model="filtroPantalla"
                :options="opcionesPantallaLista"
                label="Pantalla"
                option-label="nombre"
                option-value="idPantalla"
              />
            </div>
            <div class="q-pa-sm col-10 col-md-3">
              <q-select
                outlined
                v-model="filtroGrupo"
                :options="opcionesGrupoLista"
                label="Grupo"
                option-label="nombre"
                option-value="idGrupo"
              />
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
          </div>
        </q-card-section>
        <q-card-section>
          <q-table
            bordered
            ref="tableRef"
            :rows="rows"
            :columns="columns"
            row-key="idLogSistema"
            v-model:pagination="pagination"
            :loading="loading"
            binary-state-sort
            @request="onRequest"
            selection="none"
            no-data-label="No hay registros de log del sistema"
            :rows-per-page-options="[0]"
            separator="cell"
            table-header-class="bg-blue-3"
          >
          </q-table>
        </q-card-section>
      </q-card>
    </q-page>
  </div>
</template>

<style lang="css" scoped></style>
