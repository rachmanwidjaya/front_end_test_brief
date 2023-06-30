import 'package:flutter/material.dart';
import 'package:forex_imf_tes/utils/extensions/context_extension.dart';

class FailedWidget extends StatelessWidget {
  final String? message;
  final Future<void> Function()? onReload;
  final Color? texColor;
  const FailedWidget({
    Key? key,
    required this.message,
    this.onReload,
    this.texColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$message',
            style: context.textTheme.bodyMedium,
          ),
          const Padding(padding: EdgeInsets.all(4)),
          ElevatedButton(
            onPressed: () async => onReload != null ? await onReload!() : {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(context.primaryColor),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(left: 32, right: 32),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.replay_outlined,
                    color: Colors.white,
                  ),
                  const Padding(padding: EdgeInsets.only(left: 4)),
                  Text(
                    'Reload',
                    style: context.textTheme.bodyMedium
                        ?.apply(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
