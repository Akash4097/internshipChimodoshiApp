import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './services_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _passwordFocusedNode = FocusNode();
  final _userEmailFocusedNode = FocusNode();
  final _loginButtonFocusedNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  void _updateWidgets() {
    if ((!_userEmailFocusedNode.hasFocus) || (!_passwordFocusedNode.hasFocus)) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _userEmailFocusedNode.addListener(_updateWidgets);
    _passwordFocusedNode.addListener(_updateWidgets);
    super.initState();
  }

  @override
  void dispose() {
    _userEmailFocusedNode.removeListener(_updateWidgets);
    _passwordFocusedNode.removeListener(_updateWidgets);
    _passwordFocusedNode.dispose();
    _loginButtonFocusedNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * .15,
                alignment: AlignmentDirectional.center,
                width: MediaQuery.of(context).size.width * .5,
                margin: EdgeInsets.symmetric(vertical: 18.0),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.red,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    customTextFormField(
                        validationError: "Please enter email or username",
                        password: false,
                        email: "Username or Email",
                        icon: Icons.person_outline,
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusedNode);
                        }),
                    customTextFormField(
                        validationError: "Please enter password",
                        password: true,
                        email: "Password",
                        icon: Icons.vpn_key,
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        focusNode: _passwordFocusedNode,
                        onSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_loginButtonFocusedNode);
                        }),
                    loginButton(context, _loginButtonFocusedNode),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                alignment: Alignment.centerRight,
                child: FlatButton(
                  textColor: Colors.deepPurple[300],
                  onPressed: () {},
                  child: Text("Forgot Password?"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have an account?"),
                  FlatButton(
                    textColor: Colors.deepPurple[300],
                    child: Text("Sign Up"),
                    onPressed: () {},
                  )
                ],
              ),
              ListTile(
                trailing: SizedBox(
                  width: 160,
                  child: Divider(
                    color: Colors.deepPurple,
                    thickness: 1.0,
                    endIndent: 5.0,
                    indent: 5.0,
                  ),
                ),
                title: Text("OR"),
                dense: true,
                leading: SizedBox(
                  width: 160,
                  child: Divider(
                    color: Colors.deepPurple,
                    thickness: 1.0,
                    endIndent: 5.0,
                    indent: 5.0,
                  ),
                ),
              ),
              Text("Sign up with Social Networks"),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buildSocialMediaSignUpButton(
                      function: () {}, imageUrl: "images/facebook.png"),
                  buildSocialMediaSignUpButton(
                      function: () {}, imageUrl: "images/twitter.png"),
                  buildSocialMediaSignUpButton(
                      function: () {}, imageUrl: "images/google-plus.png")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  InkWell buildSocialMediaSignUpButton({Function function, String imageUrl}) {
    return InkWell(
      splashColor: Colors.grey,
      onTap: function,
      radius: 25.0,
      child: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(
          imageUrl,
        ),
      ),
    );
  }

  Widget loginButton(BuildContext context, FocusNode focusNode) {
    return InkWell(
      focusNode: focusNode,
      focusColor: Colors.white,
      onTap: () {
        if (!_formKey.currentState.validate()) {
          return;
        }
        Navigator.of(context).pushReplacementNamed(ServicesScreen.routeName);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
        child: Container(
          height: 55.0,
          width: 600.0,
          child: Text(
            "Login",
            style: TextStyle(
                color: Colors.white,
                letterSpacing: 0.2,
                fontFamily: "Sans",
                fontSize: 18.0,
                fontWeight: FontWeight.w800),
          ),
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black38, blurRadius: 15.0),
            ],
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
              colors: <Color>[Color(0xFF822525), Color(0xFFe81414)],
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextFormField(
      {bool password,
      String validationError,
      String email,
      IconData icon,
      TextInputType textInputType,
      TextInputAction textInputAction,
      FocusNode focusNode,
      Function onSubmitted}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: 60.0,
        margin: EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 10.0, color: Colors.black12),
          ],
        ),
        padding:
            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.transparent,
          ),
          child: TextFormField(
            onFieldSubmitted: onSubmitted,
            focusNode: focusNode,
            textInputAction: textInputAction,
            validator: (value) {
              if (value.isEmpty) {
                return validationError;
              }
              return null;
            },
            obscureText: password,
            inputFormatters: [LengthLimitingTextInputFormatter(14)],
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: email,
              icon: Icon(
                icon,
                color: Colors.black38,
              ),
              labelStyle: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Sans',
                  letterSpacing: 0.3,
                  color: Colors.black38,
                  fontWeight: FontWeight.w600),
            ),
            keyboardType: textInputType,
          ),
        ),
      ),
    );
  }
}
