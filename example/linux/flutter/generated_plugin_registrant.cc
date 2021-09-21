//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <responsive_navigation_bar/responsive_navigation_bar_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) responsive_navigation_bar_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ResponsiveNavigationBarPlugin");
  responsive_navigation_bar_plugin_register_with_registrar(responsive_navigation_bar_registrar);
}
