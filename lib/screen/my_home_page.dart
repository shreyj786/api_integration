import 'package:api_integration/bloc/user_bloc.dart';
import 'package:api_integration/bloc/user_event.dart';
import 'package:api_integration/bloc/user_state.dart';
import 'package:api_integration/model/user_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<UserBloc>(context).add(GetUserEvent());
              },
              child: const Text('Hit API again'),
            ),
            Expanded(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is GetUserState) {
                    return _handleUserResponseList(state);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ));
  }

  Widget _handleUserResponseList(state) {
    var _userState = state as GetUserState;

    switch (_userState.status) {
      case ApiStatus.loading:
        return const Center(child: CircularProgressIndicator());

      case ApiStatus.success:
        if (state.response != null) {
          return ListView.builder(
            itemCount: state.response!.length,
            itemBuilder: (BuildContext context, int index) {
              UserResponse res = state.response![index];

              return ListTile(
                title: Text(res.name!,
                    style: Theme.of(context).textTheme.headline5),
                subtitle: Text(res.company!.name!),
                leading: Text('${index + 1}'),
              );
            },
          );
        } else {
          return const Center(child: Text('No data avaiable at this time'));
        }

      case ApiStatus.failed:
        return const Center(child: Text('No data avaiable at this time'));
    }
  }
}
