import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/signup/donor_signup.dart';
import 'package:hayat_gp2_18/home_pages/donor_home.dart';
import 'package:hayat_gp2_18/offers/publish_offer.dart';
import 'package:hayat_gp2_18/signin/signin_all.dart';
import 'package:hayat_gp2_18/database/sqlite.dart';
import 'package:encrypt/encrypt.dart';
import 'package:hayat_gp2_18/encryption.dart';

class LoginDonor extends StatefulWidget {
  const LoginDonor() : super();

  @override
  _LoginDonorState createState() => _LoginDonorState();
}

class _LoginDonorState extends State<LoginDonor> {
  final formKey = GlobalKey<FormState>(); //key for form
  late var id;
  late String email = ' ';
  late String password = ' ';
  bool x = false;
  late String z = '';
  late String u = "";

  var allDonorswithEmail = [];
  var elements = [];
  var allDonorswithEmail2 = [];
  var elements2 = [];

  var emailController = new TextEditingController();
  var passController = new TextEditingController();

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
                          "Login",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Hello Donor login to you account ..",
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
                                var helper = DatabaseHelper.instance
                                    .CheckDonor()
                                    .then((value) {
                                  setState(() {
                                    allDonorswithEmail = value;
                                    elements = allDonorswithEmail;

                                    print('all donors');
                                    print(elements);
                                  });
                                  var s3 = elements;
                                  var query = emailController.text;

                                  print('query');

                                  print(query);

                                  if (query.isNotEmpty) {
                                    s3.forEach((element) {
                                      var don = Donors.fromMap(element);
                                      var Emails = don.email.toString();
                                      var pass = don.password.toString();
                                      if (Emails.toLowerCase()
                                          .contains(query.toLowerCase())) {
                                        // x = true;
                                        z = '';
                                        id = don.Donorid!;
                                        print('user\'s email');
                                        print(Emails);
                                        //email found now check password
                                        var query2 = passController.text;

                                        print('user\'s password');

                                        print(query2);
                                        var y = Encrypted.from64(pass);
                                        var decryptedPass =
                                            EncryptionDecryption.decryptAES(y);
                                        print(
                                            'deccryptedPass: ' + decryptedPass);

                                        if (decryptedPass == query2) {
                                          z = '';
                                          print(' دخل المقارنة');

                                          x = true;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text('Processing Data')),
                                          );
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeD(id)),
                                          );
                                        } else if (decryptedPass != query2) {
                                          z = 'email or password is wrong';
                                        }
                                      }
                                    });
                                  }
                                });

                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                if (z == 'email or password is wrong') {
                                  return 'email or password is wrong';
                                }
                              }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                          padding: EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                              )),
                          child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: () {
                                try {
                                  if (formKey.currentState!.validate()) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.

                                  }
                                } catch (e) {
                                  print(e);
                                }
                              },
                              color: Colors.teal[100],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
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
                                          builder: (context) => DSignupPage()));
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
                            image: AssetImage("images/donor.jpg"),
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
