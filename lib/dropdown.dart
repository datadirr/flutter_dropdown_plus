import 'package:flutter/material.dart';
import 'package:flutter_dropdown_plus/dropdown_item.dart';

const String _ok = "OK";
const String _cancel = "Cancel";
const String _has = "#";
const String _comma = ",";
const String _searchHere = "Search here...";
const String _addItem = "+ Add Item";
const IconData _icSearch = Icons.search;

Widget _addItemWidget() {
  return const Align(
      alignment: Alignment.centerRight,
      child: Text(_addItem, style: TextStyle(color: Colors.blue)));
}

/// Dropdown for single selection or multi selection
class Dropdown extends StatefulWidget {
  final List<DropdownItem> list;
  final String? selectedId;
  final List<String>? selectedIds;
  final String title;
  final String labelText;
  final String hintText;
  final bool enabled;
  final TextAlign textAlign;
  final InputBorder border;
  final InputDecoration? decoration;
  final String prefixSeparator;
  final String suffixSeparator;
  final Color itemBackgroundColor;
  final Color selectedItemBackgroundColor;
  final bool searchBox;
  final String searchBoxHintText;
  final IconData prefixSearchBoxIcon;
  final String negativeButtonText;
  final String positiveButtonText;
  final Color negativeButtonTextColor;
  final Color positiveButtonTextColor;
  final bool isAllSelection;
  final bool isAddItem;
  final bool dismissWhenTapAddItem;
  final Widget? addItemWidget;
  final Color checkBoxActiveColor;
  final Function(DropdownItem selectedItem)? onSingleItemListener;
  final Function(List<DropdownItem> selectedItemList)? onMultipleItemListener;
  final Function(String searchValue)? onTapAddItem;
  final bool _isMultiple;

  /// constructor for single selection dropdown
  const Dropdown.singleSelection(
      {Key? key,
      required this.list,
      required this.onSingleItemListener,
      this.selectedId,
      this.title = "",
      this.labelText = "",
      this.hintText = "",
      this.enabled = true,
      this.textAlign = TextAlign.start,
      this.border = const OutlineInputBorder(),
      this.decoration,
      this.searchBox = true,
      this.searchBoxHintText = _searchHere,
      this.prefixSearchBoxIcon = _icSearch,
      this.itemBackgroundColor = Colors.transparent,
      this.selectedItemBackgroundColor = Colors.black12,
      this.negativeButtonText = _cancel,
      this.negativeButtonTextColor = Colors.red,
      this.isAddItem = false,
      this.dismissWhenTapAddItem = true,
      this.onTapAddItem,
      this.addItemWidget})
      : selectedIds = null,
        prefixSeparator = _has,
        suffixSeparator = _comma,
        positiveButtonText = _ok,
        positiveButtonTextColor = Colors.black,
        isAllSelection = false,
        checkBoxActiveColor = Colors.black,
        onMultipleItemListener = null,
        _isMultiple = false,
        super(key: key);

  /// constructor for single multi dropdown
  const Dropdown.multiSelection(
      {Key? key,
      required this.list,
      required this.onMultipleItemListener,
      this.selectedIds,
      this.title = "",
      this.labelText = "",
      this.hintText = "",
      this.enabled = true,
      this.textAlign = TextAlign.start,
      this.border = const OutlineInputBorder(),
      this.decoration,
      this.searchBox = true,
      this.prefixSeparator = _has,
      this.suffixSeparator = _comma,
      this.searchBoxHintText = _searchHere,
      this.prefixSearchBoxIcon = _icSearch,
      this.itemBackgroundColor = Colors.transparent,
      this.selectedItemBackgroundColor = Colors.black12,
      this.negativeButtonText = _cancel,
      this.positiveButtonText = _ok,
      this.negativeButtonTextColor = Colors.red,
      this.positiveButtonTextColor = Colors.black,
      this.isAllSelection = false,
      this.checkBoxActiveColor = Colors.black,
      this.isAddItem = false,
      this.dismissWhenTapAddItem = true,
      this.onTapAddItem,
      this.addItemWidget})
      : selectedId = null,
        onSingleItemListener = null,
        _isMultiple = true,
        super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  final TextEditingController _conSelectedValue = TextEditingController();
  final TextEditingController _conSearchBox = TextEditingController();
  bool _isAllSelected = false;

