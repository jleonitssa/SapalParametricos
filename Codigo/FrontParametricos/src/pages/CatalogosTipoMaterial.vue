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
const urlImagenes = ref($q.localStorage.getItem("urlImagenes"));

//Columnas
const columns = [
  {
    name: "nombre",
    label: "Nombre",
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
  idTipoMaterial: 0,
  nombre: "",
  descripcion1: "",
  descripcion2: "",
  descripcion3: "",
  imagen: "",
});

const data = ref([]);
const uploader = ref();
const mostrarSubida = ref(false);
const mostrarCargandoSubida = ref(false);

const Editar = ref(false);
const refNombre = ref(null);

//Permisos
const permNuevo = ref(true);
const permEliminar = ref(true);
const permGuardar = ref(true);

//Llamadas a servidor
function fetchFromServer(page, rowsPerPage, sortBy, descending) {
  const req = {
    idTipoMaterial: 0,
    nombre: filtroNombre.value,
    initRow: (page - 1) * rowsPerPage + 1,
    endRow: (page - 1) * rowsPerPage + rowsPerPage,
    sortColumn: sortBy,
    sortDir: descending ? "DESC" : "ASC",
  };

  return api
    .post("/tipomaterial/TipoMaterialSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        rows.value = resp.tiposMaterial;
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
    idTipoMaterial: 0,
    nombre: filtroNombre.value,
  };

  return api
    .post("/tipomaterial/TipoMaterialCount", req, {
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

function uploadFiles() {
  mostrarSubida.value = false;
  mostrarCargandoSubida.value = true;

  if (data.value.length > 0) subirArchivo();
}

function subirArchivo() {
  let config = {
    headers: {
      "Content-Type": "multipart/form-data",
    },
  };

  let fd = new FormData();
  fd.append("file", data.value[0]);
  api
    .post("/files/UploadFile", fd, config)
    .then((response) => {
      if (response.status == 200) {
        var img = response.data;

        const req = {
          idTipoMaterial: registro.value.idTipoMaterial,
          imagen: img,
        };
        api
          .post("/tipomaterial/TipoMaterialUpdateImagen", req, {
            headers: {
              "Content-Type": "application/json",
              "Access-Control-Allow-Origin": "*",
            },
          })
          .then((response) => {
            var resp = response.data;

            if (resp.codigo == 1) {
              data.value.splice(0, 1);

              registro.value.imagen = img;
              onClickBuscar();
              mostrarCargandoSubida.value = false;
            } else {
              mostrarMensaje(
                "Cambiar imagen",
                "Ocurrió un error al cargar imagen: " + resp.mensaje,
                "err"
              );
            }
          })
          .catch((error) => {
            mostrarMensaje(
              "Cambiar imagen",
              "Ocurrió un error al cambiar imagen: " + error,
              "err"
            );
          });
      } else {
        mostrarMensaje(
          "Cambiar imagen",
          "Ocurrió un error al cambiar imagen: " + response.statusText,
          "err"
        );
      }
    })
    .catch((error) => {
      mostrarMensaje(
        "Cambiar imagen",
        "Ocurrió un error al cambiar imagen: " + error,
        "err"
      );
    });
}

function file_selected(files) {
  files.forEach((element) => {
    data.value.push(element);
  });
}

function file_removed(files) {
  files.forEach((element) => {
    removerArchivo(element.name);
  });

  console.log(data.value);
}

function removerArchivo(archivo) {
  var index = data.value.findIndex((item) => item.name === archivo);
  data.value.splice(index, 1);
}

function file_rejected(files) {
  mostrarMensaje(
    "cambiar imagen",
    "Sólo se permite la subida de archivo de imagen y video de máximo 4mb",
    "err"
  );
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
  //  "/Catalogos/TipoMaterial",
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
    idTipoMaterial: 0,
    nombre: "",
    descripcion1: "",
    descripcion2: "",
    descripcion3: "",
    imagen: "SinImagen.jpg",
  };

  Editar.value = true;
}

function onClickEliminar() {
  if (selected.value.length == 0) {
    mostrarMensaje(
      "Eliminar tipos de material",
      "No se han seleccionado tipos de material para eliminar",
      "adv"
    );
  } else {
    $q.dialog({
      title: "Eliminar tipos de material",
      message:
        "¿Confirma que desea eliminar los tipos de material seleccionados?",
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
    idTipoMaterial: selected.value[indice].idTipoMaterial,
  };

  api
    .post("/tipomaterial/TipoMaterialDelete", req, {
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
          "/Catalogos/TipoMaterial",
          "Eliminar tipo de material",
          "nombre " + selected.value[indice].nombre + " eliminado con éxito",
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
          "Eliminar tipos de material",
          "Error al eliminar el tipo de material " +
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
        "Eliminar tipos de material",
        "Error al eliminar el tipo de material " +
          selected.value[0].nombre +
          ": " +
          error,
        "err"
      );
    });
}

function onClickGuardar() {
  if (ValidarFormulario()) {
    if (registro.value.idTipoMaterial == 0) {
      const req = {
        nombre: registro.value.nombre,
        descripcion1: registro.value.descripcion1 ?? "",
        descripcion2: registro.value.descripcion2 ?? "",
        descripcion3: registro.value.descripcion3 ?? "",
      };

      api
        .post("/tipomaterial/TipoMaterialInsert", req, {
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
          },
        })
        .then((response) => {
          var resp = response.data;

          if (resp.resultado > 0) {
            registro.value.idTipoMaterial = resp.resultado;

            guardarLogSistema(
              $q.localStorage.getItem("idusuario"),
              "/Catalogos/TipoMaterial",
              "Agregar tipo de material",
              "tipo de material " + registro.value.nombre + " creado con éxito",
              "Información"
            );
            Editar.value = false;
            onClickBuscar();
          } else {
            mostrarMensaje(
              "Guardar nombre",
              "Ocurrió un error al agregar el tipo de material: " +
                resp.mensaje,
              "err"
            );
          }
        })
        .catch((error) => {
          mostrarMensaje(
            "Guardar nombre",
            "Ocurrió un error al agregar el tipo de material: " + error,
            "err"
          );
        });
    } else {
      const req = {
        idTipoMaterial: registro.value.idTipoMaterial,
        nombre: registro.value.nombre,
        descripcion1: registro.value.descripcion1 ?? "",
        descripcion2: registro.value.descripcion2 ?? "",
        descripcion3: registro.value.descripcion3 ?? "",
      };

      console.log(req);

      api
        .post("/tipomaterial/TipoMaterialUpdate", req, {
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
          },
        })
        .then((response) => {
          var resp = response.data;

          if (resp.resultado > 0) {
            registro.value.idTipoMaterial = resp.resultado;

            guardarLogSistema(
              $q.localStorage.getItem("idusuario"),
              "/Catalogos/TipoMaterial",
              "Modificar tipo de material",
              "nombre " + registro.value.nombre + " modificado con éxito",
              "Información"
            );
            Editar.value = false;
            onClickBuscar();
          } else {
            mostrarMensaje(
              "Guardar tipo de material",
              "Ocurrió un error al modificar el tipo de material: " +
                resp.mensaje,
              "err"
            );
          }
        })
        .catch((error) => {
          mostrarMensaje(
            "Guardar tipo de material",
            "Ocurrió un error al modificar el tipo de material: " + error,
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
          <div class="text-h6">Tipos de material</div>
        </q-card-section>
        <q-separator />
        <q-card-section>
          <div class="row">
            <div class="q-pa-sm col-10 col-md-5">
              <q-input
                color="primary"
                v-model="filtroNombre"
                outlined
                label="Tipo de material"
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
            label="Agregar tipo de material"
            @click="onClickNuevo"
            v-if="permNuevo"
          >
          </q-btn>
          <q-btn
            icon="delete"
            color="red-10"
            label="Eliminar tipo(s) de material"
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
            row-key="idTipoMaterial"
            v-model:pagination="pagination"
            :loading="loading"
            binary-state-sort
            @request="onRequest"
            selection="multiple"
            v-model:selected="selected"
            no-data-label="No hay registros de tipos de material"
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
      <q-card style="width: 80%">
        <q-card-section class="bg-grey-4">
          <div class="text-h6">Agregar/Editar tipo de material</div>
        </q-card-section>
        <q-separator />
        <q-card-section class="q-pa-none">
          <div class="row">
            <div class="col-12 col-md-12 q-pa-sm">
              <q-input
                outlined
                label="nombre"
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
                label="Descripción 1"
                v-model="registro.descripcion1"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-md-12 q-pa-sm">
              <q-input
                outlined
                label="Descripción 2"
                v-model="registro.descripcion2"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-md-12 q-pa-sm">
              <q-input
                outlined
                label="Descripción 3"
                v-model="registro.descripcion3"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-md-12 q-pa-sm">
              <q-img
                :src="urlImagenes + '/imagenes/' + registro.imagen"
                fit="contain"
                style="max-height: 400px"
              />
            </div>
          </div>
        </q-card-section>

        <q-card-actions align="right" class="text-primary">
          <q-btn
            v-if="registro.idTipoMaterial > 0"
            icon="add_a_photo"
            color="grey-9"
            label="Cambiar Imagen"
            @click="mostrarSubida = true"
          ></q-btn>
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

  <q-dialog v-model="mostrarSubida">
    <q-card style="width: 50%; max-width: 95%">
      <q-card-section class="bg-grey-4"
        ><div class="row">
          <div class="text-h6">Modificar imagen</div>
          <q-space />
          <q-btn icon="close" flat round dense v-close-popup />
        </div>
      </q-card-section>
      <q-separator />
      <q-card-section class="q-pa-none">
        <div class="row">
          <div class="col-12 col-md-12">
            <q-uploader
              label="Cargar imagen"
              color="primary"
              style="width: 100%"
              accept=".jpg, .png, .gif, .jpeg"
              max-file-size="4194304"
              bordered
              :hide-upload-btn="true"
              :no-thumbnails="true"
              @added="file_selected"
              @rejected="file_rejected"
              @removed="file_removed"
              ref="uploader"
            />
          </div>
        </div>
      </q-card-section>
      <q-separator />
      <q-card-actions align="right" class="text-primary">
        <q-btn
          label="Cancelar"
          color="red-10"
          icon="arrow_back"
          @click="mostrarSubida = false"
        />
        <q-btn
          label="Guardar"
          color="primary"
          @click="uploadFiles()"
          icon="check"
        />
      </q-card-actions>
    </q-card>
  </q-dialog>

  <q-dialog v-model="mostrarCargandoSubida">
    <q-card style="width: 350px; max-width: 350px">
      <q-card-section class="bg-grey-4"
        ><div class="row">
          <div class="text-h6">Cargando Imagen...</div>
          <q-space />
        </div>
      </q-card-section>
      <q-separator />
      <q-card-section class="q-pa-none" style="text-align: center">
        <div class="row" style="text-align: center">
          <div class="col-12 col-md-12" style="text-align: center">
            <img src="../assets/loading.gif" />
          </div>
        </div>
      </q-card-section>
    </q-card>
  </q-dialog>
</template>

<style lang="css" scoped></style>
