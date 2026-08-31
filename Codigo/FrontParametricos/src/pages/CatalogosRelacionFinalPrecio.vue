<script lang="ts" setup>
//Imports
import { ref, onMounted } from "vue";
import { api } from "boot/axios";
import { useQuasar } from "quasar";
import {
  mostrarMensaje,
  guardarLogSistema,
  revisarPermisos,
  formatoMoneda,
} from "../functions/funciones";

const $q = useQuasar();

//Columnas
const columns = [
  {
    name: "lineaTrabajo",
    label: "Línea de Trabajo",
    align: "left",
    field: "lineaTrabajo",
    sortable: true,
  },
  {
    name: "tipoMaterial",
    label: "Tipo de Material",
    align: "left",
    field: "tipoMaterial",
    sortable: true,
  },
  {
    name: "tipoObra",
    label: "Tipo de Obra",
    align: "left",
    field: "tipoObra",
    sortable: true,
  },
  {
    name: "tuberia",
    label: "Tubería",
    align: "left",
    field: "tuberia",
    sortable: true,
  },
  {
    name: "diametro",
    label: "Diámetro",
    align: "left",
    field: "diametro",
    sortable: true,
  },
  {
    name: "excavacion",
    label: "Excavación",
    align: "left",
    field: "excavacion",
    sortable: true,
  },
  {
    name: "precio",
    label: "Precio",
    align: "right",
    field: "precio",
    sortable: true,
    format: (val) => formatoMoneda(new Date(val)),
  },
];

//Variables
const tableRef = ref();
const rows = ref([]);
const loading = ref(false);

const pagination = ref({
  sortBy: "idRelacion",
  descending: false,
  page: 1,
  rowsPerPage: 100,
  rowsNumber: 0,
});

const rowNumber = ref(0);
const selected = ref([]);

const opcionesRelacionDiametroLista = ref([
  { idRelacion: 0, nombreCompleto: "Cualquiera" },
]);
const opcionesRelacionDiametroDetalle = ref([]);

const opcionesMaterialLista = ref([
  { idTipoMaterial: 0, nombre: "Cualquiera" },
]);
const opcionesMaterialDetalle = ref([]);

const opcionesExcavacionLista = ref([
  { idExcavacion: 0, nombre: "Cualquiera" },
]);
const opcionesExcavacionDetalle = ref([]);

const filtroRelacionDiametro = ref({
  idRelacion: 0,
  nombre: "Cualquiera",
});

const filtroTipoMaterial = ref({
  idTipoMaterial: 0,
  nombre: "Cualquiera",
});

const filtroExcavacion = ref({
  idExcavacion: 0,
  nombre: "Cualquiera",
});

const registro = ref({
  idRelacion: 0,
  idRelacionDiametro: 0,
  idTipoMaterial: 0,
  idExcavacion: 0,
  precio: 0,
  lineaTrabajo: "",
});

const relacionDiametroModel = ref({ idRelacion: 0, nombreCompleto: "" });
const tipoMaterialModel = ref({ idTipoMaterial: 0, nombre: "" });
const excavacionModel = ref({ idExcavacion: 0, nombre: "" });

const Editar = ref(false);

//Permisos
const permNuevo = ref(true);
const permEliminar = ref(true);
const permGuardar = ref(true);

