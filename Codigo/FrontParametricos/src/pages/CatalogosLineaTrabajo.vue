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
    name: "clave",
    label: "Clave de Trabajo",
    align: "left",
    field: "clave",
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

const opcionesClaveLista = ref([{ idClaveTrabajo: 0, clave: "Cualquiera" }]);
const opcionesClaveDetalle = ref([]);

const filtroNombre = ref("");
const filtroClave = ref({
  idClaveTrabajo: 0,
  clave: "Cualquiera",
});

const registro = ref({
  idLineaTrabajo: 0,
  nombre: "",
  idClaveTrabajo: 0,
  clave: "",
});

const claveModel = ref({ idClaveTrabajo: 0, clave: "" });

const Editar = ref(false);
const refNombre = ref(null);

//Permisos
const permNuevo = ref(true);
const permEliminar = ref(true);
const permGuardar = ref(true);

//Llamadas a servidor
function fetchFromServer(page, rowsPerPage, sortBy, descending) {
  const req = {
    idLineaTrabajo: 0,
    nombre: filtroNombre.value ?? "",
    idClaveTrabajo: filtroClave.value.idClaveTrabajo,
    initRow: (page - 1) * rowsPerPage + 1,
    endRow: (page - 1) * rowsPerPage + rowsPerPage,
    sortColumn: sortBy,
    sortDir: descending ? "DESC" : "ASC",
  };

  return api
    .post("/lineatrabajo/LineaTrabajoSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        rows.value = resp.lineasTrabajo;
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
    idLineaTrabajo: 0,
    nombre: filtroNombre.value ?? "",
    idClaveTrabajo: filtroClave.value.idClaveTrabajo,
  };

  return api
    .post("/lineatrabajo/LineaTrabajoCount", req, {
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
  const req = {
    idClaveTrabajo: 0,
    clave: "",
    incluye: "",
    initRow: 1,
    endRow: 1000,
    sortColumn: "Clave",
    sortDir: "ASC",
  };

  api
    .post("/clavetrabajo/ClaveTrabajoSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        opcionesClaveLista.value.splice(1, 0, ...resp.clavesTrabajo);
        opcionesClaveDetalle.value = resp.clavesTrabajo;
      } else {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    });

  onRequest({ pagination: pagination.value });

  //revisarPermisos(
  //  $q.localStorage.getItem("idgrupo"),
  //  "/Catalogos/LineaTrabajo",
  //  permEliminar,
  //  "Eliminar",
  //  permGuardar,
  //  "Guardar",
  //  permNuevo,
  //  "Nuevo"
  //);
});

function onClickBuscar() {
  onRequest({ pagination: pagination.value });
}

function seleccionarRegistro(e, obj, index) {
  registro.value = Object.assign({}, obj);

  claveModel.value = opcionesClaveDetalle.value.filter((ob) => {
    return ob.idClaveTrabajo == obj.idClaveTrabajo;
  })[0];

  Editar.value = true;
}

function onClickNuevo() {
  registro.value = {
    idLineaTrabajo: 0,
    nombre: "",
    idClaveTrabajo: opcionesClaveDetalle.value[0].idClaveTrabajo,
    clave: "",
  };

  claveModel.value = opcionesClaveDetalle.value[0];

  Editar.value = true;
}

