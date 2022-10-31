//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <yearly_planning/yearly_planning_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) yearly_planning_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "YearlyPlanningPlugin");
  yearly_planning_plugin_register_with_registrar(yearly_planning_registrar);
}
