<template>
  <link
    rel="stylesheet"
    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0"
  />
  <q-layout view="hHh lpR fFf">
    <q-header elevated>
      <q-toolbar>
        <q-btn
          flat
          dense
          round
          icon="menu"
          aria-label="Menu"
          @click="toggleLeftDrawer"
        />

        <q-toolbar-title
          ><img src="../assets/favicon_blanco.png" style="width: 30px" />
          Determinación de Costos
        </q-toolbar-title>

        <div>Versión 1.0</div>
      </q-toolbar>
    </q-header>

    <q-drawer v-model="leftDrawerOpen" show-if-above bordered>
      <q-list dense bordered padding class="rounded-borders">
        <q-item style="background-color: #b3d5fb"
          ><q-item-section avatar>
            <q-icon name="perm_identity" />
          </q-item-section>

          <q-item-section>
            <q-item-label>{{ usuario }}</q-item-label>
            <q-item-label caption>{{ grupo }}</q-item-label>
          </q-item-section></q-item
        >

        <q-item clickable @click="abrirCalculoParametricos">
          <q-item-section avatar>
            <q-icon name="calculate" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Calcular Paramétricos</q-item-label>
          </q-item-section>
        </q-item>

        <q-item
          v-if="$q.localStorage.getItem('idgrupo') == 1"
          clickable
          @click="abrirUsuarios"
        >
          <q-item-section avatar>
            <q-icon name="group" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Usuarios</q-item-label>
          </q-item-section>
        </q-item>

        <q-item
          v-if="$q.localStorage.getItem('idgrupo') == 1"
          clickable
          @click="abrirActualizar"
        >
          <q-item-section avatar>
            <q-icon name="settings" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Actualizar Parámetros</q-item-label>
          </q-item-section>
        </q-item>

        <q-item
          v-if="$q.localStorage.getItem('idgrupo') == 1"
          clickable
          @click="abrirLogSistema"
        >
          <q-item-section avatar>
            <q-icon name="list_alt" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Log del Sistema</q-item-label>
          </q-item-section>
        </q-item>

        <q-item
          clickable
          @click="cerrarSesion"
          style="background-color: #ffb7b9"
        >
          <q-item-section avatar>
            <q-icon name="logout" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Cerrar Sesión</q-item-label>
          </q-item-section>
        </q-item>
      </q-list>
    </q-drawer>

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script setup>
import { ref } from "vue";
import { useQuasar } from "quasar";

const $q = useQuasar();

const usuario = ref("");
const grupo = ref("");

defineOptions({
  name: "MainLayout",
});

if (!$q.localStorage.hasItem("idusuario")) window.location = "/#/";
else {
  if ($q.localStorage.getItem("idusuario") == "0") window.location = "/#/";
  else {
    usuario.value =
      $q.localStorage.getItem("nombre") +
      " " +
      $q.localStorage.getItem("apellidos") +
      " [" +
      $q.localStorage.getItem("login") +
      "]";
    grupo.value = $q.localStorage.getItem("grupo");
  }
}

const leftDrawerOpen = ref(false);

function toggleLeftDrawer() {
  leftDrawerOpen.value = !leftDrawerOpen.value;
}

function abrirCalculoParametricos() {
  window.location = "/#/Operacion/CalcularParametricos";
}

function abrirUsuarios() {
  window.location = "/#/Configuracion/Usuarios";
}

function abrirLogSistema() {
  window.location = "/#/Reportes/LogSistema";
}

function abrirActualizar() {
  window.location = "/#/Operacion/ActualizarParametros";
}

function cerrarSesion() {
  $q.localStorage.set("idusuario", 0);
  $q.localStorage.set("login", "");
  $q.localStorage.set("apellidos", "");
  $q.localStorage.set("nombre", "");
  $q.localStorage.set("grupo", "");
  $q.localStorage.set("idgrupo", 0);

  $q.localStorage.set("appMenu", "");

  //Desarrollo
  window.location = "/#/";
  //Certificación ITSSA
  //window.location = "/ControlVehicular/#/";
  //Certificación SAPAL
  //window.location = "/ControlVehicularFront/#/";
  //Producción
  //window.location = "/ControlVehicular/#/";
}
</script>
