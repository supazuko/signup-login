import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signup_login/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FocusNode phoneNumberFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  bool isPasswordBlur = true;
  bool value = false;

  // text field state
  String email = '';
  String phoneNumber = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Color(0xFFFBFBFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFBFBFF),
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            widget.toggleView();
          },
          child: IconButton(
            icon: const Icon(Icons.lock_person_outlined),
            color: Colors.black,
            style: TextButton.styleFrom(primary: Colors.black),
            onPressed: () => widget.toggleView(),
          ),
        ),
        title: Text('Sign up', style: TextStyle(color: Colors.black)),
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
                    "Create your account - enjoy our services",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text("with most updated features",
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
                textInputAction: TextInputAction.next,
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
              SizedBox(height: 30.0),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.length != 11 ? 'Enter a valid Phone Number' : null,
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  hintText: 'Enter phone number',
                  hintStyle: TextStyle(
                      color: theme.accentColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                      fontFamily: "sf-ui-display"),
                  filled: true,
                  fillColor: Color(0xffF3F6FF),
                  labelStyle: TextStyle(
                      color: phoneNumberFocus.hasFocus
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
                onChanged: (value) {
                  setState(() => phoneNumber = value);
                },
                cursorRadius: Radius.elliptical(10, 20),
                showCursor: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(11),
                ],
              ),
              SizedBox(height: 30.0),
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
                validator: (value) =>
                    value!.length != 8 ? 'Enter a password 8 chars long' : null,
                onChanged: (value) {
                  setState(() => password = value);
                },
                maxLength: 8,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                // inputFormatters: [
                //   LengthLimitingTextInputFormatter(8),
                // ],
              ),
              SizedBox(height: 20.0),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Checkbox(
                    value: value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value!;
                      });
                    }),
                Text(
                  "I agree with Terms and Privacy",
                  textAlign: TextAlign.start,
                ),
              ]),
              SizedBox(height: 30.0),
              MaterialButton(
                  minWidth: 300.0,
                  height: 56.0,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 28),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: theme.primaryColor),
                  ),
                  color: theme.primaryColor,
                  child: Text(
                    "Let's roll",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      dynamic result =
                          await _auth.createUserWithEmailAndPassword(
                              email, phoneNumber, password);
                      print(result.toString());
                      if (result == null) {
                        setState(() {
                          error = 'Please enter a valid email';
                        });
                      }
                    }
                  }),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              SizedBox(height: 10.0),
              Divider(
                height: 0.5,
                thickness: 0.1,
                indent: 10,
                endIndent: 10,
                color: Colors.black,
              ),
              SizedBox(height: 40.0),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Already have an account? ",
                  // style: Theme.of(context).textTheme.bodySmall,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Login',
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
          ),
        ),
      ),
    );
  }
}
