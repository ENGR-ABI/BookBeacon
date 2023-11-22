import 'package:bookbeacon/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../app/layout/layout_controller.dart';
import 'dialog/custom_dialog.dart';

class ItemsSelector extends StatefulWidget {
  const ItemsSelector({
    super.key,
    this.titleIcon,
    required this.title,
    required this.items,
    this.initialItems,
    this.onSingleSelect,
    this.alignment = Alignment.center,
    this.onConfirmText = 'Confirm',
    this.onCancelText = 'Cancel',
    this.onMultipleSelect,
    this.searchable = true,
    this.constraints = const BoxConstraints(minWidth: 380.0, maxHeight: 400),
  });
  final Widget? titleIcon;
  final String title;
  final List<ItemModel>? initialItems;
  final List<ItemModel> items;
  final Alignment alignment;
  final ValueChanged<ItemModel?>? onSingleSelect;
  final bool searchable;
  final ValueChanged<List<ItemModel>?>? onMultipleSelect;
  final String onCancelText;
  final String onConfirmText;
  final BoxConstraints constraints;

  @override
  State<ItemsSelector> createState() => _ItemsSelectorState();
}

class _ItemsSelectorState extends State<ItemsSelector> {
  final List<ItemModel> selected = [];

  final List<ItemModel> currentItems = [];

  @override
  void initState() {
    fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      contentPadding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
      alignment: widget.alignment,
      constraints: widget.constraints,
      insetPadding: getInsetPadding(context),
      titlePadding: EdgeInsets.zero,
      titleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 18,
          ),
      title: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Row(
              children: [
                if (widget.titleIcon != null) ...[
                  widget.titleIcon!,
                  4.horizontalSpace,
                ],
                Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (widget.searchable) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 18, 12, 0),
              child: TextFormField(
                onChanged: searchAndRebuild,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: 'Search',
                  hintText: 'Start typing to search',
                ),
              ),
            ),
            const Divider(),
          ],
        ],
      ),
      children: [
        Column(
          children: currentItems
              .map(
                (item) => ListTile(
                  leading: item.leading,
                  title: Text(item.item),
                  selected: selected.contains(item),
                  trailing: selected.contains(item)
                      ? const Icon(Icons.check)
                      : item.trailing,
                  onTap: () => (widget.onSingleSelect != null)
                      ? _selectItem(item)
                      : toggleSelection(item),
                ),
              )
              .toList(),
        ),
        if (widget.onMultipleSelect != null)
          Container(
            margin: const EdgeInsets.only(top: 12),
            color:Globals. colorScheme.surface,
            child: SimpleDialogOption(
              padding: const EdgeInsets.all(12).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: Get.back, child: Text(widget.onCancelText)),
                  4.horizontalSpace,
                  ElevatedButton(
                    onPressed: _finishSelection,
                    child: Text(widget.onConfirmText),
                  )
                ],
              ),
            ),
          )
      ],
    );
  }

  _selectItem(ItemModel item) {
    toggleSelection(item);
    widget.onSingleSelect!(item);
    Get.back();
  }

  toggleSelection(ItemModel item) {
    if (selected.contains(item)) {
      selected.removeWhere((element) => element == item);
    } else {
      selected.add(item);
    }
    setState(() {});
  }

  void _finishSelection() {
    if (selected.isEmpty) {
      // Show Info that nothing has been selected
      return;
    }
    // return the the sekected through passed callback
    widget.onMultipleSelect!(selected);
    Get.back();
  }

  EdgeInsets getInsetPadding(BuildContext context) {
    if (widget.alignment == Alignment.topLeft ||
        widget.alignment == Alignment.bottomLeft ||
        widget.alignment == Alignment.centerLeft) {
      return LayoutController.inst.isPhone(context)
          ? const EdgeInsets.all(24.0)
          : const EdgeInsets.only(left: 40);
    } else if (widget.alignment == Alignment.topRight ||
        widget.alignment == Alignment.bottomRight ||
        widget.alignment == Alignment.centerRight) {
      return LayoutController.inst.isPhone(context)
          ? const EdgeInsets.all(24.0)
          : const EdgeInsets.only(right: 40);
    } else {
      return const EdgeInsets.all(24.0);
    }
  }

  void searchAndRebuild(String value) {
    if (value.isEmpty) {
      currentItems.clear();
      currentItems.addAll(widget.items);
    } else {
      final results = widget.items
          .where(
              (item) => item.item.toLowerCase().startsWith(value.toLowerCase()))
          .toList();
      currentItems.clear();
      currentItems.addAll(results);
    }
    setState(() {});
  }

  fetchItems() async {
    currentItems.clear();
    currentItems.addAll(widget.items);
    if (widget.initialItems != null) {
      for (var i = 0; i < widget.initialItems!.length; i++) {
        var initial = widget.items
            .where((element) => element.id == widget.initialItems![i].id)
            .first;
        selected.add(initial);
      }
    }
    setState(() {});
  }
}

class ItemModel {
  final String id;
  final String item;
  final Widget? leading;
  final Widget? trailing;
  ItemModel({
    required this.item,
    this.leading,
    this.trailing,
    required this.id,
  });
}
