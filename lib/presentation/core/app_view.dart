import 'package:flutter/material.dart';

import '../../../config/enum/app_state.dart';
import '../bloc/core_bloc.dart';
import 'presentation/splash/splash_page.dart';

class AppView extends StatefulWidget {
  final CoreState state;
  final Widget? child;
  const AppView({
    Key? key,
    required this.state,
    this.child,
  }) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return AppStateHandler(
      onLoading: () => const SplashPage(),
      onBanned: () => const _Body('Banned Page'),
      onClosed: () => const _Body('Closed Page'),
      onFailed: () => const _Body('Failed Page'),
      onForceUpdate: () => const _Body('Force Update Page'),
      onLocked: () => const _Body('Locked Page'),
      onReady: () => widget.child ?? const SplashPage(),
    ).handle(widget.state.appState);
  }
}

class _Body extends StatelessWidget {
  final String text;
  const _Body(this.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(text),
      ),
    );
  }
}
