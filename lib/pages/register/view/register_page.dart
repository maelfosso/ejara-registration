import 'package:ejara/pages/register/cubit/register_cubit.dart';
import 'package:ejara/pages/register/view/register_form.dart';
import 'package:ejara/repositories/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Sign Up (Client)",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        
      ),
      body: SafeArea( 
        child: BlocProvider<RegisterCubit>(
          create: (_) => RegisterCubit(context.read<AuthenticationRepository>()),
          child: const RegisterForm(),
        ),
      )
    );
  }
}
