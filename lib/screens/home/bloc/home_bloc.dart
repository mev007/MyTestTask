import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_developer_test_task/models/user_model.dart';
import 'package:mobile_developer_test_task/services/user_api.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  bool isButtonEnabled = false;
  bool isLoading = false;
  String resultLoaded = '';

  HomeBloc() : super(HomeInitial()) {
    on<ChangeFieldEvent>((event, emit) {
      isButtonEnabled = event.user.name.isNotEmpty &&
          EmailValidator.validate(event.user.email) &&
          event.user.message.isNotEmpty;
      emit(ChangeFieldState());
    });
    on<SendUserEvent>((event, emit) async {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading = true;
      emit(LoadingState());
      final result = await UserApi().sendUser(event.user);
      isLoading = false;
      emit(LoadedState(result));
    });
  }
}