function onClickEliminar() {
  if (selected.value.length == 0) {
    mostrarMensaje(
      "Eliminar líneas",
      "No se han seleccionado líneas para eliminar",
      "adv"
    );
  } else {
    $q.dialog({
      title: "Eliminar líneas",
      message: "¿Confirma que desea eliminar las líneas seleccionadas?",
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
    idLineaTrabajo: selected.value[indice].idLineaTrabajo,
  };

  api
    .post("/lineatrabajo/LineaTrabajoDelete", req, {
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
          "/Catalogos/LineaTrabajo",
          "Eliminar línea",
          "Línea " + selected.value[indice].nombre + " eliminada con éxito",
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
          "Eliminar líneas",
          "Error al eliminar la línea " +
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
        "Eliminar líneas",
        "Error al eliminar la línea " + selected.value[0].nombre + ": " + error,
        "err"
      );
    });
}

function onClickGuardar() {
  if (ValidarFormulario()) {
    if (registro.value.idLineaTrabajo == 0) {
      const req = {
        nombre: registro.value.nombre,
        idClaveTrabajo: claveModel.value.idClaveTrabajo,
      };

      api
        .post("/lineatrabajo/LineaTrabajoInsert", req, {
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
          },
        })
        .then((response) => {
          var resp = response.data;

          if (resp.resultado > 0) {
            registro.value.idLineaTrabajo = resp.resultado;

            guardarLogSistema(
              $q.localStorage.getItem("idusuario"),
              "/Catalogos/LineaTrabajo",
              "Agregar Línea",
              "Línea " + registro.value.nombre + " creada con éxito",
              "Información"
            );
            Editar.value = false;
            onClickBuscar();
          } else {
            mostrarMensaje(
              "Guardar Línea",
              "Ocurrió un error al agregar la línea: " + resp.mensaje,
              "err"
            );
          }
        })
        .catch((error) => {
          mostrarMensaje(
            "Guardar Línea",
            "Ocurrió un error al agregar la línea: " + error,
            "err"
          );
        });
    } else {
      const req = {
        idLineaTrabajo: registro.value.idLineaTrabajo,
        nombre: registro.value.nombre,
        idClaveTrabajo: claveModel.value.idClaveTrabajo,
      };

      api
        .post("/lineatrabajo/LineaTrabajoUpdate", req, {
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
          },
        })
        .then((response) => {
          var resp = response.data;

          if (resp.resultado > 0) {
            registro.value.idLineaTrabajo = resp.resultado;

            guardarLogSistema(
              $q.localStorage.getItem("idusuario"),
              "/Catalogos/LineaTrabajo",
              "Modificar Línea",
              "Línea " + registro.value.nombre + " modificado con éxito",
              "Información"
            );
            Editar.value = false;
            onClickBuscar();
          } else {
            mostrarMensaje(
              "Guardar Línea",
              "Ocurrió un error al modificar la Línea: " + resp.mensaje,
              "err"
            );
          }
        })
        .catch((error) => {
          mostrarMensaje(
            "Guardar Línea",
            "Ocurrió un error al modificar la Línea: " + error,
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
          <div class="text-h6">Líneas de Trabajo</div>
        </q-card-section>
        <q-separator />
        <q-card-section>
          <div class="row">
            <div class="q-pa-sm col-10 col-md-5">
              <q-input
                color="primary"
                v-model="filtroNombre"
                outlined
                label="Línea"
                clearable
                clear-icon="close"
              ></q-input>
            </div>
            <div class="q-pa-sm col-10 col-md-5">
              <q-select
                outlined
                v-model="filtroClave"
                :options="opcionesClaveLista"
                label="Clave de Trabajo"
                option-label="clave"
                option-value="idClaveTrabajo"
              />
            </div>
            <div class="q-pa-sm col-2 col-md-2">
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
            label="Agregar Línea"
            @click="onClickNuevo"
            v-if="permNuevo"
          >
          </q-btn>
          <q-btn
            icon="delete"
            color="red-10"
            label="Eliminar Línea(s)"
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
            row-key="idLineaTrabajo"
            v-model:pagination="pagination"
            :loading="loading"
            binary-state-sort
            @request="onRequest"
            selection="multiple"
            v-model:selected="selected"
            no-data-label="No hay registros de líneas"
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
          <div class="text-h6">Agregar/Editar Línea</div>
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
              <q-select
                outlined
                v-model="claveModel"
                :options="opcionesClaveDetalle"
                label="Clave de Trabajo"
                option-label="clave"
                option-value="idClaveTrabajo"
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
