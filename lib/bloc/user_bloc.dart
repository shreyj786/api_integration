import 'package:api_integration/bloc/user_event.dart';
import 'package:api_integration/bloc/user_state.dart';
import 'package:api_integration/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ApiStatus {
  success,
  failed,
  loading,
}

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(UserState intialState) : super(intialState);
  final UserRespository userRepo = UserRespository();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is GetUserEvent) {
      yield GetUserState(status: ApiStatus.loading);

      try {
        final userResponse = await userRepo.getUserList();
        yield GetUserState(status: ApiStatus.success, response: userResponse);
      } catch (e) {
        debugPrint('user catch $e');
        yield GetUserState(status: ApiStatus.failed, error: e.toString());
      }
    }
  }
}
