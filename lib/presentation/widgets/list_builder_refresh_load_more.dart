// import 'package:flutter/material.dart';
// import 'package:forex_imf_tes/utils/extensions/centext_extension.dart';

// import '../../core/state/controller_state_load_more.dart';
// import 'loading_widget.dart';

// class ListBuilderRefreshLoadMore extends StatefulWidget {
//   final ControllerStateLoadMore state;

//   final List<Widget> items;
//   final Future<void> Function()? onRefresh;
//   final Future<void> Function()? onLoadMore;
//   const ListBuilderRefreshLoadMore({
//     super.key,
//     this.onRefresh,
//     this.onLoadMore,
//     this.items = const [],
//     required this.state,
//   });

//   @override
//   State<ListBuilderRefreshLoadMore> createState() => _RefreshLoadMoreState();
// }

// class _RefreshLoadMoreState extends State<ListBuilderRefreshLoadMore> {
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//       GlobalKey<RefreshIndicatorState>();
//   final ScrollController _scrollController = ScrollController();
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(
//       () async {
//         if (_scrollController.position.pixels >=
//             _scrollController.position.maxScrollExtent) {
//           if (widget.state.loadComplete) {
//             return;
//           }
//           if (widget.onLoadMore != null) {
//             _isLoading = true;
//             if (!(widget.state.isLastPage == true)) {
//               widget.onLoadMore != null ? await widget.onLoadMore!() : {};
//             }
//             _isLoading = false;
//           }
//         }
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       backgroundColor: context.cardColor,
//       color: context.textColor,
//       key: _refreshIndicatorKey,
//       onRefresh: () async {
//         if (widget.state.loadComplete == true) return;
//         widget.onRefresh != null ? await widget.onRefresh!() : {};
//       },
//       child: Stack(
//         children: [
//           ListView.builder(
//             controller: _scrollController,
//             itemCount: widget.items.length,
//             itemBuilder: (context, index) => widget.items[index],
//           ),
//           _isLoading
//               ? Positioned(
//                   bottom: 0,
//                   child: SizedBox(
//                     width: context.sizeWidth,
//                     child: const Center(
//                       child: LoadingWidget(),
//                     ),
//                   ),
//                 )
//               : const SizedBox(),
//         ],
//       ),
//     );
//   }
// }
