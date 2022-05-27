import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobx/mobx.dart';
import 'package:photo_gallery/configs/constants.dart';
import 'package:photo_gallery/features/authentication/domain/entities/user.dart';
import 'package:photo_gallery/features/core/data/datasources/cache.dart';

part 'app_store.g.dart';

AppStore appStore = AppStore();

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  bool hasInternetConnection = true;

  @observable
  bool isUserLoggedIn = false;

  @observable
  User? user;

  Future<void> saveUser(User value) async {
    user = value;
    isUserLoggedIn = true;
    await Cache.saveData(key: userCacheKey, value: value);
  }

  Future<void> deleteUser(User value) async {
    user = null;
    isUserLoggedIn = false;
    await Cache.removeData(userCacheKey);
  }

  Future<void> updateInternetConnection() async {
    hasInternetConnection = await InternetConnectionChecker().hasConnection;
  }
}
