<template>
  <q-item clickable tag="a" :href="props.url">
    <q-item-section>
      <q-item-label>{{ props.nombre }}</q-item-label>
    </q-item-section>
  </q-item>
</template>

<script setup>
defineOptions({
  name: "MenusHijo",
});

const props = defineProps({
  idMenu: {
    type: Number,
    required: true,
  },
  nombre: {
    type: String,
    required: true,
  },
  url: {
    type: String,
    default: "#",
  },
});
</script>
