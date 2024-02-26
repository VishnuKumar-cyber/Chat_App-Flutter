import 'package:demo_app/Services/Auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  final void Function()? onTap;
  const LoginForm({super.key, required this.onTap});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  Future<void> SignIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailAndPassword(
          emailcontroller.text, passwordcontroller.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Material(
              child: Padding(
                padding: EdgeInsets.only(top: 80),
                child: Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      fontFamily: 'Copperplate Gothic',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
            Material(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: TextFormField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 0.5),
                    ),
                    focusedBorder: const OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter Email Id',
                    hintStyle: const TextStyle(color: Colors.blue),
                    labelStyle: const TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ),
            Material(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: TextFormField(
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 0.5),
                    ),
                    focusedBorder: const OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter Password',
                    hintStyle: const TextStyle(color: Colors.blue),
                    labelStyle: const TextStyle(color: Colors.blue),
                  ),
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                height: 70,
                width: 350,
                child: ElevatedButton(
                  onPressed: () {
                    SignIn();
                  },
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    elevation: const MaterialStatePropertyAll(10),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.lightBlueAccent),
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Copperplate Gothic',
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Not a Member ? ',
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Register Now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