//Llamadas a servidor
function fetchFromServer(page, rowsPerPage, sortBy, descending) {
  const req = {
    idRelacion: 0,
    idRelacionDiametro: filtroRelacionDiametro.value.idRelacion,
    idTipoMaterial: filtroTipoMaterial.value.idTipoMaterial,
    idExcavacion: filtroExcavacion.value.idExcavacion,
    initRow: (page - 1) * rowsPerPage + 1,
    endRow: (page - 1) * rowsPerPage + rowsPerPage,
    sortColumn: sortBy,
    sortDir: descending ? "DESC" : "ASC",
  };

  return api
    .post("/relacionfinalprecio/RelacionFinalPrecioSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        rows.value = resp.relacionesFinalPrecio;
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
    idRelacion: 0,
    idRelacionDiametro: filtroRelacionDiametro.value.idRelacion,
    idTipoMaterial: filtroTipoMaterial.value.idTipoMaterial,
    idExcavacion: filtroExcavacion.value.idExcavacion,
  };

  return api
    .post("/relacionfinalprecio/RelacionFinalPrecioCount", req, {
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
  //refNombre.value.validate();
  //return !refNombre.value.hasError;
  return true;
}

//Eventos
onMounted(() => {
  const reql = {
    idLineaTrabajo: 0,
    nombre: "",
    idClaveTrabajo: 0,
    initRow: 1,
    endRow: 1000,
    sortColumn: "idLineaTrabajo",
    sortDir: "ASC",
  };

  api
    .post("/lineatrabajo/LineaTrabajoSelect", reql, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        opcionesRelacionDiametroLista.value.splice(1, 0, ...resp.lineasTrabajo);
        opcionesRelacionDiametroDetalle.value = resp.lineasTrabajo;
      } else {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    });

  const reqt = {
    idTipoObra: 0,
    idClaveTrabajo: 0,
    nombre: "",
    initRow: 1,
    endRow: 1000,
    sortColumn: "idTipoObra",
    sortDir: "ASC",
  };

  api
    .post("/tipoobra/TipoObraSelect", reqt, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        opcionesMaterialLista.value.splice(1, 0, ...resp.tiposObra);
        opcionesMaterialDetalle.value = resp.tiposObra;
      } else {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    });

  const reqtb = {
    idTuberia: 0,
    nombre: "",
    initRow: 1,
    endRow: 1000,
    sortColumn: "idTuberia",
    sortDir: "ASC",
  };

  api
    .post("/tuberia/TuberiaSelect", reqtb, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        opcionesExcavacionLista.value.splice(1, 0, ...resp.tuberias);
        opcionesExcavacionDetalle.value = resp.tuberias;
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
  //  "/Catalogos/RelacionFinalPrecio",
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

  relacionDiametroModel.value = opcionesRelacionDiametroDetalle.value.filter(
    (ob) => {
      return ob.idLineaTrabajo == obj.idLineaTrabajo;
    }
  )[0];

  excavacionModel.value = opcionesExcavacionDetalle.value.filter((ob) => {
    return ob.idTuberia == obj.idTuberia;
  })[0];

  tipoMaterialModel.value = opcionesMaterialDetalle.value.filter((ob) => {
    return ob.idTipoObra == obj.idTipoObra;
  })[0];

  Editar.value = true;
}

function onClickNuevo() {
  registro.value = {
    idRelacion: 0,
    idLineaTrabajo: 0,
    idTipoObra: 0,
    idTuberia: 0,
  };

  relacionDiametroModel.value = opcionesRelacionDiametroDetalle.value[0];
  tipoMaterialModel.value = opcionesMaterialDetalle.value[0];
  excavacionModel.value = opcionesExcavacionDetalle.value[0];

  Editar.value = true;
}

function onClickEliminar() {
  if (selected.value.length == 0) {
    mostrarMensaje(
      "Eliminar relaciones",
      "No se han seleccionado relaciones para eliminar",
      "adv"
    );
  } else {
    $q.dialog({
      title: "Eliminar relaciones",
      message: "¿Confirma que desea eliminar las relaciones seleccionadas?",
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
    idLineaTrabajo: selected.value[indice].idRelacion,
  };

  api
    .post("/relacionfinalprecio/RelacionFinalPrecioDelete", req, {
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
          "/Catalogos/RelacionFinalPrecio",
          "Eliminar relación",
          "Relación " +
            selected.value[indice].lineaTrabajo +
            " eliminada con éxito",
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
          "Eliminar relaciones",
          "Error al eliminar la relación " +
            selected.value[0].lineaTrabajo +
            ": " +
            resp.mensaje,
          "err"
        );
      }
    })
    .catch((error) => {
      onClickBuscar();
      mostrarMensaje(
        "Eliminar relaciones",
        "Error al eliminar la relación " +
          selected.value[0].lineaTrabajo +
          ": " +
          error,
        "err"
      );
    });
}

function onClickGuardar() {
  if (ValidarFormulario()) {
    if (registro.value.idLineaTrabajo == 0) {
      const req = {
        idLineaTrabajo: relacionDiametroModel.value.idLineaTrabajo,
        idTipoObra: tipoMaterialModel.value.idTipoObra,
        idTuberia: excavacionModel.value.idTuberia,
      };

      api
        .post("/relacionfinalprecio/RelacionFinalPrecioInsert", req, {
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
          },
        })
        .then((response) => {
          var resp = response.data;

          if (resp.resultado > 0) {
            registro.value.idRelacion = resp.resultado;

            guardarLogSistema(
              $q.localStorage.getItem("idusuario"),
              "/Catalogos/RelacionFinalPrecio",
              "Agregar Relación",
              "Relación " + registro.value.lineaTrabajo + " creada con éxito",
              "Información"
            );
            Editar.value = false;
            onClickBuscar();
          } else {
            mostrarMensaje(
              "Guardar Relación",
              "Ocurrió un error al agregar la relación: " + resp.mensaje,
              "err"
            );
          }
        })
        .catch((error) => {
          mostrarMensaje(
            "Guardar Relación",
            "Ocurrió un error al agregar la relación: " + error,
            "err"
          );
        });
    } else {
      const req = {
        idRelacion: registro.value.idRelacion,
        idLineaTrabajo: relacionDiametroModel.value.idLineaTrabajo,
        idTipoObra: tipoMaterialModel.value.idTipoObra,
        idTuberia: excavacionModel.value.idTuberia,
      };

      api
        .post("/relacionfinalprecio/RelacionFinalPrecioUpdate", req, {
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
          },
        })
        .then((response) => {
          var resp = response.data;

          if (resp.resultado > 0) {
            registro.value.idRelacion = resp.resultado;

            guardarLogSistema(
              $q.localStorage.getItem("idusuario"),
              "/Catalogos/RelacionFinalPrecio",
              "Modificar Relación",
              "Relación " +
                registro.value.lineaTrabajo +
                " modificado con éxito",
              "Información"
            );
            Editar.value = false;
            onClickBuscar();
          } else {
            mostrarMensaje(
              "Guardar Relación",
              "Ocurrió un error al modificar la relación: " + resp.mensaje,
              "err"
            );
          }
        })
        .catch((error) => {
          mostrarMensaje(
            "Guardar Relación",
            "Ocurrió un error al modificar la relación: " + error,
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
          <div class="text-h6">
            Relación Línea de Trabajo/Tipo de Obra/Tubería
          </div>
        </q-card-section>
        <q-separator />
        <q-card-section>
          <div class="row">
            <div class="q-pa-sm col-12 col-md-6">
              <q-select
                outlined
                v-model="filtroRelacionDiametro"
                :options="opcionesRelacionDiametroLista"
                label="Línea de Trabajo"
                option-label="nombre"
                option-value="idLineaTrabajo"
              />
            </div>
            <div class="q-pa-sm col-12 col-md-6">
              <q-select
                outlined
                v-model="filtroTipoMaterial"
                :options="opcionesMaterialLista"
                label="Tipo de Obra"
                option-label="nombre"
                option-value="idTipoObra"
              />
            </div>
          </div>
          <div class="row">
            <div class="q-pa-sm col-10 col-md-5">
              <q-select
                outlined
                v-model="filtroExcavacion"
                :options="opcionesExcavacionLista"
                label="Tubería"
                option-label="nombre"
                option-value="idTuberia"
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
            label="Agregar Relación"
            @click="onClickNuevo"
            v-if="permNuevo"
          >
          </q-btn>
          <q-btn
            icon="delete"
            color="red-10"
            label="Eliminar Relaciones(s)"
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
            no-data-label="No hay registros de relaciones"
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
          <div class="text-h6">Agregar/Editar Relación</div>
        </q-card-section>
        <q-separator />
        <q-card-section class="q-pa-none">
          <div class="row">
            <div class="col-12 col-md-12 q-pa-sm">
              <q-select
                outlined
                v-model="relacionDiametroModel"
                :options="opcionesRelacionDiametroDetalle"
                label="Línea de Trabajo"
                option-label="nombre"
                option-value="idLineaTrabajo"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-md-12 q-pa-sm">
              <q-select
                outlined
                v-model="tipoMaterialModel"
                :options="opcionesMaterialDetalle"
                label="Tipo de Obra"
                option-label="nombre"
                option-value="idTipoObra"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-md-12 q-pa-sm">
              <q-select
                outlined
                v-model="excavacionModel"
                :options="opcionesExcavacionDetalle"
                label="Tubería"
                option-label="nombre"
                option-value="idTuberia"
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
