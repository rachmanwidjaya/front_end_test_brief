import 'package:get_storage/get_storage.dart';

class LocalConfig {
  static final _singleton = LocalConfig();
  static LocalConfig get instance => _singleton;
  final _box = GetStorage();
  final String _key = 'berita';

  bool get darkTheme => _box.read('${_key}darkTheme') ?? false;
  set darkTheme(bool value) => _box.write('${_key}darkTheme', value);

  String? get token => _box.read('${_key}token');
  set token(String? value) => _box.write('${_key}token', value);
}
