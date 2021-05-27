import 'package:ejara/bloc/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }
  
  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Home'),
        toolbarOpacity: 0.0,
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested()),
          )
        ],
      ),
      body: Container(
        child: Text("You are registered"),
      )
    );
  }
}
