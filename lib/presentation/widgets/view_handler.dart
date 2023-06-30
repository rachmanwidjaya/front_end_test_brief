// import 'package:forex_imf_tes/utils/extensions/centext_extension.dart';
// import 'package:flutter/material.dart';

// import '../../config/enum/view_state.dart';

// import 'failed_widget.dart';
// import 'loading_widget.dart';

// class ViewHandler extends StatelessWidget {
//   final Widget? child;
//   final Future<void> Function()? onReload;
//   const ViewHandler({
//     Key? key,
//     this.child,
//     this.onReload,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     switch (state.viewState) {
//       case ViewState.loading:
//         return const Center(
//           child: LoadingWidget(),
//         );
//       case ViewState.failed:
//         return FailedWidget(
//           message: state.message,
//           texColor: context.textColor,
//           onReload: () async => onReload,
//         );
//       case ViewState.success:
//         return child ?? Container();
//       default:
//         return Container();
//     }
//   }
// }
