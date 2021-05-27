import 'package:ejara/pages/register/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Successfull Registration')),
            );
        }
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: _buildHeader()
            ),
            _buildBody(),
          ],
        )
      )
    );
  }

  _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 32.0),
      decoration: BoxDecoration(
        color: Colors.blue[900],
        image: DecorationImage(
          image: AssetImage("assets/images/ejara_bg.png"),
          alignment: Alignment(1.0, -1.0)
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Image(
              image: AssetImage('assets/images/ejara_logo.png'),
            )  
          ),
          Container(
            child: Text(
              "Create an account",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold
              ),
            )
          )
        ],
      ),
    );
  }

  _buildBody() { 
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _FormError(),
            _UsernameInput(),
            _EmailInput(),
            _PhoneNumberInput(),
            _RegisterButton()          
          ],
        ),
      )
    );
  }
  
}

class _FormError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => (previous.errorReason != current.errorReason),
      builder: (context, state) {
        return state.status == FormzStatus.submissionFailure
          ? Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.red,
                
                borderRadius: BorderRadius.all(Radius.circular(40.0))
              ),
              child: Center(
                child: Text(
                  "${state.errorReason}",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            )
          : Container();
      }
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (username) => context.read<RegisterCubit>().usernameChanged(username),
                decoration: InputDecoration(
                  labelText: "Username"
                ),
              )
            ]
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (email) => context.read<RegisterCubit>().emailChanged(email),
                decoration: InputDecoration(
                  labelText: "Email"
                ),
              )
            ]
          ),
        );
      },
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                keyboardType: TextInputType.phone,
                onChanged: (phoneNumber) => context.read<RegisterCubit>().phoneNumberChanged(phoneNumber),
                decoration: InputDecoration(
                  labelText: "Phone number"
                ),
              )
            ]
          ),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                semanticsLabel: 'Linear progress indicator',
              )
            : Container(
              margin: EdgeInsets.symmetric(vertical: 15.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )
                    )
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      "Next",
                      textAlign: TextAlign.center,
                    )
                  ),
                  onPressed: state.status.isValidated
                    ? () => context.read<RegisterCubit>().registerFormSubmitted()
                    : null,
                ),
              )
            );
      },
    );
  }
}
