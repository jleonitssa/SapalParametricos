<script lang="ts" setup>
import { ref, computed, onMounted, watch } from "vue";
import { api } from "boot/axios";
import { useQuasar } from "quasar";

const $q = useQuasar();

const urlImagenes = ref(
  $q.localStorage.getItem("urlImagenes")
);

const loading = ref(false);

//const calcularHabilitado = ref(true);

let contadorEjercicios = 1;

const formatterMXN = new Intl.NumberFormat("es-MX", {
  style: "currency",
  currency: "MXN",
});

interface LineaTrabajo {
  idLineaTrabajo: number;
  nombre: string;
  incluye: string;
  idClaveTrabajo: number;
}

interface Excavacion {
  idExcavacion: number;
  nombre: string;
}

interface Material {
  idTipoMaterial: number;
  nombre: string;
  imagen: string;
}

interface Obra {
  idTipoObra: number;
  idClaveTrabajo: number;
  nombre: string;
}

interface Tuberia {
  idRelacion: number;
  idLineaTrabajo: number;
  idTipoObra: number;
  idTuberia: number;
  tuberia: string;
}

interface Diametro {
  idRelacion: number;
  idRelacionObra: number;
  idDiametro: number;
  diametro: string;
}

interface Precio {
  idRelacion: number;
  idRelacionDiametro: number;
  idTipoMaterial: number;
  idExcavacion: number;
  precio: number;
  descripcion: string;
}

const opcionesLinea = ref<LineaTrabajo[]>([
  {
    idLineaTrabajo: 0,
    nombre: "",
    incluye: "",
    idClaveTrabajo: 0,
  },
]);

const opcionesMaterial = ref<Material[]>([
  {
    idTipoMaterial: 0,
    nombre: "",
    imagen: "",
  },
]);

const opcionesExcavacion = ref<Excavacion[]>([
  {
    idExcavacion: 0,
    nombre: "",
  },
]);

function calcularTotalEjercicio(ejercicio: any): number {

  const metros =
    Number(ejercicio.metros) || 0;

  const precio =
    Number(ejercicio.precio.precio) || 0;

  const pendiente =
    Number(ejercicio.pendiente) || 0;

  // ==========================================
  // SUBTOTAL
  // ==========================================

  const subtotal =
    metros * precio;

  // ==========================================
  // PENDIENTE
  // ==========================================

  let importePendiente = 0;

  if (
    ejercicio.linea.idLineaTrabajo === 4
  ) {

    importePendiente =
      subtotal *
      (pendiente / 100);
  }

  // ==========================================
  // TOTAL
  // ==========================================

  return (
    subtotal +
    importePendiente
  );
}

function crearEjercicio() {
  return {
    id: contadorEjercicios++,

    nombre: `Ejercicio ${contadorEjercicios - 1}`,

    linea: {
      idLineaTrabajo: 0,
      nombre: "",
      incluye: "",
      idClaveTrabajo: 0,
    } as LineaTrabajo,

    obra: {
      idTipoObra: 0,
      idClaveTrabajo: 0,
      nombre: "",
    } as Obra,

    tuberia: {
      idRelacion: 0,
      idLineaTrabajo: 0,
      idTipoObra: 0,
      idTuberia: 0,
      tuberia: "",
    } as Tuberia,

    diametro: {
      idRelacion: 0,
      idRelacionObra: 0,
      idDiametro: 0,
      diametro: "",
    } as Diametro,

    material: {
      idTipoMaterial: 0,
      nombre: "",
      imagen: "",
    } as Material,

    excavacion: {
      idExcavacion: 0,
      nombre: "",
    } as Excavacion,

    precio: {
      idRelacion: 0,
      idRelacionDiametro: 0,
      idTipoMaterial: 0,
      idExcavacion: 0,
      precio: 0,
      descripcion: "",
    } as Precio,

    opcionesObra: [] as Obra[],
    opcionesTuberia: [] as Tuberia[],
    opcionesDiametro: [] as Diametro[],

    metros: 0,

    pendiente: 0,

    total: 0,

    expanded: true,

    calcularHabilitado: true,

    cargandoPrecio: false,
  };
}

const ejercicios = ref([
  crearEjercicio(),
]);

function formatoMXN(valor: number) {
  return formatterMXN.format(valor || 0);
}

