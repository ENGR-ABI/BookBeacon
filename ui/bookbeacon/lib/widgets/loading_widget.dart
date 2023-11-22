import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';

import 'dialog/custom_dialog.dart';


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.dismissible = false,
    this.loadingText = 'Loading...',
    this.value,
  });
  final String? loadingText;
  final RxDouble? value;
  final bool dismissible;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => dismissible,
      child: CustomDialog(
        contentPadding: const EdgeInsets.all(12),
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox.square(
                dimension: 30,
                child: CircularProgressIndicator(
                  value: value?.value,
                ),
              ),
              12.horizontalSpaceRadius,
              if (loadingText != null)
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      loadingText!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
