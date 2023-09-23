
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SplashState {}
abstract class SplashEvent{}

class NavigateToHomeScreenEvent extends SplashEvent{}
class OnLoadSplashScreenState extends SplashState{}

class NavigateToHomeScreenState extends SplashState{}

class SplashBloc extends Bloc<SplashEvent, SplashState>{

  SplashBloc() : super(OnLoadSplashScreenState()){
    Future.delayed(const Duration(seconds: 3), () {
         add(NavigateToHomeScreenEvent());
    });


    on<NavigateToHomeScreenEvent>((_, emit) {
      emit(NavigateToHomeScreenState());
    });
    
  }
}