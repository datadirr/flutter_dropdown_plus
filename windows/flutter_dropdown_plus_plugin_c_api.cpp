#include "include/flutter_dropdown_plus/flutter_dropdown_plus_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_dropdown_plus_plugin.h"

void FlutterDropdownPlusPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_dropdown_plus::FlutterDropdownPlusPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
