#include "include/yearly_planning/yearly_planning_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "yearly_planning_plugin.h"

void YearlyPlanningPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  yearly_planning::YearlyPlanningPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
