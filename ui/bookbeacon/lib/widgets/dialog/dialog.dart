import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/globals.dart';

class IqraaDialog extends StatelessWidget {
  const IqraaDialog({
    super.key,
    this.titleIcon,
    this.title,
    this.alignment = Alignment.center,
    this.onConfirmText = 'Confirm',
    this.onCancelText = 'Cancel',
    this.constraints = const BoxConstraints(
      minWidth: 280.0,
      maxHeight: 500,
    ),
    required this.contents,
    this.contentPadding = const EdgeInsets.all(20.0),
    this.onConfirm,
    this.onCancel,
  });
  final Widget? titleIcon;
  final String? title;
  final Alignment alignment;
  final String onCancelText;
  final String onConfirmText;
  final BoxConstraints constraints;
  final List<Widget> contents;
  final EdgeInsetsGeometry contentPadding;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      contentPadding: EdgeInsets.zero,
      alignment: alignment,
      //constraints: constraints,
      //insetPadding: getInsetPadding(context),
      titlePadding: EdgeInsets.zero,
      titleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Globals.colorScheme.onPrimary,
            fontSize: 18,
          ),
      title: Column(
        children: [
          if (title != null)
            Container(
              padding: const EdgeInsets.all(12).r,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Row(
                children: [
                  if (titleIcon != null) ...[
                    titleIcon!,
                    4.horizontalSpace,
                  ],
                  Text(
                    title!,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
        ],
      ),
      children: [
        Padding(
          padding: contentPadding,
          child: Column(
            children: contents,
          ),
        ),
        if (onConfirm != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onCancel ?? Get.back,
                  child: Text(onCancelText),
                ),
                4.horizontalSpace,
                ElevatedButton(
                  onPressed: onConfirm,
                  child: Text(onConfirmText),
                ),
              ],
            ),
          )
        ],
      ],
    );
  }
}