function calcularEjercicio(ejercicio: any) {

  const metros =
    Number(ejercicio.metros) || 0;

  const precio =
    Number(ejercicio.precio.precio) || 0;

  const pendiente =
    Number(ejercicio.pendiente) || 0;

  // ------------------------------------------
  // SUBTOTAL
  // ------------------------------------------

  const subtotal =
    metros * precio;

  // ------------------------------------------
  // PENDIENTE
  // Solo Línea de Trabajo 4
  // ------------------------------------------

  let importePendiente = 0;

  if (
    ejercicio.linea.idLineaTrabajo === 4
  ) {
    importePendiente =
      subtotal * (pendiente / 100);
  }

  // ------------------------------------------
  // TOTAL
  // ------------------------------------------

  ejercicio.total =
    subtotal + importePendiente;
}

const granTotal = computed(() => {

  return ejercicios.value.reduce(
    (total, ejercicio) => {

      return total +
        calcularTotalEjercicio(ejercicio);

    },
    0
  );

});

function agregarEjercicio() {
  const nuevoEjercicio = crearEjercicio();

  // Agregamos primero el ejercicio al arreglo
  ejercicios.value.push(nuevoEjercicio);

  // Configuramos inmediatamente sus watchers
  configurarWatchers(nuevoEjercicio);

  // Cargamos los valores iniciales
  cargarValoresIniciales(nuevoEjercicio);

  // Forzamos un cálculo inicial
  calcularEjercicio(nuevoEjercicio);
}

function eliminarEjercicio(
  index: number
) {

  if (
    ejercicios.value.length === 1
  ) {
    $q.notify({
      type: "warning",
      message:
        "Debe existir al menos un ejercicio.",
    });

    return;
  }

  ejercicios.value.splice(
    index,
    1
  );

}

function cargarValoresIniciales(
  ejercicio: any
) {

  if (opcionesLinea.value.length > 0) {

    ejercicio.linea =
      opcionesLinea.value[0];

    cargarTiposObra(ejercicio);
  }

  if (opcionesMaterial.value.length > 0) {

    ejercicio.material =
      opcionesMaterial.value[0];
  }

  if (opcionesExcavacion.value.length > 0) {

    ejercicio.excavacion =
      opcionesExcavacion.value[0];
  }

}

async function cargarTiposObra(
  ejercicio: any
) {

  const req = {

    idTipoObra: 0,

    idClaveTrabajo:
      ejercicio.linea.idClaveTrabajo,

    nombre: "",

    initRow: 1,

    endRow: 100,

    sortColumn:
      "idTipoObra",

    sortDir: "ASC",
  };

  try {

    const response =
      await api.post(
        "/tipoobra/TipoObraSelect",
        req
      );

    const resp =
      response.data;

    if (
      resp.codigo === 1
    ) {

      ejercicio.opcionesObra =
        resp.tiposObra || [];

      ejercicio.obra =
        ejercicio.opcionesObra[0] ||
        {
          idTipoObra: 0,
          idClaveTrabajo: 0,
          nombre: "",
        };

      await cargarTuberias(
        ejercicio
      );

    }

  } catch (error) {

    console.error(error);

  }

}

async function cargarTuberias(
  ejercicio: any
) {

  const req = {

    idRelacion: 0,

    idLineaTrabajo:
      ejercicio.linea.idLineaTrabajo,

    idTipoObra:
      ejercicio.obra.idTipoObra,

    idTuberia: 0,

    initRow: 0,

    endRow: 100,

    sortColumn:
      "idRelacion",

    sortDir: "ASC",
  };

  try {

    const response =
      await api.post(
        "/relacionlineaobratuberia/RelacionLineaObraTuberiaSelect",
        req
      );

    const resp =
      response.data;

    if (
      resp.codigo === 1
    ) {

      ejercicio.opcionesTuberia =
        resp.relacionesLineaObraTuberia ||
        [];

      ejercicio.tuberia =
        ejercicio.opcionesTuberia[0] ||
        {
          idRelacion: 0,
          idLineaTrabajo: 0,
          idTipoObra: 0,
          idTuberia: 0,
          tuberia: "",
        };

      await cargarDiametros(
        ejercicio
      );

    }

  } catch (error) {

    console.error(error);

  }

}