  @override
  Widget build(BuildContext context) {
    return _dropdownView();
  }

  _dropdownView() {
    _initialSetup();
    return TextFormField(
      onTap: () {
        if (widget.enabled) {
          _openDropdown(
              context: context,
              list: widget.list,
              isMultiple: widget._isMultiple,
              title: ((widget.title.trim()).isNotEmpty)
                  ? widget.title
                  : widget.labelText);
        }
      },
      controller: _conSelectedValue,
      readOnly: true,
      textAlign: widget.textAlign,
      enabled: widget.enabled,
      decoration: widget.decoration ??
          InputDecoration(
              suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
              border: widget.border,
              labelText: widget.labelText,
              hintText: widget.hintText),
    );
  }

  /// initial setup of dropdown item selection
  _initialSetup() {
    String selectedValue = _getSelectedValue(list: widget.list);
    _conSelectedValue.text = selectedValue;
  }

  /// get selected value from dropdown item list
  String _getSelectedValue({required List<DropdownItem> list}) {
    List<String> ids = [];
    String value = widget.hintText;
    if (widget._isMultiple) {
      for (String selectedId in (widget.selectedIds ?? [])) {
        for (DropdownItem obj in widget.list) {
          if (obj.id.toLowerCase() == (selectedId).toLowerCase()) {
            if (ids.isEmpty) {
              ids.add(obj.id);
              value = "${widget.prefixSeparator}${obj.value}";
            } else {
              if (!ids.contains(obj.id)) {
                ids.add(obj.id);
                value =
                    "$value${widget.suffixSeparator} ${widget.prefixSeparator}${obj.value}";
              }
            }
          }
        }
      }
    } else {
      for (DropdownItem obj in widget.list) {
        if (obj.id.toLowerCase() == (widget.selectedId ?? "").toLowerCase()) {
          value = obj.value;
          break;
        }
      }
    }
    return value;
  }

  /// check selected dropdown item
  _checkAllSelection(List<DropdownItem> list) {
    if (widget.isAllSelection) {
      int selectedItemCount = 0;
      for (DropdownItem obj in list) {
        if (obj.selected) {
          selectedItemCount++;
        }
      }
      setState(() {
        if (selectedItemCount == list.length) {
          _isAllSelected = true;
        } else {
          _isAllSelected = false;
        }
      });
    }
  }

