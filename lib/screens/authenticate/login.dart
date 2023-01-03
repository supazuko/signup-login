import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signup_login/services/auth.dart';
import 'package:auth_buttons/auth_buttons.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  Login({required this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool isPasswordBlur = true;

  bool value = false;

  AuthButtonType? buttonType;
  AuthIconType? iconType;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFFFBFBFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFBFBFF),
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            widget.toggleView();
          },
          child: IconButton(
            icon: const Icon(Icons.person_add),
            color: Colors.black,
            style: TextButton.styleFrom(primary: Colors.black),
            onPressed: () => widget.toggleView(),
          ),
        ),
        title: Text(
          'Login',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Login to your account - enjoy exclusive",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text("features and many more.",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      )),
                ]),
                SizedBox(height: 30.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter email address',
                    hintStyle: TextStyle(
                        color: theme.accentColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                        fontFamily: "sf-ui-display"),
                    filled: true,
                    fillColor: Color(0xffF3F6FF),
                    labelStyle: TextStyle(
                        color: emailFocus.hasFocus
                            ? Color(0xFF828282)
                            : Colors.black,
                        letterSpacing: 0.8,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: new BorderSide(
                        color: theme.backgroundColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: theme.backgroundColor)),
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: new BorderSide(color: theme.backgroundColor),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter a valid email address' : null,
                  onChanged: (value) {
                    setState(() => email = value);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter password',
                    hintStyle: TextStyle(
                        color: theme.accentColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                        fontFamily: "sf-ui-display"),
                    suffixText: '*',
                    suffixStyle: TextStyle(
                      color: Colors.red,
                    ),
                    filled: true,
                    fillColor: Color(0xffF3F6FF),
                    labelStyle: TextStyle(
                        color: passwordFocus.hasFocus
                            ? Color(0xFF828282)
                            : Colors.black,
                        letterSpacing: 0.8,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: new BorderSide(
                        color: theme.backgroundColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: theme.backgroundColor)),
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: new BorderSide(color: theme.backgroundColor),
                    ),
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                isPasswordBlur = !isPasswordBlur;
                              });
                            },
                            child: Icon(
                              Icons.remove_red_eye,
                              color: Colors.black,
                            )),
                      ],
                    ),
                    isDense: true,
                  ),
                  obscureText: isPasswordBlur,
                  validator: (value) => value!.length < 8
                      ? 'Enter a password 8 chars long'
                      : null,
                  onChanged: (value) {
                    setState(() => password = value);
                  },
                  maxLength: 8,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  // inputFormatters: [
                  //   LengthLimitingTextInputFormatter(8),
                  // ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Checkbox(
                          value: value,
                          onChanged: (value) {
                            setState(() {
                              this.value = value!;
                            });
                          }),
                      Text(
                        "Remember me",
                        textAlign: TextAlign.start,
                      ),
                      Spacer(),
                      Text("Forgot Password?",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          )),
                    ]),
                SizedBox(height: 20.0),
                MaterialButton(
                    minWidth: 300.0,
                    height: 40.0,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: theme.primaryColor),
                    ),
                    color: theme.primaryColor,
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        print('valid');
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email, password);
                        print("this is login uid ${result.email}");
                        if (result == null) {
                          setState(() {
                            error =
                                'Could not login with those credentials, try again.';
                          });
                        }
                      }
                    }),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
                Text(
                  'Or',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                SizedBox(height: 20.0),
                AuthButtonGroup(
                  style: AuthButtonStyle(
                    padding: const EdgeInsets.all(8.0),
                    elevation: 0.0,
                    width: 300.0,
                    height: 50.0,
                    buttonColor: Colors.blueGrey[50],
                    borderColor: theme.primaryColor,
                    borderWidth: 0.5,
                    borderRadius: 8.0,
                    textStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    progressIndicatorType: AuthIndicatorType.linear,
                    buttonType: buttonType,
                  ),
                  runSpacing: 15,
                  buttons: [
                    GoogleAuthButton(
                      onPressed: () {},
                      text: "Google",
                      style: AuthButtonStyle(
                        buttonType: buttonType,
                        iconType: iconType,
                        iconSize: 15.0,
                      ),
                    ),
                    TwitterAuthButton(
                      onPressed: () {},
                      text: "Twitter",
                      style: AuthButtonStyle(
                        buttonType: buttonType,
                        iconType: iconType,
                        iconSize: 15.0,
                        iconColor: theme.primaryColor,
                      ),
                    ),
                    AppleAuthButton(
                      onPressed: () {},
                      text: "Apple ID",
                      style: AuthButtonStyle(
                        buttonType: buttonType,
                        iconType: iconType,
                        iconSize: 15.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Divider(
                  height: 0.5,
                  thickness: 0.1,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.black,
                ),
                SizedBox(height: 25.0),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Don't have an account? ",
                    // style: Theme.of(context).textTheme.bodySmall,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            widget.toggleView();
                          },
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    ));
  }
}
