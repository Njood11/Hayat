// ignore: file_names
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/home_pages/charity_home.dart';
import 'package:hayat_gp2_18/signup/charity_signup.dart';
import 'package:hayat_gp2_18/signin/signin_all.dart';
import 'package:encrypt/encrypt.dart';
import 'package:hayat_gp2_18/encryption.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class LoginChoPage extends StatefulWidget {
  const LoginChoPage() : super();

  @override
  _LoginChoPageState createState() => _LoginChoPageState();
}

class _LoginChoPageState extends State<LoginChoPage> {
  final formKey = GlobalKey<FormState>(); //key for form

  late String email = ' ';
  late String password = ' ';
  bool x = false;
  var Cid;

  var allCHOwithEmail = [];
  var elements = [];
  var allDonorswithEmail2 = [];
  var elements2 = [];
  var encryptedPass;
  var emailController = new TextEditingController();
  var passController = new TextEditingController();

////database cloud add donor functions//////

  void loginCharity() async {
    final email = emailController.text.toLowerCase();
    final inputpass = passController.text;

    encryptedPass = EncryptionDecryption.encryptAES(inputpass);

    encryptedPass = encryptedPass.base64;
    print('encryptedPass:  ');
    print(encryptedPass);
    final charity = ParseUser(email, encryptedPass, null);

    var response = await charity.login();

    /////

    if (response.success && charity.get("userType") == 'cho') {
      Cid = charity.objectId;
      print('id:  ');
      print(Cid);
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context, "OK");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeC(Cid)),
          );
        },
      );
      // set up the AlertDialog

      AlertDialog alert = AlertDialog(
        title: Text("Success!"),
        content: Text("You have successfully Signed in"),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    if (response.success == false || charity.get("userType") != 'cho') {
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context, 'OK');
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Error!"),
        content: Text("email or password is wrong!"),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      if (charity.get("emailVerified") == false) {
        Widget okButton = TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context, 'OK');
          },
        );
        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text("Error!"),
          content: Text("email is not verified!"),
          actions: [
            okButton,
          ],
        );

        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LoginAll()));
            },
            icon: Icon(Icons.home_outlined),
          ),
          title: Text(
            'Hayat food donation',
          ),
          backgroundColor: Colors.teal[200],
        ),
        body: Form(
          key: formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Sign in",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Hello Charity please sign in to your account ..",
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            onChanged: (value) {
                              email = value;
                            },
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 16),
                              labelText: 'Email',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                            },
                          ),
                          TextFormField(
                              onChanged: (value) {
                                password = value;
                              },
                              controller: passController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 16),
                                labelText: 'Password',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                              }),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                          padding: EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: () {
                                try {
                                  if (formKey.currentState!.validate()) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    loginCharity(); // you'd often call a server or save the information in a database.

                                  }
                                } catch (e) {
                                  print(e);
                                }
                              },
                              color: Colors.teal[100],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                              splashColor: Colors.red)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          //child: Text('Don\'t have an account? Create'),
                          child: Text.rich(TextSpan(children: [
                            TextSpan(text: "Don\'t have an account? "),
                            TextSpan(
                              text: 'Create',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignupPage()));
                                },
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).accentColor),
                            ),
                          ])),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 85),
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/CHO.jpg"),
                            fit: BoxFit.fitHeight),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}
