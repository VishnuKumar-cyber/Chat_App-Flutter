import 'package:demo_app/Services/Auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  final void Function()? onTap;
  const RegisterForm({super.key, required this.onTap});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();

  void signUp() async {
    if (passwordcontroller.text != confirmpasswordcontroller) {
      final authService = Provider.of<AuthService>(context, listen: false);
      try {
        await authService.signUpWithEmailAndPassword(
            emailcontroller.text, passwordcontroller.text, namecontroller.text);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Passwords does not match',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Material(
                child: Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Center(
                    child: Text(
                      'REGISTER',
                      style: TextStyle(
                        fontFamily: 'Copperplate Gothic',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue,
                        letterSpacing: 5,
                      ),
                    ),
                  ),
                ),
              ),
              Material(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: TextFormField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 0.5),
                      ),
                      focusedBorder: const OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter Your Name',
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
              Material(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: TextFormField(
                    controller: confirmpasswordcontroller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 0.5),
                      ),
                      focusedBorder: const OutlineInputBorder(),
                      labelText: 'Confirm Password',
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
              Material(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    height: 50,
                    width: 360,
                    child: ElevatedButton(
                      onPressed: () {
                        signUp();
                      },
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        elevation: const MaterialStatePropertyAll(10),
                        backgroundColor: const MaterialStatePropertyAll(
                            Colors.lightBlueAccent),
                      ),
                      child: const Text(
                        'REGISTER',
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Copperplate Gothic',
                            color: Colors.black),
                      ),
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
                    'Already a Member ? ',
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Login Now',
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
      ),
    );
  }
}
