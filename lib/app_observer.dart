import 'package:bloc/bloc.dart';
// import 'package:flutter/foundation.dart';

// отслеживание состояния и типа провайдера
class AppObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
    // if (kDebugMode) {
    //   print('${bloc.runtimeType} $change');
    // }
  }
}
