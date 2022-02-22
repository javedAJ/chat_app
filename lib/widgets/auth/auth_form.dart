import 'package:flutter/material.dart';
import 'package:chat_app/colors.dart' as color;

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;

  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      print(_userEmail);
      print(_userName);
      print(_userPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 20,
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please Enter a valid email address';
                        }
                        return null;
                      },
                      cursorColor: color.AppColor.red,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        hintText: ' Enter Email Address',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: color.AppColor.neavyblue),
                        ),
                      ),
                      onSaved: (value) {
                        _userEmail = value!;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (!_isLogin)
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return 'Please enter at least 4 charcters';
                          }
                          return null;
                        },
                        cursorColor: color.AppColor.red,
                        decoration: const InputDecoration(
                            labelText: 'Usename',
                            border: OutlineInputBorder(),
                            hintText: 'Enter User Name'),
                        onSaved: (value) {
                          _userName = value!;
                        },
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'password must be at least 7 charcters long';
                        }
                        return null;
                      },
                      obscureText: true,
                      cursorColor: color.AppColor.red,
                      decoration: const InputDecoration(
                        labelText: 'password',
                        hintText: 'Enter Password',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) {
                        _userPassword = value!;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    RaisedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                    ),
                    FlatButton(
                      textColor: color.AppColor.red,
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin
                            ? 'Create new Account'
                            : 'I already have an account',
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
