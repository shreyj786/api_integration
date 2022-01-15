import 'package:api_integration/bloc/user_bloc.dart';
import 'package:api_integration/model/user_response_model.dart';

abstract class UserState {
  UserState([List state = const []]) : super();
}

class UserInitialState extends UserState {
  @override
  List<Object> get props => [];
}

class GetUserState extends UserState {
  ApiStatus status;
  List<UserResponse>? response;

  String? error;
  GetUserState({required this.status, this.response, this.error})
      : super([status, response, error]);
}
