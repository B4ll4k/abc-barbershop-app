import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../models/http_exception.dart';
import '../providers/user_provider.dart';
import '../widgets/fonts/palatte.dart';

enum AuthMode { logIn, signUp }

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'firstName': null,
    'lastName': null,
    'phoneNum': null,
    'email': null,
    'password': null,
  };

  bool _isLoading = false;
  AuthMode _authMode = AuthMode.logIn;
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      child: const Center(
                        child: Text(
                          'ABC',
                          style: kHeading,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _authMode == AuthMode.signUp ? 70 : 100,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _authMode == AuthMode.signUp
                                    ? _buildFirstNameTextField()
                                    : Container(),
                                _authMode == AuthMode.signUp
                                    ? _buildLastNameTextField()
                                    : Container(),
                                _authMode == AuthMode.signUp
                                    ? _buildPhoneNoTextField()
                                    : Container(),
                                _buildEmailTextField(),
                                _buildPasswordTextField(),
                                _authMode == AuthMode.signUp
                                    ? _buildConfirmPasswordTextField()
                                    : Container(),
                                // const Text(
                                //   'Forgot Password?',
                                //   style: kBodyText,
                                // ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height:
                                      _authMode == AuthMode.signUp ? 45 : 100,
                                ),
                                _authBtn(),
                                SizedBox(
                                  height:
                                      _authMode == AuthMode.signUp ? 60 : 80,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (_authMode == AuthMode.logIn) {
                                        _authMode = AuthMode.signUp;
                                      } else {
                                        _authMode = AuthMode.logIn;
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                          color: Colors.white, width: 1),
                                    )),
                                    child: Text(
                                      _authMode == AuthMode.logIn
                                          ? 'Create New Account'
                                          : "Already have an account?",
                                      style: kBodyText,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundImage() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.black, Colors.black26],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/hair_clipper_scissor.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: "Password",
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                FontAwesomeIcons.lock,
                color: Colors.white,
                size: 30,
              ),
            ),
            hintStyle: kBodyText,
          ),
          obscureText: true,
          style: kBodyText,
          textInputAction: TextInputAction.done,
          validator: (String? value) {
            if (value!.isEmpty || value.length < 6) {
              return 'Password invalid';
            }
            return null;
          },
          onSaved: (String? value) {
            _formData["password"] = value;
          },
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: "Confirm Password",
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                FontAwesomeIcons.lock,
                color: Colors.white,
                size: 30,
              ),
            ),
            hintStyle: kBodyText,
          ),
          obscureText: true,
          style: kBodyText,
          textInputAction: TextInputAction.done,
          validator: (String? value) {
            if (_passwordController.text != value) {
              return 'Password does not match!';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: "Email",
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                FontAwesomeIcons.solidEnvelope,
                color: Colors.white,
                size: 30,
              ),
            ),
            hintStyle: kBodyText,
          ),
          style: kBodyText,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null ||
                !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                    .hasMatch(value) ||
                value.isEmpty) {
              return 'Invalid email!';
            }
            return null;
          },
          onSaved: (value) {
            _formData['email'] = value!;
          },
        ),
      ),
    );
  }

  Widget _buildFirstNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: "First Name",
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                FontAwesomeIcons.user,
                color: Colors.white,
                size: 30,
              ),
            ),
            hintStyle: kBodyText,
          ),
          style: kBodyText,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          validator: (String? value) {
            if (value!.isEmpty || value.length < 3) {
              return 'name is invalid';
            }
            return null;
          },
          onSaved: (String? value) {
            _formData["firstName"] = value;
          },
        ),
      ),
    );
  }

  Widget _buildLastNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: "Last Name",
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                FontAwesomeIcons.user,
                color: Colors.white,
                size: 30,
              ),
            ),
            hintStyle: kBodyText,
          ),
          style: kBodyText,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          validator: (String? value) {
            if (value!.isEmpty || value.length < 3) {
              return 'Invalid name';
            }
            return null;
          },
          onSaved: (String? value) {
            _formData["lastName"] = value;
          },
        ),
      ),
    );
  }

  Widget _buildPhoneNoTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: "Phone No",
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                FontAwesomeIcons.phone,
                color: Colors.white,
                size: 30,
              ),
            ),
            hintStyle: kBodyText,
          ),
          style: kBodyText,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          validator: (String? value) {
            if (value == null ||
                value.length >= 9 ||
                value.isEmpty ||
                value.substring(0, 2).compareTo('09') != 0) {
              return 'Invalid Password';
            }
          },
          // onTap: () {
          //   setState(() {
          //     if (_phoneTxtFieldController.text.compareTo('0911121314') ==
          //         0) {
          //       _phoneTxtFieldController.text = '';
          //     }
          //   });
          // },
          onSaved: (String? value) {
            _formData['phoneNum'] = value!;
          },
        ),
      ),
    );
  }

  Widget _authBtn() {
    return _isLoading
        ? CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          )
        : Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextButton(
              onPressed: () =>
                  _authMode == AuthMode.logIn ? _login() : _signup(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  _authMode == AuthMode.logIn ? "LogIn" : "SignUp",
                  style: kBodyText,
                ),
              ),
            ),
          );
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<UserProvider>(context, listen: false)
          .login(_formData['email'], _formData['password']);
      setState(() {
        _isLoading = false;
      });
    } on HttpException catch (error) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog(error.toString());
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('Something went wrong!');
    }
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<UserProvider>(context, listen: false).signup(_formData);
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacementNamed(context, 'home');
    } on HttpException catch (error) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog(error.toString());
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('Something went wrong!');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}
