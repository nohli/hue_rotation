//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <hue_rotation/hue_rotation_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) hue_rotation_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "HueRotationPlugin");
  hue_rotation_plugin_register_with_registrar(hue_rotation_registrar);
}
