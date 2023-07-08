import 'package:flutter/material.dart';
import 'package:flutter_tutorial/core/contexts/auth_context.dart';
import 'package:flutter_tutorial/modules/auth/models/create_user.dart';
import 'package:flutter_tutorial/modules/auth/services/create_user.dart';
import 'package:flutter_tutorial/modules/auth/services/loginUser.dart';
import 'package:flutter_tutorial/modules/auth/validators/confirmpassword.dart';
import 'package:flutter_tutorial/modules/auth/validators/email.dart';
import 'package:flutter_tutorial/modules/auth/validators/password.dart';
import 'package:flutter_tutorial/modules/auth/validators/username.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // ValueNotifier for server-side validation errors
  final ValueNotifier<String?> _usernameErrorNotifier =
      ValueNotifier<String?>(null);
  final ValueNotifier<String?> _emailErrorNotifier =
      ValueNotifier<String?>(null);

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameErrorNotifier.dispose(); // Don't forget to dispose
    _emailErrorNotifier.dispose(); // Don't forget to dispose
    super.dispose();
  }

  void _handleServerError(dynamic error) {
    if (error.response["data"]["email"] != null) {
      _emailErrorNotifier.value = 'Email already exists. Please try again.';
    }
    if (error.response["data"]["username"] != null) {
      _usernameErrorNotifier.value =
          'Username already exists. Please try again.';
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthContext authContext = Provider.of<AuthContext>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Register',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ValueListenableBuilder(
                    valueListenable: _usernameErrorNotifier,
                    builder: (context, String? serverError, _) => TextFormField(
                      controller: _usernameController,
                      onChanged: (value) {
                        _usernameErrorNotifier.value = null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                        errorText:
                            serverError, // Show server error if it exists
                      ),
                      validator: usernameValidator,
                    ),
                  ),
                  SizedBox(height: 20),
                  ValueListenableBuilder(
                    valueListenable: _emailErrorNotifier,
                    builder: (context, String? serverError, _) => TextFormField(
                      controller: _emailController,
                      onChanged: (value) {
                        _emailErrorNotifier.value = null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        errorText:
                            serverError, // Show server error if it exists
                      ),
                      validator: emailValidator,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: passwordValidator,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => confirmPasswordValidator(
                            value,
                            _passwordController.text,
                          )),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _emailErrorNotifier.value = null;
                      _usernameErrorNotifier.value = null;
                      if (_formKey.currentState!.validate()) {
                        final user = CreateUser(
                          username:
                              _usernameController.text.trim().toLowerCase(),
                          email: _emailController.text.trim().toLowerCase(),
                          password: _passwordController.text.trim(),
                          confirmPassword:
                              _confirmPasswordController.text.trim(),
                        );

                        (() async {
                          try {
                            final metaUser = await createUserService(
                                user, _handleServerError);

                            if (metaUser != null && context.mounted) {
                              authContext.setMetaUser(metaUser);
                              context.go('/list-chats');
                            }
                          } catch (error) {
                            print(error);
                          }
                        })();
                      }
                    },
                    child: const Text('Register'),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          context.go('/');
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
