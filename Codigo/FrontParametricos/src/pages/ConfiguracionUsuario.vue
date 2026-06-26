<script lang="ts" setup>
//Imports
import { ref, onMounted } from "vue";
import { api } from "boot/axios";
import { useQuasar } from "quasar";
import { mostrarMensaje, guardarLogSistema } from "../functions/funciones";

const $q = useQuasar();

//Columnas
const columns = [
  {
    name: "login",
    label: "No. Empleado/Usuario",
    align: "left",
    field: "login",
    sortable: true,
  },
  {
    name: "nombre",
    label: "Nombre",
    align: "left",
    field: "nombreCompleto",
    sortable: true,
  },
  {
    name: "email",
    label: "Correo Electrónico",
    align: "left",
    field: "email",
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
    name: "estatus",
    label: "Estatus",
    align: "left",
    field: "estatus",
    sortable: true,
  },
];

//Variables
const tableRef = ref();
const rows = ref([]);
const loading = ref(false);

const pagination = ref({
  sortBy: "login",
  descending: false,
  page: 1,
  rowsPerPage: 100,
  rowsNumber: 0,
});

const rowNumber = ref(0);
const selected = ref([]);

const opcionesGrupoLista = ref([{ idGrupo: 0, nombre: "Cualquiera" }]);
const opcionesGrupoDetalle = ref([]);

const opcionesEstatusDetalle = ref([
  { idEstatus: 1, nombre: "Activo" },
  { idEstatus: 2, nombre: "Inactivo" },
  { idEstatus: 3, nombre: "Bloqueado" },
]);

const filtroNombre = ref("");
const filtroLogin = ref("");
const filtroGrupo = ref({ idGrupo: 0, nombre: "Cualquiera" });

const registro = ref({
  idUsuario: 0,
  login: "",
  idGrupo: 0,
  email: "",
  nombre: "",
  apellidos: "",
  idEstatus: 0,
});

const registroCont = ref({
  idUsuario: 0,
  login: "",
  password: "",
  passwordConf: "",
});

const grupoModel = ref({ idGrupo: 0, nombre: "" });
const estatusModel = ref({ idEstatus: 0, nombre: "" });

const Editar = ref(false);
const EditarContra = ref(false);

const refLogin = ref(null);
const refNombre = ref(null);
const refApellidos = ref(null);

const refPassword = ref(null);
const refPasswordConf = ref(null);

//Permisos

