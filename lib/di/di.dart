import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_gallery/di/di.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: false,
  asExtension: false,
  usesNullSafety: true,
)
void configureInjection(String env) async {
  $initGetIt(getIt, environment: env);
}
