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
    name: "lineaTrabajo",
    label: "Línea de Trabajo",
    align: "left",
    field: "lineaTrabajo",
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

const opcionesLineaObraTuberiaLista = ref([
  { idRelacion: 0, nombreCompleto: "Cualquiera" },
]);
const opcionesLineaObraTuberiaDetalle = ref([]);

const opcionesDiametroLista = ref([{ idDiametro: 0, nombre: "Cualquiera" }]);
const opcionesDiametroDetalle = ref([]);

const filtroLineaObraTuberia = ref({
  idRelacion: 0,
  nombreCompleto: "Cualquiera",
});

const filtroDiametro = ref({
  idDiametro: 0,
  nombre: "Cualquiera",
});

const registro = ref({
  idRelacion: 0,
  idRelacionObra: 0,
  idDiametro: 0,
  lineaTrabajo: "",
  tipoObra: "",
  tuberia: "",
});

const lineaObraTuberiaModel = ref({ idRelacion: 0, nombreCompleto: "" });
const diametroModel = ref({ idDiametro: 0, nombre: "" });

const Editar = ref(false);

//Permisos
const permNuevo = ref(true);
const permEliminar = ref(true);
const permGuardar = ref(true);

//Llamadas a servidor
function fetchFromServer(page, rowsPerPage, sortBy, descending) {
  const req = {
    idRelacion: 0,
    idRelacionObra: filtroLineaObraTuberia.value.idRelacion,
    idDiametro: filtroDiametro.value.idDiametro,
    initRow: (page - 1) * rowsPerPage + 1,
    endRow: (page - 1) * rowsPerPage + rowsPerPage,
    sortColumn: sortBy,
    sortDir: descending ? "DESC" : "ASC",
  };

  return api
    .post("/relacionobradiametro/RelacionObraDiametroSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        rows.value = resp.relacionesObraDiametro;
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
    idRelacionObra: filtroLineaObraTuberia.value.idRelacion,
    idDiametro: filtroDiametro.value.idDiametro,
  };

  return api
    .post("/relacionobradiametro/RelacionObraDiametroCount", req, {
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
    idRelacion: 0,
    idLineaTrabajo: 0,
    idTipoObra: 0,
    idTuberia: 0,
    initRow: 1,
    endRow: 1000,
    sortColumn: "idRelacion",
    sortDir: "ASC",
  };

  api
    .post("/relacionlineaobratuberia/RelacionLineaObraTuberiaSelect", reql, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        opcionesLineaObraTuberiaLista.value.splice(
          1,
          0,
          ...resp.relacionesLineaObraTuberia
        );
        opcionesLineaObraTuberiaDetalle.value = resp.relacionesLineaObraTuberia;
      } else {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    });

  const reqt = {
    idDiametro: 0,
    nombre: "",
    initRow: 1,
    endRow: 1000,
    sortColumn: "idDiametro",
    sortDir: "ASC",
  };

  api
    .post("/diametro/DiametroSelect", reqt, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        opcionesDiametroLista.value.splice(1, 0, ...resp.diametros);
        opcionesDiametroDetalle.value = resp.diametros;
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
  //  "/Catalogos/RelacionObraDiametro",
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

  lineaObraTuberiaModel.value = opcionesLineaObraTuberiaDetalle.value.filter(
    (ob) => {
      return ob.idRelacion == obj.idRelacionObra;
    }
  )[0];

  diametroModel.value = opcionesDiametroDetalle.value.filter((ob) => {
    return ob.idDiametro == obj.idDiametro;
  })[0];

  Editar.value = true;
}

function onClickNuevo() {
  registro.value = {
    idRelacion: 0,
    idRelacionObra: 0,
    idDiametro: 0,
  };

  lineaObraTuberiaModel.value = opcionesLineaObraTuberiaDetalle.value[0];
  diametroModel.value = opcionesDiametroDetalle.value[0];

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
    idRelacion: selected.value[indice].idRelacion,
  };

  api
    .post("/relacionobradiametro/RelacionObraDiametroDelete", req, {
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
          "/Catalogos/RelacionObraDiametro",
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
    if (registro.value.idRelacion == 0) {
      const req = {
        idRelacionObra: lineaObraTuberiaModel.value.idRelacion,
        idDiametro: diametroModel.value.idDiametro,
      };

      api
        .post("/relacionobradiametro/RelacionObraDiametroInsert", req, {
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
              "/Catalogos/RelacionObraDiametro",
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
        idRelacionObra: lineaObraTuberiaModel.value.idRelacion,
        idDiametro: diametroModel.value.idDiametro,
      };

      api
        .post("/relacionobradiametro/RelacionObraDiametroUpdate", req, {
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
              "/Catalogos/RelacionObraDiametro",
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
          <div class="text-h6">Relación Obra/Tubería/Diámetro</div>
        </q-card-section>
        <q-separator />
        <q-card-section>
          <div class="row">
            <div class="q-pa-sm col-12 col-md-6">
              <q-select
                outlined
                v-model="filtroLineaObraTuberia"
                :options="opcionesLineaObraTuberiaLista"
                label="Línea/Obra/Tubería"
                option-label="nombreCompleto"
                option-value="idRelacion"
              />
            </div>
            <div class="q-pa-sm col-11 col-md-5">
              <q-select
                outlined
                v-model="filtroDiametro"
                :options="opcionesDiametroLista"
                label="Diámetro"
                option-label="nombre"
                option-value="idDiametro"
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
            row-key="idRelacion"
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
                v-model="lineaObraTuberiaModel"
                :options="opcionesLineaObraTuberiaDetalle"
                label="Línea/Obra/Tubería"
                option-label="nombreCompleto"
                option-value="idRelacion"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-md-12 q-pa-sm">
              <q-select
                outlined
                v-model="diametroModel"
                :options="opcionesDiametroDetalle"
                label="Diámetro"
                option-label="nombre"
                option-value="idDiametro"
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