  /// open dropdown dialog
  _openDropdown(
      {required BuildContext context,
      required List<DropdownItem> list,
      required bool isMultiple,
      String title = ""}) {
    for (DropdownItem obj in list) {
      obj.selected = false;
    }
    if (isMultiple) {
      for (String selectedId in widget.selectedIds!) {
        for (DropdownItem obj in list) {
          if (obj.id.toLowerCase() == (selectedId).toLowerCase()) {
            obj.selected = true;
          }
        }
      }
    } else {
      for (DropdownItem obj in list) {
        if (obj.id.toLowerCase() == (widget.selectedId!).toLowerCase()) {
          obj.selected = true;
          break;
        }
      }
    }

    List<DropdownItem> fList = DropdownItem.cloneList(list);
    _conSearchBox.clear();
    _checkAllSelection(list);

    showDialog(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(builder: (buildContext, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                      visible: (title.trim().isNotEmpty),
                      child: Column(
                        children: [
                          Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: widget.searchBox || widget.isAllSelection,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible: widget.searchBox,
                                child: Expanded(
                                  child: TextFormField(
                                    controller: _conSearchBox,
                                    decoration: InputDecoration(
                                        hintText: widget.searchBoxHintText,
                                        prefixIcon:
                                            Icon(widget.prefixSearchBoxIcon)),
                                    onChanged: (value) {
                                      fList.clear();
                                      if ((value.trim()).isNotEmpty) {
                                        for (DropdownItem obj in list) {
                                          if (obj.value
                                              .toLowerCase()
                                              .contains(value.toLowerCase())) {
                                            fList.add(obj);
                                          }
                                        }
                                      } else {
                                        fList = DropdownItem.cloneList(list);
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: widget.isAllSelection,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          _isAllSelected = !_isAllSelected;
                                          for (DropdownItem obj in list) {
                                            obj.selected = _isAllSelected;
                                          }
                                          setState(() {});
                                        },
                                        child: Icon(_isAllSelected
                                            ? Icons.playlist_add_check_rounded
                                            : Icons.subject))
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: widget.isAddItem,
                            child: GestureDetector(
                              onTap: () {
                                if (widget.onTapAddItem != null) {
                                  if (widget.dismissWhenTapAddItem) {
                                    Navigator.pop(context);
                                  }
                                  widget.onTapAddItem!(
                                      _conSearchBox.text.toString());
                                }
                              },
                              child: widget.addItemWidget ?? _addItemWidget(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Visibility(
                        visible: fList.isNotEmpty,
                        replacement: const Center(child: Text("No data")),
                        child: ListView.builder(
                          key: const PageStorageKey<String>('list'),
                          shrinkWrap: true,
                          itemCount: fList.length,
                          itemBuilder: (context, index) {
                            return _dropdownItemView(context, isMultiple,
                                fList[index], fList, setState);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              widget.negativeButtonText,
                              style: TextStyle(
                                  color: widget.negativeButtonTextColor),
                            )),
                        Visibility(
                          visible: isMultiple,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 5),
                              TextButton(
                                  onPressed: () {
                                    widget.selectedIds!.clear();
                                    List<DropdownItem> selectedList = [];
                                    for (DropdownItem selectedObj in list) {
                                      if (selectedObj.selected) {
                                        widget.selectedIds!.add(selectedObj.id);
                                        selectedList.add(selectedObj);
                                      }
                                    }
                                    String selectedValue =
                                        _getSelectedValue(list: selectedList);
                                    _conSelectedValue.text = selectedValue;
                                    if (widget.onMultipleItemListener != null) {
                                      widget.onMultipleItemListener!(
                                          selectedList);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(
                                    widget.positiveButtonText,
                                    style: TextStyle(
                                        color: widget.positiveButtonTextColor),
                                  ))
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  /// dropdown item view
  _dropdownItemView(BuildContext context, bool isMultiple, DropdownItem obj,
      List<DropdownItem> list, StateSetter setState) {
    return InkWell(
        onTap: () {
          if (isMultiple) {
            setState(() {
              obj.selected = !obj.selected;
            });
            _checkAllSelection(list);
          } else {
            /*widget.selectedId = obj.id;*/
            _conSelectedValue.text = obj.value;
            if (widget.onSingleItemListener != null) {
              widget.onSingleItemListener!(obj);
            }
            Navigator.pop(context);
          }
        },
        child: Container(
          margin: const EdgeInsets.only(top: 2, bottom: 2),
          padding: EdgeInsets.all(isMultiple ? 10 : 20),
          decoration: BoxDecoration(
              color: obj.selected
                  ? widget.selectedItemBackgroundColor
                  : widget.itemBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              Visibility(
                visible: isMultiple,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                        activeColor: widget.checkBoxActiveColor,
                        value: obj.selected,
                        onChanged: (isChecked) {
                          setState(() {
                            obj.selected = !obj.selected;
                          });
                          _checkAllSelection(list);
                        }),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              Expanded(child: Text(obj.value)),
            ],
          ),
        ));
  }
}
