import 'package:mobx/mobx.dart';
import 'package:photo_gallery/configs/constants.dart';
import 'package:photo_gallery/features/authentication/domain/entities/user.dart';
import 'package:photo_gallery/features/core/data/datasources/cache.dart';

part 'app_store.g.dart';

AppStore appStore = AppStore();

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  bool hasInternetConnection = false;

  @observable
  User? currentUser;

  @observable
  bool isUserLoggedIn = false;

  @action
  Future<void> saveUser(User value) async {
    currentUser = value;
    isUserLoggedIn = true;
    Cache.saveData(key: userCacheKey, value: value.toJson());
  }

  @action
  Future<void> deleteUser() async {
    currentUser = null;
    isUserLoggedIn = false;
    Cache.removeData(userCacheKey);
  }
}
