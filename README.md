[<img src="https://datadirr.com/datadirr.png" width="200" />](https://datadirr.com)


# flutter_dropdown_plus

Single or Multi Selection Dropdown with search dropdown item, and easy to customization.


## Using

For help getting started with Flutter, view our
[online documentation](https://pub.dev/documentation/flutter_dropdown_plus/latest), which offers tutorials,
samples, guidance on mobile and web development, and a full API reference.

## Installation

First, add `flutter_dropdown_plus` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

In your flutter project add the dependency:

```yml
dependencies:
  ...
  flutter_dropdown_plus:
```

For help getting started with Flutter, view the online
[documentation](https://flutter.io/).

## Example

Please follow this [example](https://github.com/datadirr/flutter_dropdown_plus/tree/master/example) here.

### Dropdown - Single Selection and Multi Selection

1. Declare variables
```dart
List<DropdownItem> _itemList = [];
String _singleSelectedId = ""; //for single selection dropdown
List<String> _multiSelectedIds = []; //for multi selection dropdown
```

2. Generate your item list
```dart
_generateItems() {
  List<DropdownItem> list = [];
  for (int i = 1; i <= 20; i++) {
    list.add(DropdownItem(
        id: "$i",
        value: "Item $i",
        data: User(userId: "$i", userName: "User $i") /* User class is another data class (data: use any datatype field )*/
    ));
  }
  setState(() {
    _itemList = list;
  });
}
```

3. Put Dropdown in your build function

* Single Selection Dropdown
```dart
Dropdown.singleSelection(
  title: "Single Selection Dropdown",
  labelText: "Single",
  hintText: "Single Selection",
  list: _itemList,
  selectedId: _singleSelectedId,
  isAddItem: true,
  onTapAddItem: (searchValue) {
    log(searchValue);
  },
  onSingleItemListener: (selectedItem) {
    setState(() {
      _singleSelectedId = selectedItem.id;
    });
    String itemId = selectedItem.id;
    String itemName = selectedItem.value;
    User user = selectedItem.data as User;
    log("Item Id: $itemId -- Item Name: $itemName ## Other Details ## User Id: ${user.userId} -- User Name: ${user.userName}");
})
```

* Multi Selection Dropdown
```dart
Dropdown.multiSelection(
  title: "Multi Selection Dropdown",
  labelText: "Multi",
  hintText: "Multi Selection",
  list: _itemList,
  selectedIds: _mutiSelectedIds,
  isAllSelection: true,
  isAddItem: true,
  onTapAddItem: (searchValue) {
    log(searchValue);
  },
  onMultipleItemListener: (selectedItemList) {
    for (DropdownItem selectedItem in selectedItemList) {
      String itemId = selectedItem.id;
      String itemName = selectedItem.value;
      User user = selectedItem.data as User;
      log("Item Id: $itemId -- Item Name: $itemName ## Other Details ## User Id: ${user.userId} -- User Name: ${user.userName}");
    }
})
```

* Dropdown with TextField
```dart
DropdownTextField(
  controller: _conDropdownTextField,
  list: _itemList,
  hintText: "Item search",
  labelText: "Item search"
),
```

