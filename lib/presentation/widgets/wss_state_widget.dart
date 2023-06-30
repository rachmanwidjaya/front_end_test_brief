import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_imf_tes/utils/extensions/context_extension.dart';

import '../bloc/wss_bloc.dart';

class WssStateWidget extends StatelessWidget {
  const WssStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WssBloc, WssState>(
      builder: (context, state) => state is WssFailedState
          ? Container(
              width: context.sizeWidth,
              color: context.primaryColor.withOpacity(0.5),
              child: Center(
                child: Text(
                  state.message,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
