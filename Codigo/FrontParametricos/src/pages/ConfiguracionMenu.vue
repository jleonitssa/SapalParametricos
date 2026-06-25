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

//Variables
const expanded = ref(["Sistema"]);
const selected = ref(0);
const simple = ref([]);

const opcionesMenuDetalle = ref([]);
const opcionesPantallaDetalle = ref([{ idPantalla: 0, nombre: "Ninguna" }]);

const Editar = ref(false);

const registro = ref({
  id: 0,
  label: "",
  idPantalla: 0,
  target: "_self",
  idMenuPadre: 0,
  orden: 0,
});

const refNombre = ref(null);

const menuModel = ref({ id: 0, label: "" });
const pantallaModel = ref({ idPantalla: 0, nombre: "" });

//Permisos
const permNuevo = ref(false);
const permEliminar = ref(false);
const permGuardar = ref(false);
const permEditar = ref(false);
const permMover = ref(false);

//Eventos
onMounted(() => {
  const req = {
    idPantalla: 0,
    nombre: "",
    descripcion: "",
    url: "",
    initRow: 1,
    endRow: 200,
    sortColumn: "nombre",
    sortDir: "ASC",
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
        opcionesPantallaDetalle.value.splice(1, 0, ...resp.pantallas);
      } else {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    });

  const req2 = {
    idMenu: 0,
    tipo: 2,
  };

  api
    .post("/menu/MenuSelect", req2, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        opcionesMenuDetalle.value.splice(1, 0, ...resp.menus);
      } else {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    });

  CargarArbol();

  revisarPermisos(
    $q.localStorage.getItem("idgrupo"),
    "/Configuracion/Menu",
    permEliminar,
    "Eliminar",
    permGuardar,
    "Guardar",
    permNuevo,
    "Nuevo",
    permEditar,
    "Editar",
    permMover,
    "Mover"
  );
});

//Funciones
function CargarArbol() {
  const req = {
    idMenu: 0,
    tipo: 1,
  };

  api
    .post("/menu/MenuSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        simple.value = resp.menus;
        //console.log(simple.value);
      } else {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    });
}

function ValidarFormulario() {
  refNombre.value.validate();
  return !refNombre.value.hasError;
}

function onClickGuardar() {
  if (ValidarFormulario()) {
    if (registro.value.id == 0) {
      const req = {
        nombre: registro.value.label,
        idPantalla: pantallaModel.value.idPantalla,
        idMenuPadre: menuModel.value.id,
      };

      console.log(req);

      api
        .post("/menu/MenuInsert", req, {
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
          },
        })
        .then((response) => {
          var resp = response.data;

          if (resp.resultado > 0) {
            registro.value.id = resp.resultado;

            guardarLogSistema(
              $q.localStorage.getItem("idusuario"),
              "/Configuracion/Menu",
              "Agregar menú",
              "Menú " + registro.value.label + " creado con éxito",
              "Información"
            );
            Editar.value = false;
            CargarArbol();
          } else {
            mostrarMensaje(
              "Guardar menú",
              "Ocurrió un error al agregar el menú: " + resp.mensaje,
              "err"
            );
          }
        })
        .catch((error) => {
          mostrarMensaje(
            "Guardar menú",
            "Ocurrió un error al agregar el menú: " + error,
            "err"
          );
        });
    } else {
      const req = {
        idMenu: registro.value.id,
        nombre: registro.value.label,
        idPantalla: pantallaModel.value.idPantalla,
        idMenuPadre: menuModel.value.id,
      };

      api
        .post("/menu/MenuUpdate", req, {
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
          },
        })
        .then((response) => {
          var resp = response.data;

          if (resp.resultado > 0) {
            registro.value.id = resp.resultado;

            guardarLogSistema(
              $q.localStorage.getItem("idusuario"),
              "/Configuracion/Menu",
              "Modificar menú",
              "Menú " + registro.value.label + " modificado con éxito",
              "Información"
            );
            Editar.value = false;
            CargarArbol();
          } else {
            mostrarMensaje(
              "Guardar menú",
              "Ocurrió un error al modificar el menú: " + resp.mensaje,
              "err"
            );
          }
        })
        .catch((error) => {
          mostrarMensaje(
            "Guardar menú",
            "Ocurrió un error al modificar el menú: " + error,
            "err"
          );
        });
    }
  }
}

function onClickNuevo() {
  registro.value = {
    id: 0,
    label: "",
    idPantalla: opcionesPantallaDetalle.value[0].idPantalla,
    target: "_self",
    idMenuPadre: selected.value,
    orden: 1,
  };

  pantallaModel.value = opcionesPantallaDetalle.value.filter((ob) => {
    return ob.idPantalla == registro.value.idPantalla;
  })[0];

  menuModel.value = opcionesMenuDetalle.value.filter((ob) => {
    return ob.id == registro.value.idMenuPadre;
  })[0];

  Editar.value = true;
}

