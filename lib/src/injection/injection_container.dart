
import 'package:get_it/get_it.dart';


final injector = GetIt.instance;

class InjectorFile {
  Future<void> injectorFile() async {
    _coreService;
    _weightService;
  }
}

//Core Service
void get _coreService async { 

  // injector.registerSingleton<______>(__);

}

// weight Service
void get _weightService {
  // injector.registerFactory<_____>(
  //   () => ___(
  //     injector<___>(),
  //   ),
  // );
}
