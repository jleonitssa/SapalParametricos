const routes = [
  {
    path: "/",
    component: () => import("layouts/InicioLayout.vue"),
    children: [{ path: "", component: () => import("pages/IndexPage.vue") }],
  },
  {
    path: "/PaginaInicio",
    component: () => import("layouts/MainLayout.vue"),
    children: [{ path: "", component: () => import("pages/PaginaInicio.vue") }],
  },
  {
    path: "/Configuracion",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      {
        path: "Usuarios",
        component: () => import("src/pages/ConfiguracionUsuario.vue"),
      },
      {
        path: "Acciones",
        component: () => import("src/pages/ConfiguracionAccion.vue"),
      },
      {
        path: "PantallaLista",
        component: () => import("src/pages/ConfiguracionPantallaLista.vue"),
      },
      {
        path: "PantallaDetalle",
        component: () => import("src/pages/ConfiguracionPantallaDetalle.vue"),
      },
      {
        path: "GrupoLista",
        component: () => import("src/pages/ConfiguracionGrupoLista.vue"),
      },
      {
        path: "GrupoDetalle",
        component: () => import("src/pages/ConfiguracionGrupoDetalle.vue"),
      },
      {
        path: "Menu",
        component: () => import("src/pages/ConfiguracionMenu.vue"),
      },
      {
        path: "Configuracion",
        component: () => import("src/pages/ConfiguracionConfiguracion.vue"),
      },
    ],
  },
  {
    path: "/Operacion",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      {
        path: "CalcularParametricos",
        component: () => import("src/pages/OperacionCalcularParametricos.vue"),
      },
      {
        path: "ActualizarParametros",
        component: () => import("src/pages/OperacionActualizarParametros.vue"),
      },
    ],
  },
  {
    path: "/Reportes",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      {
        path: "LogSistema",
        component: () => import("src/pages/ReportesLogSistema.vue"),
      },
    ],
  },
  // Always leave this as last one,
  // but you can also remove it
  {
    path: "/:catchAll(.*)*",
    component: () => import("pages/ErrorNotFound.vue"),
  },
];

export default routes;
