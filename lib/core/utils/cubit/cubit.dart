import 'states.dart';
import 'package:flutter_applicaion/core/utils/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppState> {

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  
  bool isDark = false;
  void changeAppMode({bool? fromShared}){
    if (fromShared!=null){
      isDark = fromShared;
      emit(AppChangeMode());
    }
    else{
      isDark = !isDark ;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeMode());
      });

    }

  }


}

  


