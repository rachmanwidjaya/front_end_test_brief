enum AppState {
  loading,
  ready,
  failed,
  locked,
  closed,
  forceUpdate,
  banned,
}

class AppStateHandler<T> {
  T Function() onLoading;
  T Function() onReady;
  T Function() onFailed;
  T Function() onLocked;
  T Function() onClosed;
  T Function() onForceUpdate;
  T Function() onBanned;

  AppStateHandler({
    required this.onLoading,
    required this.onReady,
    required this.onFailed,
    required this.onLocked,
    required this.onClosed,
    required this.onForceUpdate,
    required this.onBanned,
  });

  T handle(AppState state) {
    switch (state) {
      case AppState.loading:
        return onLoading();
      case AppState.ready:
        return onReady();
      case AppState.failed:
        return onFailed();
      case AppState.locked:
        return onLocked();
      case AppState.closed:
        return onClosed();
      case AppState.forceUpdate:
        return onForceUpdate();
      case AppState.banned:
        return onBanned();
    }
  }
}