async function cargarDiametros(
  ejercicio: any
) {

  const req = {

    idRelacion: 0,

    idRelacionObra:
      ejercicio.tuberia.idRelacion,

    idDiametro: 0,

    initRow: 0,

    endRow: 100,

    sortColumn:
      "idRelacion",

    sortDir: "ASC",
  };

  try {

    const response =
      await api.post(
        "/relacionobradiametro/RelacionObraDiametroSelect",
        req
      );

    const resp =
      response.data;

    if (
      resp.codigo === 1
    ) {

      ejercicio.opcionesDiametro =
        resp.relacionesObraDiametro ||
        [];

      ejercicio.diametro =
        ejercicio.opcionesDiametro[0] ||
        {
          idRelacion: 0,
          idRelacionObra: 0,
          idDiametro: 0,
          diametro: "",
        };

      await encontrarPrecioFinal(
        ejercicio
      );

    }

  } catch (error) {

    console.error(error);

  }

}

async function encontrarPrecioFinal(
  ejercicio: any
) {

  const req = {

    idRelacion: 0,

    idRelacionDiametro:
      ejercicio.diametro.idRelacion,

    idTipoMaterial:
      ejercicio.material.idTipoMaterial,

    idExcavacion:
      ejercicio.excavacion.idExcavacion,

    initRow: 0,

    endRow: 100,

    sortColumn:
      "idRelacion",

    sortDir: "ASC",
  };

  ejercicio.cargandoPrecio = true;

  try {

    const response =
      await api.post(
        "/relacionfinalprecio/RelacionFinalPrecioSelect",
        req
      );

    const resp =
      response.data;

    if (
      resp.codigo === 1
    ) {

      if (
        resp.relacionesFinalPrecio &&
        resp.relacionesFinalPrecio.length > 0
      ) {

        ejercicio.precio =
          resp.relacionesFinalPrecio[0];

        ejercicio.calcularHabilitado =
          true;

      } else {

        ejercicio.precio = {

          idRelacion: 0,

          idRelacionDiametro: 0,

          idTipoMaterial: 0,

          idExcavacion: 0,

          precio: 0,

          descripcion:
            "NO HAY PRECIO PARA LAS ESPECIFICACIONES INGRESADAS",
        };

        ejercicio.calcularHabilitado =
          false;

      }

      calcularEjercicio(
        ejercicio
      );

    }

  } catch (error) {

    console.error(error);

  } finally {

    ejercicio.cargandoPrecio =
      false;

  }

}

function configurarWatchers(ejercicio: any) {

  watch(
    () => ejercicio.linea,
    async () => {

      ejercicio.pendiente = 0;

      await cargarTiposObra(ejercicio);

      calcularEjercicio(ejercicio);

    },
    {
      deep: true,
    }
  );

  watch(
    () => ejercicio.obra,
    async () => {

      await cargarTuberias(ejercicio);

    },
    {
      deep: true,
    }
  );

  watch(
    () => ejercicio.tuberia,
    async () => {

      await cargarDiametros(ejercicio);

    },
    {
      deep: true,
    }
  );

  watch(
    [
      () => ejercicio.material,
      () => ejercicio.excavacion,
      () => ejercicio.diametro,
    ],
    async () => {

      await encontrarPrecioFinal(ejercicio);

    },
    {
      deep: true,
    }
  );

  watch(
    [
      () => ejercicio.metros,
      () => ejercicio.pendiente,
    ],
    () => {

      calcularEjercicio(ejercicio);

    }
  );

}

function configurarTodosLosWatchers() {

  ejercicios.value.forEach(
    (ejercicio) => {

      configurarWatchers(
        ejercicio
      );

    }
  );

}

async function cargarCombosInicio() {

  loading.value = true;

  try {

    const reqLinea = {

      idLineaTrabajo: 0,

      nombre: "",

      idClaveTrabajo: 0,

      initRow: 0,

      endRow: 100,

      sortColumn:
        "idLineaTrabajo",

      sortDir: "ASC",
    };

    const responseLinea =
      await api.post(
        "/lineatrabajo/LineaTrabajoSelect",
        reqLinea
      );

    const respLinea =
      responseLinea.data;

    if (
      respLinea.codigo === 1
    ) {

      opcionesLinea.value =
        respLinea.lineasTrabajo || [];

    }

    const reqMaterial = {

      idTipoMaterial: 0,

      nombre: "",

      initRow: 0,

      endRow: 100,

      sortColumn:
        "idTipoMaterial",

      sortDir: "ASC",
    };

    const responseMaterial =
      await api.post(
        "/tipomaterial/TipoMaterialSelect",
        reqMaterial
      );

    const respMaterial =
      responseMaterial.data;

    if (
      respMaterial.codigo === 1
    ) {

      opcionesMaterial.value =
        respMaterial.tiposMaterial || [];

    }

    const reqExcavacion = {

      idExcavacion: 0,

      nombre: "",

      initRow: 0,

      endRow: 100,

      sortColumn:
        "idExcavacion",

      sortDir: "ASC",
    };

    const responseExcavacion =
      await api.post(
        "/excavacion/ExcavacionSelect",
        reqExcavacion
      );

    const respExcavacion =
      responseExcavacion.data;

    if (
      respExcavacion.codigo === 1
    ) {

      opcionesExcavacion.value =
        respExcavacion.excavaciones || [];

    }

    cargarValoresIniciales(
      ejercicios.value[0]
    );

  } catch (error) {

    console.error(error);

  } finally {

    loading.value = false;

  }

}

