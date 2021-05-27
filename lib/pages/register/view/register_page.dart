import 'package:ejara/pages/register/cubit/register_cubit.dart';
import 'package:ejara/pages/register/view/register_form.dart';
import 'package:ejara/repositories/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
        // title: Text(
        //   "Register",
        //   style: TextStyle(
        //     color: Colors.black
        //   ),
        // ),
        
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
