import 'package:geekbooks/core/responsive/size/responsive_size.dart';
import 'package:geekbooks/export/export.dart';

class SignupPage extends ConsumerWidget {
  final formKey = new GlobalKey<FormState>();
  final Color greenColor = Color(0xFF00AF19);
  final TextEditingController emailField = TextEditingController();
  final TextEditingController passwordField = TextEditingController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, info) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: R.w(info, 10),
              vertical: R.h(info, 10),
            ),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  Container(
                    height: 125.0,
                    width: 200.0,
                    child: Row(
                      children: [
                        KText(
                          "Signup",
                          size: R.f(info, 60.0),
                          color: greenColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.0),
                  TextFormField(
                    controller: emailField,
                    decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Trueno',
                            fontSize: 12.0,
                            color: Colors.grey.withOpacity(0.5)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greenColor),
                        )),
                    onChanged: (value) => emailField.text = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        labelStyle: TextStyle(
                            fontFamily: 'Trueno',
                            fontSize: 12.0,
                            color: Colors.grey.withOpacity(0.5)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greenColor),
                        )),
                    obscureText: true,
                    onChanged: (value) => passwordField.text = value,
                    validator: (value) =>
                        value!.isEmpty ? 'Password is required' : null,
                  ),
                  SizedBox(height: 50.0),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 50.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(25.0),
                        shadowColor: Colors.greenAccent,
                        color: greenColor,
                        elevation: 7.0,
                        child: Center(
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'MavenPro',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Go back',
                          style: TextStyle(
                              color: greenColor,
                              fontFamily: 'MavenPro',
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
