/// dropdown item model class
class DropdownItem {
  String id;
  String value;
  bool selected = false;
  dynamic data;

  /// constructor for dropdown item class
  DropdownItem({this.id = "", this.value = "", this.data});

  @override
  String toString() {
    return value;
  }

  /// generate clone list of dropdown item
  static List<DropdownItem> cloneList(List<DropdownItem> list) {
    List<DropdownItem> cloneList = [];
    for (DropdownItem obj in list) {
      cloneList.add(obj);
    }
    return cloneList;
  }

  /// selected item by id from dropdown
  static DropdownItem? selectedItemById(List<DropdownItem> list, String id) {
    DropdownItem? selectedItem;
    for (DropdownItem obj in list) {
      if (DropdownItem._equals(id, obj.id)) {
        selectedItem = obj;
        break;
      }
    }
    if (selectedItem == null && list.isNotEmpty) {
      selectedItem = list[0];
    }
    return selectedItem;
  }

  /// selected item by value from dropdown
  static DropdownItem? selectedItemByValue(
      List<DropdownItem> list, String value) {
    DropdownItem? selectedItem;
    for (DropdownItem obj in list) {
      if (DropdownItem._equals(value, obj.value)) {
        selectedItem = obj;
        break;
      }
    }
    if (selectedItem == null && list.isNotEmpty) {
      selectedItem = list[0];
    }
    return selectedItem;
  }

  static bool _equals(String str1, String str2, {bool ignoreCase = true}) {
    if (ignoreCase) {
      return (str1.toLowerCase() == str2.toLowerCase());
    } else {
      return (str1 == str2);
    }
  }
}
