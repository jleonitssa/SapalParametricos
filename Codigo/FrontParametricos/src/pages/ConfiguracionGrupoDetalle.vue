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
    name: "pantalla",
    label: "Pantalla",
    align: "left",
    field: "pantalla",
    sortable: false,
  },
  {
    name: "accion",
    label: "Acción",
    align: "left",
    field: "accion",
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
  sortBy: "pantalla",
  descending: false,
  page: 1,
  rowsPerPage: 1000,
  rowsNumber: 1000,
});

const rowNumber = ref(1000);

const registro = ref({
  idGrupo: 0,
  nombre: "",
  descripcion: "",
});

const refNombre = ref(null);

//Permisos
const permGuardar = ref(false);

//Llamadas a servidor
function fetchFromServer(page, rowsPerPage, sortBy, descending) {
  const req = {
    idGrupo: registro.value.idGrupo,
    idPantalla: 0,
    pantalla: "",
  };

  return api
    .post("/accion/AccionXPantallaXGrupoGrid", req, {
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

//Otras funciones
function onRequest(props) {
  const { page, rowsPerPage, sortBy, descending } = props.pagination;

  loading.value = true;

  fetchFromServer(page, rowsPerPage, sortBy, descending);

  // don't forget to update local pagination object
  pagination.value.page = page;
  pagination.value.rowsPerPage = rowsPerPage;
  pagination.value.sortBy = sortBy;
  pagination.value.descending = descending;
  pagination.value.rowsNumber = rowNumber.value;

  loading.value = false;
}

function ValidarFormulario() {
  refNombre.value.validate();
  return !refNombre.value.hasError;
}

function guardarPermiso(indice) {
  const req = {
    idGrupo: registro.value.idGrupo,
    idAccionPantalla: rows.value[indice].idAccionPantalla,
    checked: rows.value[indice].asociado,
  };
  api
    .post("/accion/AccionXPantallaXGrupoUpdate", req, {
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
          "Asignar permiso",
          "Error al asignar permiso " +
            rows.value[0].accion +
            ": " +
            resp.mensaje,
          "err"
        );
      }
    })
    .catch((error) => {
      onRequest({ pagination: pagination.value });
      mostrarMensaje(
        "Asignar permiso",
        "Error al asignar permiso " + rows.value[0].accion + ": " + error,
        "err"
      );
    });
}

//Eventos
onMounted(() => {
  registro.value.idGrupo = parseInt(obtenerParametroURL("IDGrupo", "0"));
  if (registro.value.idGrupo != 0) {
    const req = {
      idGrupo: registro.value.idGrupo,
      nombre: "",
      initRow: 1,
      endRow: 1,
      sortColumn: "Nombre",
      sortDir: "DESC",
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
          registro.value.nombre = resp.grupos[0].nombre;
          registro.value.descripcion = resp.grupos[0].descripcion;

          onRequest({ pagination: pagination.value });
        } else {
          mostrarMensaje(
            "Editar grupo",
            "Error al cargar el grupo: " + resp.mensaje,
            "err"
          );
        }
      })
      .catch((error) => {
        mostrarMensaje(
          "Editar grupo",
          "Error al cargar el grupo: " + error,
          "err"
        );
      });
  }

  revisarPermisos(
    $q.localStorage.getItem("idgrupo"),
    "/Configuracion/GrupoDetalle",
    permGuardar,
    "Guardar"
  );
});

function onClickGuardar() {
  if (ValidarFormulario()) {
    if (registro.value.idGrupo == 0) {
      const req = {
        nombre: registro.value.nombre,
        descripcion: registro.value.descripcion,
      };

      api
        .post("/grupo/GrupoInsert", req, {
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
          },
        })
        .then((response) => {
          var resp = response.data;

          if (resp.resultado > 0) {
            registro.value.idGrupo = resp.resultado;

            guardarLogSistema(
              $q.localStorage.getItem("idusuario"),
              "/Configuracion/GrupoDetalle",
              "Agregar grupo",
              "Grupo " + registro.value.nombre + " creado con éxito",
              "Información"
            );

            onRequest({ pagination: pagination.value });
          } else {
            mostrarMensaje(
              "Guardar grupo",
              "Ocurrió un error al agregar el grupo: " + resp.mensaje,
              "err"
            );
          }
        })
        .catch((error) => {
          mostrarMensaje(
            "Guardar grupo",
            "Ocurrió un error al agregar el grupo: " + error,
            "err"
          );
        });
    } else {
      const req = {
        idGrupo: registro.value.idGrupo,
        nombre: registro.value.nombre,
        descripcion: registro.value.descripcion,
      };

      api
        .post("/grupo/GrupoUpdate", req, {
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
          },
        })
        .then((response) => {
          var resp = response.data;

          if (resp.resultado > 0) {
            registro.value.idGrupo = resp.resultado;

            guardarLogSistema(
              $q.localStorage.getItem("idusuario"),
              "/Configuracion/GrupoDetalle",
              "Modificar grupo",
              "Grupo " + registro.value.nombre + " modificado con éxito",
              "Información"
            );

            guardarPermiso(0);
          } else {
            mostrarMensaje(
              "Guardar grupo",
              "Ocurrió un error al modificar el grupo: " + resp.mensaje,
              "err"
            );
          }
        })
        .catch((error) => {
          mostrarMensaje(
            "Guardar pantalla",
            "Ocurrió un error al modificar el grupo: " + error,
            "err"
          );
        });
    }
  }
}

function onClickCancelar() {
  window.location.href = "#/Configuracion/GrupoLista";
}
</script>

<template>
  <q-page class="bg-grey-3 items-center qpage">
    <q-card class="q-pa-md mi-card" bordered
      ><q-card-section>
        <div class="text-h6">Detalle de Grupo</div>
      </q-card-section>
      <q-separator />
      <q-card-section>
        <div class="row">
          <div class="q-pa-sm col-12 col-md-12">
            <q-input
              color="primary"
              v-model="registro.nombre"
              outlined
              label="Nombre de grupo"
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
        </div>
      </q-card-section>
      <q-separator v-if="registro.idGrupo > 0" />
      <q-card-section>
        <div class="text-h6" v-if="registro.idGrupo > 0">Acciones</div>
      </q-card-section>
      <q-card-section v-if="registro.idGrupo > 0">
        <q-table
          bordered
          ref="tableRef"
          :rows="rows"
          :columns="columns"
          row-key="idAccionPantallaGrupo"
          v-model:pagination="pagination"
          :loading="loading"
          binary-state-sort
          @request="onRequest"
          no-data-label="No hay registros de acciones por pantalla"
          :rows-per-page-options="[0]"
          separator="cell"
          table-header-class="bg-blue-3"
          :hide-pagination="true"
          ><template v-slot:body="props">
            <q-tr :props="props">
              <q-td>
                {{ props.row.pantalla }}
              </q-td>
              <q-td>
                {{ props.row.accion }}
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
          label="Regresar"
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
