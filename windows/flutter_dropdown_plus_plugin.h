#ifndef FLUTTER_PLUGIN_FLUTTER_DROPDOWN_PLUS_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_DROPDOWN_PLUS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_dropdown_plus {

class FlutterDropdownPlusPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterDropdownPlusPlugin();

  virtual ~FlutterDropdownPlusPlugin();

  // Disallow copy and assign.
  FlutterDropdownPlusPlugin(const FlutterDropdownPlusPlugin&) = delete;
  FlutterDropdownPlusPlugin& operator=(const FlutterDropdownPlusPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_dropdown_plus

#endif  // FLUTTER_PLUGIN_FLUTTER_DROPDOWN_PLUS_PLUGIN_H_
