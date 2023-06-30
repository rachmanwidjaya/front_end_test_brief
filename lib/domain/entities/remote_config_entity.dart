import '../../config/enum/app_state.dart';

class RemoteConfigEntity {
  bool appUpdate;
  bool forceUpdate;
  String updateLink;
  String appServer;
  bool appOpen;
  bool versionValid;
  int appVersion;
  RemoteConfigEntity({
    this.appOpen = true,
    this.appServer = '',
    this.appUpdate = false,
    this.forceUpdate = false,
    this.updateLink = '',
    this.appVersion = 1,
    this.versionValid = true,
  });
  RemoteConfigEntity copyWith({
    bool? appUpdate,
    bool? forceUpdate,
    String? updateLink,
    String? appServer,
    bool? appOpen,
    bool? versionValid,
    int? appVersion,
  }) {
    return RemoteConfigEntity(
      appUpdate: appUpdate ?? this.appUpdate,
      forceUpdate: forceUpdate ?? this.forceUpdate,
      updateLink: updateLink ?? this.updateLink,
      appServer: appServer ?? this.appServer,
      appOpen: appOpen ?? this.appOpen,
      versionValid: versionValid ?? this.versionValid,
      appVersion: appVersion ?? this.appVersion,
    );
  }

  AppState get toAppState {
    if (!appOpen) {
      return AppState.closed;
    } else if (forceUpdate) {
      return AppState.forceUpdate;
    } else if (!versionValid) {
      return AppState.locked;
    } else {
      return AppState.ready;
    }
  }
}
