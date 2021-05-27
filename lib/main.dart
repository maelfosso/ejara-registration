import 'package:ejara/pages/register/view/register_page.dart';
import 'package:ejara/repositories/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
  ));
}

class App extends StatelessWidget {
  
  App({
    Key? key,
    required AuthenticationRepository authenticationRepository
  }): _authenticationRepository = authenticationRepository,
      super(key: key);

  final AuthenticationRepository _authenticationRepository;
  
  @override
  Widget build(BuildContext context) {
   
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: AppView()
    );
  }
}


class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Ejara',
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      home: RegisterPage(),
    );
  }
}