//Llamadas a servidor
function fetchFromServer(page, rowsPerPage, sortBy, descending) {
  const req = {
    idUsuario: 0,
    login: filtroLogin.value ?? "",
    loginExacto: "",
    email: "",
    nombre: filtroNombre.value ?? "",
    idEstatus: 0,
    idGrupo: filtroGrupo.value.idGrupo,
    initRow: (page - 1) * rowsPerPage + 1,
    endRow: (page - 1) * rowsPerPage + rowsPerPage,
    sortColumn: sortBy,
    sortDir: descending ? "DESC" : "ASC",
  };

  return api
    .post("/usuario/UsuarioSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        rows.value = resp.usuarios;
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
    idUsuario: 0,
    login: filtroLogin.value ?? "",
    loginExacto: "",
    email: "",
    nombre: filtroNombre.value ?? "",
    idEstatus: 0,
    idGrupo: filtroGrupo.value.idGrupo,
  };

  return api
    .post("/usuario/UsuarioCount", req, {
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

function validarFormulario() {
  refApellidos.value.validate();
  refLogin.value.validate();
  refNombre.value.validate();
  return !(
    refApellidos.value.hasError ||
    refLogin.value.hasError ||
    refNombre.value.hasError
  );
}

function validarFormularioContra() {
  refPassword.value.validate();
  refPasswordConf.value.validate();
  return !(refPassword.value.hasError || refPasswordConf.value.hasError);
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
        opcionesGrupoDetalle.value = resp.grupos;
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
  selected.value = [];

  onRequest({ pagination: pagination.value });
}

function seleccionarRegistro(e, obj, index) {
  registro.value = Object.assign({}, obj);

  grupoModel.value = opcionesGrupoDetalle.value.filter((ob) => {
    return ob.idGrupo == obj.idGrupo;
  })[0];

  estatusModel.value = opcionesEstatusDetalle.value.filter((ob) => {
    return ob.idEstatus == obj.idEstatus;
  })[0];

  Editar.value = true;
}

function onClickNuevo() {
  registro.value = {
    idUsuario: 0,
    login: "",
    idGrupo: opcionesGrupoDetalle.value[0].idGrupo,
    email: "",
    nombre: "",
    apellidos: "",
    idEstatus: 1,
  };

  grupoModel.value = opcionesGrupoDetalle.value.filter((ob) => {
    return ob.idGrupo == registro.value.idGrupo;
  })[0];

  estatusModel.value = opcionesEstatusDetalle.value[0];

  Editar.value = true;
}

function onClickEliminar() {
  if (selected.value.length == 0) {
    mostrarMensaje(
      "Eliminar usuarios",
      "No se ha seleccionado usuarios para eliminar",
      "adv"
    );
  } else {
    $q.dialog({
      title: "Eliminar Usuarios",
      message: "¿Confirma que desea eliminar los usuarios seleccionados?",
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
    idUsuario: selected.value[indice].idUsuario,
  };

  api
    .post("/usuario/UsuarioDelete", req, {
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
          "/Configuracion/Usuarios",
          "Eliminar Usuario",
          "Usuario " + selected.value[indice].login + " eliminado con éxito",
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
          "Eliminar Usuarios",
          "Error al eliminar el usuario " +
            selected.value[0].login +
            ": " +
            resp.mensaje,
          "err"
        );
      }
    })
    .catch((error) => {
      onClickBuscar();
      mostrarMensaje(
        "Eliminar Usuarios",
        "Error al eliminar el usuario " +
          selected.value[0].login +
          ": " +
          error,
        "err"
      );
    });
}

function onClickContrasena() {
  //console.log(selected.value);
  if (selected.value.length == 0) {
    mostrarMensaje(
      "Cambiar contraseña",
      "No se ha seleccionado usuarios para cambio de contraseña",
      "adv"
    );
  } else {
    if (selected.value[0].login.substring(0, 1).toLowerCase() == "s")
      mostrarMensaje(
        "Cambiar contraseña",
        "No se puede cambiar la contraseña de un usuario de sindicato",
        "adv"
      );
    else {
      registroCont.value.idUsuario = selected.value[0].idUsuario;
      registroCont.value.login = selected.value[0].login;
      registroCont.value.password = "";
      registroCont.value.passwordConf = "";

      EditarContra.value = true;
    }
  }
}

function onClickGuardarContra() {
  if (validarFormularioContra()) {
    $q.dialog({
      title: "Guardar",
      message: "¿Confirma que desea cambiar la contraseña?",
      ok: "Aceptar",
      cancel: "Cancelar",
      persistent: true,
    })
      .onOk(() => {
        const req = {
          idUsuario: registroCont.value.idUsuario,
          pass: registroCont.value.password,
        };

        api
          .post("/usuario/UsuarioCambiarContrasena", req, {
            headers: {
              "Content-Type": "application/json",
              "Access-Control-Allow-Origin": "*",
            },
          })
          .then((response) => {
            var resp = response.data;

            if (resp.resultado > 0) {
              registro.value.idUsuario = resp.resultado;

              guardarLogSistema(
                $q.localStorage.getItem("idusuario"),
                "/Configuracion/Usuarios",
                "Cambiar contraseña",
                "Contraseña de usuario " +
                  registro.value.login +
                  " cambiada con éxito",
                "Información"
              );

              EditarContra.value = false;

              onClickBuscar();
            } else {
              mostrarMensaje(
                "Cambiar contraseña",
                "Ocurrió un error al cambiar la contraseña: " + resp.mensaje,
                "err"
              );
            }
          })
          .catch((error) => {
            mostrarMensaje(
              "Cambiar contraseña",
              "Ocurrió un error al cambiar la contraseña: " + error,
              "err"
            );
          });
      })
      .onCancel(() => {});
  }
}

function onClickGuardar() {
  if (validarFormulario()) {
    $q.dialog({
      title: "Guardar",
      message: "¿Confirma que desea guardar los cambios?",
      ok: "Aceptar",
      cancel: "Cancelar",
      persistent: true,
    })
      .onOk(() => {
        if (registro.value.idUsuario == 0) {
          const req = {
            login: registro.value.login,
            idGrupo: grupoModel.value.idGrupo,
            email: registro.value.email,
            nombre: registro.value.nombre,
            apellidos: registro.value.apellidos,
          };

          api
            .post("/usuario/UsuarioInsert", req, {
              headers: {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*",
              },
            })
            .then((response) => {
              var resp = response.data;

              if (resp.resultado > 0) {
                registro.value.idUsuario = resp.resultado;

                guardarLogSistema(
                  $q.localStorage.getItem("idusuario"),
                  "/Configuracion/Usuarios",
                  "Agregar Usuario",
                  "Usuario " + registro.value.login + " creado con éxito",
                  "Información"
                );

                if (resp.codigo == 2 || resp.codigo == 3) {
                  mostrarMensaje(
                    "Guardar Usuario",
                    "Usuario agregado con éxito, pero ocurrió un error al enviar el " +
                      (resp.codigo == 2 ? "correo" : "mensaje de telegram") +
                      " de bienvenida",
                    "adv"
                  );
                  guardarLogSistema(
                    $q.localStorage.getItem("idusuario"),
                    "/Configuracion/Usuarios",
                    "Enviar correo usuario",
                    "Usuario " +
                      registro.value.login +
                      " -> error: " +
                      resp.codigo.toString() +
                      " | " +
                      resp.mensaje,
                    "Error"
                  );
                } else {
                  mostrarMensaje(
                    "Guardar Usuario",
                    "Usuario agregado con éxito",
                    "ok"
                  );
                }

                Editar.value = false;

                onClickBuscar();
              } else {
                mostrarMensaje(
                  "Guardar Usuario",
                  "Ocurrió un error al agregar el usuario: " + resp.mensaje,
                  "err"
                );
              }
            })
            .catch((error) => {
              mostrarMensaje(
                "Guardar Usuario",
                "Ocurrió un error al agregar el usuario: " + error,
                "err"
              );
            });
        } else {
          const req = {
            idUsuario: registro.value.idUsuario,
            login: registro.value.login,
            idGrupo: grupoModel.value.idGrupo,
            email: registro.value.email,
            nombre: registro.value.nombre,
            apellidos: registro.value.apellidos,
            idEstatus: estatusModel.value.idEstatus,
          };

          api
            .post("/usuario/UsuarioUpdate", req, {
              headers: {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*",
              },
            })
            .then((response) => {
              var resp = response.data;

              if (resp.resultado > 0) {
                registro.value.idUsuario = resp.resultado;

                guardarLogSistema(
                  $q.localStorage.getItem("idusuario"),
                  "/Configuracion/Usuarios",
                  "Modificar Usuario",
                  "Usuario " + registro.value.login + " modificado con éxito",
                  "Información"
                );

                Editar.value = false;

                onClickBuscar();
              } else {
                mostrarMensaje(
                  "Guardar Usuario",
                  "Ocurrió un error al modificar el usuario: " + resp.mensaje,
                  "err"
                );
              }
            })
            .catch((error) => {
              mostrarMensaje(
                "Guardar Usuario",
                "Ocurrió un error al modificar el usuario: " + error,
                "err"
              );
            });
        }
      })
      .onCancel(() => {});
  }
}

function isValidEmail(email) {
  const regex = /^[A-Za-z0-9+_.-]+@(.+)$/;
  return regex.test(email);
}

function onEmpleadoChanged() {
  registro.value.login = empleadoModel.value.noEmpleado;
  registro.value.nombre = empleadoModel.value.nombre;
  registro.value.apellidos = empleadoModel.value.apellidos;
  registro.value.email = empleadoModel.value.email;
}
</script>

<template>
  <div>
    <q-page class="bg-grey-3 qpage">
      <q-card class="q-pa-md q-gutter-sm" bordered
        ><q-card-section>
          <div class="text-h6">Usuarios</div>
        </q-card-section>
        <q-separator />
        <q-card-section>
          <div class="row">
            <div class="q-pa-sm col-12 col-md-5">
              <q-input
                color="primary"
                v-model="filtroNombre"
                outlined
                label="Nombre"
                clearable
                clear-icon="close"
              ></q-input>
            </div>
            <div class="q-pa-sm col-12 col-md-5">
              <q-input
                color="primary"
                v-model="filtroLogin"
                outlined
                label="No. Empleado/Usuario"
                clearable
                clear-icon="close"
              ></q-input>
            </div>
          </div>
          <div class="row">
            <div class="q-pa-sm col-10 col-md-5">
              <q-select
                outlined
                v-model="filtroGrupo"
                :options="opcionesGrupoLista"
                label="Grupo"
                option-label="nombre"
                option-value="idGrupo"
              />
            </div>
            <div class="q-pa-sm col-1 col-md-2">
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
        <q-card-actions>
          <q-btn
            icon="add"
            color="green-10"
            label="Agregar Usuario"
            @click="onClickNuevo"
          >
          </q-btn>
          <q-btn
            icon="password"
            color="primary"
            label="Cambiar contraseña"
            @click="onClickContrasena"
          >
          </q-btn>
          <q-btn
            icon="delete"
            color="red-10"
            label="Eliminar Usuario(s)"
            @click="onClickEliminar"
          >
          </q-btn>
        </q-card-actions>
        <q-card-section>
          <q-table
            bordered
            ref="tableRef"
            :rows="rows"
            :columns="columns"
            row-key="idUsuario"
            v-model:pagination="pagination"
            :loading="loading"
            binary-state-sort
            @request="onRequest"
            selection="multiple"
            v-model:selected="selected"
            no-data-label="No hay registros de usuarios"
            :rows-per-page-options="[0]"
            :selected-rows-label="getSelectedString"
            separator="cell"
            class="cursor-pointer"
            @row-click="seleccionarRegistro"
            table-header-class="bg-blue-3"
            table-bottom-class="bg-blue-3"
          >
          </q-table>
        </q-card-section>
      </q-card>
    </q-page>
    <q-dialog v-model="Editar" persistent>
      <q-card style="width: 75%">
        <q-card-section class="bg-grey-4">
          <div class="text-h6">Agregar/Editar Usuario</div>
        </q-card-section>
        <q-separator />
        <q-card-section class="q-pa-none">
          <div class="row">
            <div class="col-12 col-md-6 q-pa-sm">
              <q-input
                outlined
                label="No. Empleado/Usuario"
                v-model="registro.login"
                ref="refLogin"
                :disable="registro.idUsuario > 0"
                :rules="[(val) => !!val || 'El no. de empleado es requerido']"
              />
            </div>
            <div class="col-12 col-md-6 q-pa-sm">
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
            <div class="col-12 col-md-6 q-pa-sm">
              <q-input
                outlined
                label="Apellidos"
                v-model="registro.apellidos"
                ref="refApellidos"
                :rules="[(val) => !!val || 'El apellido paterno es requerido']"
              />
            </div>
            <div class="col-12 col-md-6 q-pa-sm">
              <q-select
                outlined
                v-model="grupoModel"
                :options="opcionesGrupoDetalle"
                label="Grupo"
                option-label="nombre"
                option-value="idGrupo"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-md-6 q-pa-sm">
              <q-input
                outlined
                label="Correo"
                v-model="registro.email"
                ref="refCorreo"
                type="email"
                :rules="[
                  (val) =>
                    new RegExp(/^[^\s@]+@[^\s@]+\.[^\s@]+$/).test(val) ||
                    val.length == 0 ||
                    'El e-mail ingresado no es válido',
                ]"
                lazy-rules
              />
            </div>
            <div class="col-12 col-md-6 q-pa-sm">
              <q-select
                outlined
                v-model="estatusModel"
                :options="opcionesEstatusDetalle"
                label="Estatus"
                option-label="nombre"
                option-value="idEstatus"
                :readonly="registro.idUsuario == 0"
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
            icon="check"
          />
        </q-card-actions>
      </q-card>
    </q-dialog>

    <q-dialog v-model="EditarContra" persistent>
      <q-card style="width: 50%">
        <q-card-section class="bg-grey-4">
          <div class="text-h6">Cambiar Contraseña</div>
        </q-card-section>
        <q-separator />
        <q-card-section class="q-pa-none">
          <div class="row">
            <div class="col-12 col-md-12 q-pa-sm">
              <q-input
                outlined
                label="Login"
                v-model="registroCont.login"
                :readonly="true"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-md-12 q-pa-sm">
              <q-input
                outlined
                label="Contraseña"
                v-model="registroCont.password"
                ref="refPassword"
                :rules="[(val) => !!val || 'La contraseña es requerida']"
                type="password"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-md-12 q-pa-sm">
              <q-input
                outlined
                label="Confirmación Contraseña"
                v-model="registroCont.passwordConf"
                ref="refPasswordConf"
                :rules="[
                  (val) =>
                    !!val || 'La confirmación de contraseña es requerida',
                  (val) =>
                    val == registroCont.password ||
                    'La contraseña y su confirmación no coinciden',
                ]"
                type="password"
              />
            </div>
          </div>
        </q-card-section>
        <q-separator />
        <q-card-actions align="right" class="text-primary">
          <q-btn label="Cancelar" color="red-10" icon="cancel" v-close-popup />
          <q-btn
            label="Aceptar"
            color="primary"
            @click="onClickGuardarContra"
            icon="check"
          />
        </q-card-actions>
      </q-card>
    </q-dialog>
  </div>
</template>

<style lang="css" scoped></style>
