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

const registro = ref({
  idAccion: 0,
  nombre: "",
  descripcion: "",
});

const Editar = ref(false);
const refNombre = ref(null);

//Permisos
const permNuevo = ref(false);
const permEliminar = ref(false);
const permGuardar = ref(false);

//Llamadas a servidor
function fetchFromServer(page, rowsPerPage, sortBy, descending) {
  const req = {
    idAccion: 0,
    nombre: filtroNombre.value ?? "",
    descripcion: "",
    initRow: (page - 1) * rowsPerPage + 1,
    endRow: (page - 1) * rowsPerPage + rowsPerPage,
    sortColumn: sortBy,
    sortDir: descending ? "DESC" : "ASC",
  };

  return api
    .post("/accion/AccionSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        rows.value = resp.acciones;
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
    idAccion: 0,
    nombre: filtroNombre.value ?? "",
    descripcion: "",
  };

  return api
    .post("/accion/AccionCount", req, {
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

function ValidarFormulario() {
  refNombre.value.validate();
  return !refNombre.value.hasError;
}

//Eventos
onMounted(() => {
  onRequest({ pagination: pagination.value });
  revisarPermisos(
    $q.localStorage.getItem("idgrupo"),
    "/Configuracion/Acciones",
    permEliminar,
    "Eliminar",
    permGuardar,
    "Guardar",
    permNuevo,
    "Nuevo"
  );
});

function onClickBuscar() {
  onRequest({ pagination: pagination.value });
}

function seleccionarRegistro(e, obj, index) {
  registro.value = Object.assign({}, obj);
  Editar.value = true;
}

function onClickNuevo() {
  registro.value = {
    idAccion: 0,
    nombre: "",
    descripcion: "",
  };

  Editar.value = true;
}

function onClickEliminar() {
  if (selected.value.length == 0) {
    mostrarMensaje(
      "Eliminar acciones",
      "No se ha seleccionado acciones para eliminar",
      "adv"
    );
  } else {
    $q.dialog({
      title: "Eliminar acciones",
      message: "¿Confirma que desea eliminar las acciones seleccionadas?",
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
    idAccion: selected.value[indice].idAccion,
  };

  api
    .post("/accion/AccionDelete", req, {
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
          "/Configuracion/Acciones",
          "Eliminar acción",
          "Acción " + selected.value[indice].nombre + " eliminada con éxito",
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
          "Eliminar acciones",
          "Error al eliminar la acción " +
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
        "Eliminar acciones",
        "Error al eliminar la acción " +
          selected.value[0].nombre +
          ": " +
          error,
        "err"
      );
    });
}

function onClickGuardar() {
  if (ValidarFormulario()) {
    if (registro.value.idAccion == 0) {
      const req = {
        nombre: registro.value.nombre,
        descripcion: registro.value.descripcion,
      };

      api
        .post("/accion/AccionInsert", req, {
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
          },
        })
        .then((response) => {
          var resp = response.data;

          if (resp.resultado > 0) {
            registro.value.idAccion = resp.resultado;

            guardarLogSistema(
              $q.localStorage.getItem("idusuario"),
              "/Configuracion/Acciones",
              "Agregar acción",
              "Acción " + registro.value.nombre + " creada con éxito",
              "Información"
            );
            Editar.value = false;
            onClickBuscar();
          } else {
            mostrarMensaje(
              "Guardar Acción",
              "Ocurrió un error al agregar la acción: " + resp.mensaje,
              "err"
            );
          }
        })
        .catch((error) => {
          mostrarMensaje(
            "Guardar Acción",
            "Ocurrió un error al agregar la acción: " + error,
            "err"
          );
        });
    } else {
      const req = {
        idAccion: registro.value.idAccion,
        nombre: registro.value.nombre,
        descripcion: registro.value.descripcion,
      };

      api
        .post("/accion/accionUpdate", req, {
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
          },
        })
        .then((response) => {
          var resp = response.data;

          if (resp.resultado > 0) {
            registro.value.idAccion = resp.resultado;

            guardarLogSistema(
              $q.localStorage.getItem("idusuario"),
              "/Configuracion/Acciones",
              "Modificar Acción",
              "Acción " + registro.value.nombre + " modificada con éxito",
              "Información"
            );
            Editar.value = false;
            onClickBuscar();
          } else {
            mostrarMensaje(
              "Guardar Acción",
              "Ocurrió un error al modificar la acción: " + resp.mensaje,
              "err"
            );
          }
        })
        .catch((error) => {
          mostrarMensaje(
            "Guardar Acción",
            "Ocurrió un error al modificar la acción: " + error,
            "err"
          );
        });
    }
  }
}
</script>

<template>
  <div>
    <q-page class="bg-grey-3 qpage">
      <q-card class="q-pa-md q-gutter-sm" bordered
        ><q-card-section>
          <div class="text-h6">Acciones del Sistema</div>
        </q-card-section>
        <q-separator />
        <q-card-section>
          <div class="row">
            <div class="q-pa-sm col-10 col-md-4">
              <q-input
                color="primary"
                v-model="filtroNombre"
                outlined
                label="Acción"
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
            label="Agregar Acción"
            @click="onClickNuevo"
            v-if="permNuevo"
          >
          </q-btn>
          <q-btn
            icon="delete"
            color="red-10"
            label="Eliminar Acción(es)"
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
            row-key="idAccion"
            v-model:pagination="pagination"
            :loading="loading"
            binary-state-sort
            @request="onRequest"
            selection="multiple"
            v-model:selected="selected"
            no-data-label="No hay registros de acciones"
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
    <q-dialog v-model="Editar" persistent>
      <q-card style="width: 50%">
        <q-card-section class="bg-grey-4">
          <div class="text-h6">Agregar/Editar Acción</div>
        </q-card-section>
        <q-separator />
        <q-card-section class="q-pa-none">
          <div class="row">
            <div class="col-12 col-md-12 q-pa-sm">
              <q-input
                outlined
                label="Nombre"
                v-model="registro.nombre"
                ref="refNombre"
                :rules="[(val) => !!val || 'El nombre es requerido']"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-md-12 q-pa-sm">
              <q-input
                outlined
                label="Descripción"
                v-model="registro.descripcion"
              />
            </div>
          </div>
        </q-card-section>

        <q-card-actions align="right" class="text-primary">
          <q-btn label="Cancelar" color="red-10" icon="cancel" v-close-popup />
          <q-btn
            label="Aceptar"
            color="primary"
            @click="onClickGuardar"
            v-if="permGuardar"
            icon="check"
          />
        </q-card-actions>
      </q-card>
    </q-dialog>
  </div>
</template>

<style lang="css" scoped></style>
