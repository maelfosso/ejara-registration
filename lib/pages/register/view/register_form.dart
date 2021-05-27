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
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            _FormError(),
            _buildBody(),
          ],
        )
      )
    );
  }


  _buildBody() { 
    return Expanded(
      flex: 1,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              Text(
                "Name",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                onChanged: (username) => context.read<RegisterCubit>().usernameChanged(username),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF7F8F9),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 0.0
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1.0
                    )
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                  isDense: true,
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
              Text(
                "Email",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                onChanged: (email) => context.read<RegisterCubit>().emailChanged(email),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF7F8F9),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 0.0
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1.0
                    )
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                  isDense: true,
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
              Text(
                "PhoneNumber number",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                keyboardType: TextInputType.phone,
                onChanged: (phoneNumber) => context.read<RegisterCubit>().phoneNumberChanged(phoneNumber),
                decoration: InputDecoration(
                  errorText: state.phoneNumber.invalid ? 'invalid phoneNumber number' : null,
                  filled: true,
                  fillColor: Color(0xFFF7F8F9),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 0.0
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1.0
                    )
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
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
                      "Sign Up",
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
