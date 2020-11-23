import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/viewmodels/auth_view_model.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/widgets/in_progress_message.dart';
import 'package:ulusoyapps_flutter/resources/dimens/app_dimens.dart';

class LoginScreen extends StatelessWidget {

  final VoidCallback onLogin;

  const LoginScreen({Key key, this.onLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text('Login Screen'),),
      body: Center(
        child: authViewModel.logingIn
            ? InProgressMessage(progressName: "Login", screenName: "LoginScreen")
            : ElevatedButton(
                onPressed: () async {
                  final result = await authViewModel.login();
                  if (result == true) onLogin();
                },
                child: Padding(
                  padding: EdgeInsets.all(AppDimens.SIZE_SPACING_MEDIUM),
                  child: Text('Log in'),
                ),
              ),
      ),
    );
  }
}
