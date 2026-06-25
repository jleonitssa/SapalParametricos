<template>
  <q-expansion-item expand-separator :label="props.nombre">
    <MenusHijo v-for="link in props.menus" :key="link.id" v-bind="link" />
  </q-expansion-item>
</template>

<script setup>
import MenusHijo from "components/MenusHijo.vue";

defineOptions({
  name: "MenusPadre",
});

const props = defineProps({
  nombre: {
    type: String,
    required: true,
  },
  menus: {
    type: Object,
  },
});
</script>
