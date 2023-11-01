import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  Future<bool> saveId(String? id) async {
    final storage = GetStorage();
    await storage.write(CacheManagerId.ID.toString(), id);
    return true;
  }

  String? getId() {
    final storage = GetStorage();
    return storage.read(CacheManagerId.ID.toString());
  }

  Future<bool> removeId() async {
    final storage = GetStorage();
    await storage.remove(CacheManagerId.ID.toString());
    return true;
  }

  Future<bool> saveNumber(String? num) async {
    final storage = GetStorage();
    await storage.write(CacheManagerNumber.NUM.toString(), num);
    return true;
  }

  String? getNumber() {
    final storage = GetStorage();
    return storage.read(CacheManagerNumber.NUM.toString());
  }

  Future<bool> removeNumber() async {
    final storage = GetStorage();
    await storage.remove(CacheManagerNumber.NUM.toString());
    return true;
  }

  Future<bool> saveToken(String? token) async {
    final storage = GetStorage();
    await storage.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  String? getToken() {
    final storage = GetStorage();
    return storage.read(CacheManagerKey.TOKEN.toString());
  }

  Future<bool> removeToken() async {
    final storage = GetStorage();
    await storage.remove(CacheManagerKey.TOKEN.toString());
    return true;
  }

  Future<bool> saveIsLogin(bool value) async {
    final storage = GetStorage();
    await storage.write(CacheManagerRun.IS_FIRST_RUN.toString(), value);
    return true;
  }

  bool getIsLogin() {
    final storage = GetStorage();
    return storage.read(CacheManagerRun.IS_FIRST_RUN.toString());
  }

  Future<bool> saveIsLoginNull(bool b) async {
    final storage = GetStorage();
    await storage.writeIfNull(CacheManagerRun.IS_FIRST_RUN.toString(), b);
    return true;
  }

  Future<bool> saveContactLength(int? size) async {
    final storage = GetStorage();
    await storage.write(
        CacheMangerContactLength.CONTACT_LENGTH.toString(), size);
    return true;
  }

  int? getContactLength() {
    final storage = GetStorage();
    return storage.read(CacheMangerContactLength.CONTACT_LENGTH.toString());
  }

  Future<bool> isNullContactLength(int? size) async{
    final storage=GetStorage();
    await storage.writeIfNull(CacheMangerContactLength.CONTACT_LENGTH.toString(),size);
    return true;
  }
}

enum CacheManagerId { ID }
enum CacheManagerNumber { NUM }
enum CacheManagerKey { TOKEN }
enum CacheManagerRun { IS_FIRST_RUN }
enum CacheMangerContactLength { CONTACT_LENGTH }