function onClickEliminar() {
  $q.dialog({
    title: "Eliminar menú",
    message: "¿Confirma que desea eliminar el menú seleccionado?",
    ok: "Aceptar",
    cancel: "Cancelar",
    persistent: true,
  })
    .onOk(() => {
      const req = {
        idMenu: selected.value,
      };

      api
        .post("/menu/MenuDelete", req, {
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
              "/Configuracion/Menu",
              "Eliminar menú",
              "Menú eliminado con éxito",
              "Información"
            );

            CargarArbol();
          } else {
            mostrarMensaje(
              "Eliminar menú",
              "Error al eliminar el menú: " + resp.mensaje,
              "err"
            );
          }
        })
        .catch((error) => {
          mostrarMensaje(
            "Eliminar menú",
            "Error al eliminar el menú: " + error,
            "err"
          );
        });
    })
    .onCancel(() => {});
}

function editarRegistro() {
  var obj = opcionesMenuDetalle.value.filter((mnu) => {
    return mnu.id == selected.value;
  });

  registro.value = Object.assign({}, obj[0]);

  pantallaModel.value = opcionesPantallaDetalle.value.filter((ob) => {
    return (
      ob.idPantalla ==
      (registro.value.idPantalla == null ? 0 : registro.value.idPantalla)
    );
  })[0];

  menuModel.value = opcionesMenuDetalle.value.filter((ob) => {
    return ob.id == registro.value.idMenuPadre;
  })[0];

  Editar.value = true;
}

function MoverArriba() {
  MoverMenu(2);
}

function MoverAbajo() {
  MoverMenu(1);
}

function MoverMenu(direccion) {
  const req = {
    idMenu: selected.value,
    direccion: direccion,
  };

  api
    .post("/menu/MenuMover", req, {
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
          "/Configuracion/Menu",
          "Mover menú",
          "Menú movido con éxito",
          "Información"
        );

        CargarArbol();
      } else {
        mostrarMensaje(
          "Mover menú",
          "Error al mover el menú: " + resp.mensaje,
          "err"
        );
      }
    })
    .catch((error) => {
      mostrarMensaje(
        "Eliminar menú",
        "Error al mover el menú: " + error,
        "err"
      );
    });
}
</script>

<template>
  <q-page class="bg-grey-3 qpage">
    <q-card class="q-pa-md q-gutter-sm" bordered
      ><q-card-section>
        <div class="text-h6">Menús del sistema</div>
      </q-card-section>
      <q-separator />
      <q-card-section>
        <div class="row">
          <q-tree
            :nodes="simple"
            dense
            node-key="id"
            v-model:expanded="expanded"
            v-model:selected="selected"
          />
        </div>
      </q-card-section>
      <q-separator />
      <q-card-actions>
        <q-btn
          icon="add"
          color="green-10"
          label="Agregar Menú"
          @click="onClickNuevo"
          v-if="permNuevo && selected > 0"
        >
        </q-btn>
        <q-btn
          icon="edit"
          color="primary"
          label="Editar Menú"
          @click="editarRegistro"
          v-if="permEditar && selected > 1"
        >
        </q-btn>
        <q-btn
          icon="arrow_upward"
          color="secondary"
          label="Subir Menú"
          @click="MoverArriba"
          v-if="permMover && selected > 1"
        >
        </q-btn>
        <q-btn
          icon="arrow_downward"
          color="secondary"
          label="Bajar Menú"
          @click="MoverAbajo"
          v-if="permMover && selected > 1"
        >
        </q-btn>
        <q-btn
          icon="delete"
          color="red-10"
          label="Eliminar Menú"
          @click="onClickEliminar"
          v-if="permEliminar && selected > 1"
        >
        </q-btn>
      </q-card-actions>
    </q-card>
  </q-page>
  <q-dialog v-model="Editar" persistent>
    <q-card style="width: 75%">
      <q-card-section class="bg-grey-4">
        <div class="text-h6">Agregar/Editar menú</div>
      </q-card-section>
      <q-separator />
      <q-card-section class="q-pa-none">
        <div class="row">
          <div class="col-12 col-md-12 q-pa-sm">
            <q-input
              outlined
              label="Nombre"
              v-model="registro.label"
              ref="refNombre"
              :rules="[(val) => !!val || 'El nombre es requerido']"
            />
          </div>
        </div>
        <div class="row">
          <div class="col-12 col-md-12 q-pa-sm">
            <q-select
              outlined
              v-model="menuModel"
              :options="opcionesMenuDetalle"
              label="Menu Padre"
              option-label="label"
              option-value="id"
            />
          </div>
        </div>
        <div class="row">
          <div class="col-12 col-md-12 q-pa-sm">
            <q-select
              outlined
              v-model="pantallaModel"
              :options="opcionesPantallaDetalle"
              label="Pantalla"
              option-label="nombre"
              option-value="idPantalla"
            />
          </div>
          <div class="col-12 col-md-6 q-pa-sm"></div>
        </div>
      </q-card-section>

      <q-separator />
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
</template>

<style lang="css" scoped></style>
