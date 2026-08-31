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
    label: "Diámetro",
    align: "left",
    field: "nombre",
    sortable: true,
  },
];

//Variables
const tableRef = ref();
const rows = ref([]);
const loading = ref(false);

const pagination = ref({
  sortBy: "Diámetro",
  descending: false,
  page: 1,
  rowsPerPage: 100,
  rowsNumber: 0,
});

const rowNumber = ref(0);
const selected = ref([]);

const filtroNombre = ref("");

const registro = ref({
  idDiametro: 0,
  nombre: "",
});

const Editar = ref(false);
const refNombre = ref(null);

//Permisos
const permNuevo = ref(true);
const permEliminar = ref(true);
const permGuardar = ref(true);

//Llamadas a servidor
function fetchFromServer(page, rowsPerPage, sortBy, descending) {
  const req = {
    idDiametro: 0,
    nombre: filtroNombre.value,
    initRow: (page - 1) * rowsPerPage + 1,
    endRow: (page - 1) * rowsPerPage + rowsPerPage,
    sortColumn: sortBy,
    sortDir: descending ? "DESC" : "ASC",
  };

  return api
    .post("/diametro/DiametroSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        rows.value = resp.diametros;
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
    idDiametro: 0,
    nombre: filtroNombre.value,
  };

  return api
    .post("/diametro/DiametroCount", req, {
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

  //revisarPermisos(
  //  $q.localStorage.getItem("idgrupo"),
  //  "/Catalogos/Diametro",
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
  Editar.value = true;
}

function onClickNuevo() {
  registro.value = {
    idDiametro: 0,
    nombre: "",
  };

  Editar.value = true;
}

function onClickEliminar() {
  if (selected.value.length == 0) {
    mostrarMensaje(
      "Eliminar Diámetros",
      "No se han seleccionado Diámetros para eliminar",
      "adv"
    );
  } else {
    $q.dialog({
      title: "Eliminar Diámetros",
      message: "¿Confirma que desea eliminar los Diámetros seleccionados?",
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
    idDiametro: selected.value[indice].idDiametro,
  };

  api
    .post("/diametro/DiametroDelete", req, {
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
          "/Catalogos/Diametro",
          "Eliminar Diámetro",
          "Diámetro " + selected.value[indice].nombre + " eliminado con éxito",
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
          "Eliminar Diámetros",
          "Error al eliminar el Diámetro " +
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
        "Eliminar Diámetros",
        "Error al eliminar el Diámetro " +
          selected.value[0].nombre +
          ": " +
          error,
        "err"
      );
    });
}

function onClickGuardar() {
  if (ValidarFormulario()) {
    if (registro.value.idDiametro == 0) {
      const req = {
        nombre: registro.value.nombre,
      };

      api
        .post("/diametro/DiametroInsert", req, {
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
          },
        })
        .then((response) => {
          var resp = response.data;

          if (resp.resultado > 0) {
            registro.value.idDiametro = resp.resultado;

            guardarLogSistema(
              $q.localStorage.getItem("idusuario"),
              "/Catalogos/Diametro",
              "Agregar Diámetro",
              "Diámetro " + registro.value.nombre + " creado con éxito",
              "Información"
            );
            Editar.value = false;
            onClickBuscar();
          } else {
            mostrarMensaje(
              "Guardar nombre",
              "Ocurrió un error al agregar el Diámetro: " + resp.mensaje,
              "err"
            );
          }
        })
        .catch((error) => {
          mostrarMensaje(
            "Guardar nombre",
            "Ocurrió un error al agregar el Diámetro: " + error,
            "err"
          );
        });
    } else {
      const req = {
        idDiametro: registro.value.idDiametro,
        nombre: registro.value.nombre,
      };

      api
        .post("/diametro/DiametroUpdate", req, {
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
          },
        })
        .then((response) => {
          var resp = response.data;

          if (resp.resultado > 0) {
            registro.value.idDiametro = resp.resultado;

            guardarLogSistema(
              $q.localStorage.getItem("idusuario"),
              "/Catalogos/Diametro",
              "Modificar Diámetro",
              "Diámetro " + registro.value.nombre + " modificado con éxito",
              "Información"
            );
            Editar.value = false;
            onClickBuscar();
          } else {
            mostrarMensaje(
              "Guardar Diámetro",
              "Ocurrió un error al modificar el Diámetro: " + resp.mensaje,
              "err"
            );
          }
        })
        .catch((error) => {
          mostrarMensaje(
            "Guardar Diámetro",
            "Ocurrió un error al modificar el Diámetro: " + error,
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
          <div class="text-h6">Diámetros</div>
        </q-card-section>
        <q-separator />
        <q-card-section>
          <div class="row">
            <div class="q-pa-sm col-10 col-md-5">
              <q-input
                color="primary"
                v-model="filtroNombre"
                outlined
                label="Diámetro"
                clearable
                clear-icon="close"
              ></q-input>
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
            label="Agregar Diámetro"
            @click="onClickNuevo"
            v-if="permNuevo"
          >
          </q-btn>
          <q-btn
            icon="delete"
            color="red-10"
            label="Eliminar Diámetro(s)"
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
            row-key="idDiametro"
            v-model:pagination="pagination"
            :loading="loading"
            binary-state-sort
            @request="onRequest"
            selection="multiple"
            v-model:selected="selected"
            no-data-label="No hay registros de Diámetros"
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
          <div class="text-h6">Agregar/Editar Diámetro</div>
        </q-card-section>
        <q-separator />
        <q-card-section class="q-pa-none">
          <div class="row">
            <div class="col-12 col-md-12 q-pa-sm">
              <q-input
                outlined
                label="Diámetro"
                v-model="registro.nombre"
                ref="refNombre"
                :rules="[(val) => !!val || 'El nombre es requerido']"
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
