launch_css <- function() {
  htmltools::tags$style(htmltools::HTML(
    "
    .bslib-sidebar-layout[data-bslib-sidebar-border='false']:not(.sidebar-right) {
      border: var(--bs-card-border-width, 1px) solid var(--bs-card-border-color, rgba(0, 0, 0, .175)) !important;
    }
    .bslib-sidebar-layout[data-bslib-sidebar-border-radius='false']:not(.sidebar-right) {
      border-radius: var(--bs-border-radius, 0.375rem) !important;
    }

    .bslib-sidebar-layout[data-bslib-sidebar-border='false']:not(.sidebar-right) > .main {
      padding: 0 !important;
    }

    .bslib-sidebar-layout.sidebar-right > .main {
      padding: 0 !important;
    }

    .card-header {
      text-align: center;
      justify-content: center;
    }

    .bslib-sidebar-layout > .sidebar > .sidebar-content {
      padding-top: var(--_padding) !important;
    }
    .bslib-sidebar-layout > .collapse-toggle {
      top: 1.35rem !important;
    }

    .bslib-sidebar-layout.sidebar-right > .collapse-toggle {
      left: unset !important;
      right: var(--_icon-size) !important;
    }

    nav.navbar {
      border-radius: var(--bs-border-radius, 0.375rem) !important;
      border: var(--bs-card-border-width, 1px) solid var(--bs-card-border-color, rgba(0, 0, 0, .175)) !important;
    }
    "
  ))
}