onMounted(async () => {

  await cargarCombosInicio();

  configurarTodosLosWatchers();

});
</script>

<template>

  <q-page class="bg-grey-3 q-pa-md">

    <q-card
      bordered
      class="q-pa-md"
    >

      <q-card-section>

        <div class="text-center">

          <img
            src="../assets/logo-sapal.png"
            style="max-width: 180px"
          />

          <div
            class="text-grey-9 text-weight-bold q-mt-md"
            style="font-size: 16pt"
          >
            DETERMINACIÓN DE COSTOS DEL METRO
            DE CONSTRUCCIÓN MEDIANTE PARAMÉTRICOS
          </div>

        </div>

      </q-card-section>

      <q-separator />

      <q-card-section>

        <div
          class="row justify-end"
        >

          <q-btn
            color="primary"
            icon="add"
            label="Nuevo ejercicio"
            unelevated
            @click="agregarEjercicio"
          />

        </div>

      </q-card-section>

      <q-card-section>

        <q-expansion-item
          v-for="(
            ejercicio,
            index
          ) in ejercicios"

          :key="ejercicio.id"

          v-model="ejercicio.expanded"

          expand-separator

          icon="calculate"

          :label="
            `Ejercicio ${index + 1}`
          "

          class="q-mb-md"
        >

          <template #header>

            <q-item-section
              avatar
            >

              <q-avatar
                color="primary"
                text-color="white"
                icon="calculate"
              />

            </q-item-section>

            <q-item-section>

              <q-item-label
                class="text-weight-bold"
              >
                Ejercicio {{ index + 1 }}
              </q-item-label>

              <q-item-label
                caption
              >
                {{
                  ejercicio.linea.nombre ||
                  "Sin línea de trabajo"
                }}
              </q-item-label>

            </q-item-section>

            <q-item-section
              side
            >

              <div
                class="text-primary text-weight-bold"
              >
                {{ formatoMXN(calcularTotalEjercicio(ejercicio)) }}
              </div>

            </q-item-section>

          </template>

          <q-card-section>

            <div class="row">

              <div
                class="q-pa-sm col-12 col-md-6"
              >

                <q-select
                  v-model="ejercicio.linea"
                  :options="opcionesLinea"
                  outlined
                  label="Línea de Trabajo"
                  option-label="nombre"
                  option-value="idLineaTrabajo"
                  :emit-value="false"
                  map-options
                />

              </div>


              <div
                class="q-pa-sm col-12 col-md-6"
              >

                <q-select
                  v-model="ejercicio.material"
                  :options="opcionesMaterial"
                  outlined
                  label="Tipo de Material"
                  option-label="nombre"
                  option-value="idTipoMaterial"
                  :emit-value="false"
                  map-options
                />

              </div>

            </div>


            <div class="row">

              <div
                class="q-pa-sm col-12 col-md-6"
              >

                <q-select
                  v-model="ejercicio.obra"
                  :options="ejercicio.opcionesObra"
                  outlined
                  label="Tipo de Obra"
                  option-label="nombre"
                  option-value="idTipoObra"
                  map-options
                />

              </div>


              <div
                class="q-pa-sm col-12 col-md-6"
              >

                <q-select
                  v-model="ejercicio.tuberia"
                  :options="ejercicio.opcionesTuberia"
                  outlined
                  label="Tipo de Tubería"
                  option-label="tuberia"
                  option-value="idRelacion"
                  map-options
                />

              </div>

            </div>


            <div class="row">

              <div
                class="q-pa-sm col-12 col-md-6"
              >

                <q-select
                  v-model="ejercicio.diametro"
                  :options="ejercicio.opcionesDiametro"
                  outlined
                  label="Diámetro de Tubería"
                  option-label="diametro"
                  option-value="idRelacion"
                  map-options
                />

              </div>


              <div
                class="q-pa-sm col-12 col-md-6"
              >

                <q-select
                  v-model="ejercicio.excavacion"
                  :options="opcionesExcavacion"
                  outlined
                  label="Excavación en"
                  option-label="nombre"
                  option-value="idExcavacion"
                  map-options
                />

              </div>

            </div>

            <div class="row">

              <div
                class="q-pa-sm col-12 col-md-6"
              >

                <q-img
                  v-if="ejercicio.material.imagen"
                  :src="
                    urlImagenes +
                    '/imagenes/' +
                    ejercicio.material.imagen
                  "
                  fit="contain"
                  style="max-height: 300px"
                />

              </div>


              <div
                class="q-pa-sm col-12 col-md-6"
              >

                <q-input
                  v-model="
                    ejercicio.linea.incluye
                  "
                  outlined
                  label="Incluye"
                  type="textarea"
                  readonly
                  class="q-mb-md"
                />

                <q-input
                  v-model="
                    ejercicio.precio.descripcion
                  "
                  outlined
                  label="Descripción"
                  type="textarea"
                  readonly
                />

              </div>

            </div>

            <div class="row">

              <div
                class="q-pa-sm col-12 col-md-6"
              >

                <q-input
                  :model-value="
                    formatoMXN(
                      ejercicio.precio.precio
                    )
                  "
                  outlined
                  label="Precio por Metro"
                  readonly
                />

              </div>


              <div
                class="q-pa-sm col-12 col-md-6"
              >

                <q-input
                  v-model.number="
                    ejercicio.metros
                  "
                  outlined
                  type="number"
                  label="Metros"
                  min="0"
                  step="0.01"
                />

              </div>

            </div>

            <div
              v-if="
                ejercicio.linea.idLineaTrabajo === 4
              "
              class="row"
            >

              <div
                class="q-pa-sm col-12 col-md-6"
              >

                <q-input
                  v-model.number="
                    ejercicio.pendiente
                  "
                  outlined
                  type="number"
                  label="Pendiente"
                  suffix="%"
                  min="0"
                  max="100"
                  step="0.01"
                />

              </div>

              <div
                class="q-pa-sm col-12 col-md-6"
              >

                <q-input
                  :model-value="
                    formatoMXN(
                      (
                        ejercicio.metros *
                        ejercicio.precio.precio
                      ) *
                      (
                        ejercicio.pendiente / 100
                      )
                    )
                  "
                  outlined
                  label="Importe de Pendiente"
                  readonly
                />

              </div>

            </div>


            <q-separator
              class="q-my-md"
            />

            <div
              class="row justify-end"
            >

              <div
                class="col-12 col-md-6"
              >

                <q-input
                  :model-value="
                    formatoMXN(
                      calcularTotalEjercicio(ejercicio)
                    )
                  "
                  outlined
                  readonly
                  label="Total sin IVA"
                  input-class="text-weight-bold text-right"
                />

              </div>

            </div>

            <div
              class="row justify-end q-mt-md"
            >

              <q-btn
                flat
                color="negative"
                icon="delete"
                label="Eliminar ejercicio"
                @click="
                  eliminarEjercicio(index)
                "
              />

            </div>

          </q-card-section>

        </q-expansion-item>

      </q-card-section>

      <q-separator />

      <q-card-section>

        <q-card
          flat
          bordered
          class="bg-primary text-white"
        >

          <q-card-section>

            <div
              class="row items-center"
            >

              <div
                class="col"
              >

                <div
                  class="text-subtitle1 text-weight-medium"
                >
                  GRAN TOTAL
                </div>

                <div
                  class="text-caption"
                >
                  Total de todos los ejercicios
                  sin IVA
                </div>

              </div>


              <div
                class="col-auto"
              >

                <div
                  class="text-h5 text-weight-bold"
                >
                  {{
                    formatoMXN(
                      granTotal
                    )
                  }}
                </div>

              </div>

            </div>

          </q-card-section>

        </q-card>

      </q-card-section>

    </q-card>

  </q-page>

</template>


<style lang="scss" scoped>

.q-expansion-item {
  border-radius: 10px;
  overflow: hidden;
  background: white;
}

</style>
