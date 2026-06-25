<script setup>
import { ref, onMounted } from "vue";
import { useQuasar } from "quasar";
import { revisarPermisos } from "../functions/funciones";

const $q = useQuasar();

const permCitas = ref(false);
const permServicios = ref(false);
const permBitacoras = ref(false);
const permOrdenes = ref(false);

function onClickCitas() {
  window.location.href = "#/Operacion/CitaLista";
}

function onClickTaller() {
  window.location.href = "#/Operacion/ServiciosProceso";
}

function onClickBitacoras() {
  window.location.href = "#/Operacion/BitacoraDeRecorrido";
}

function onClickOrdenes() {
  window.location.href = "#/Operacion/Ordenes";
}

onMounted(() => {
  revisarPermisos(
    $q.localStorage.getItem("idgrupo"),
    "/PaginaInicio",
    permCitas,
    "Ver Citas",
    permServicios,
    "Ver Servicios",
    permBitacoras,
    "Ver Bitacoras",
    permOrdenes,
    "Ver Ordenes"
  );
});
</script>

<template>
  <q-page class="flex flex-center">
    <q-layout view="lHh Lpr lFf">
      <q-page-container>
        <q-page class="flex flex-center bg-grey-2">
          <q-card class="q-pa-md shadow-2 my_card" bordered>
            <q-card-section class="text-center">
              <img src="../assets/logo-sapal.png" /><br /><br />
              <img src="../assets/BannerInicio.png" /><br /><br />
            </q-card-section>
            <q-card-actions align="center">
              <q-btn
                icon="calendar_month"
                color="primary"
                label="Calendario de Citas"
                size="xl"
                v-if="permCitas"
                @click="onClickCitas"
              />
              <q-btn
                icon="build_circle"
                color="primary"
                label="Vehículos en Taller"
                size="xl"
                v-if="permServicios"
                @click="onClickTaller"
              />
              <q-btn
                icon="history"
                color="primary"
                label="Bitácoras de Recorrido"
                size="xl"
                v-if="permBitacoras"
                @click="onClickBitacoras"
              />
              <q-btn
                icon="fact_check"
                color="primary"
                label="Órdenes de Trabajo"
                size="xl"
                v-if="permOrdenes"
                @click="onClickOrdenes"
              />
            </q-card-actions>
          </q-card>
        </q-page>
      </q-page-container>
    </q-layout>
  </q-page>
</template>

<style lang="scss" scoped></style>
