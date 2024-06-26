import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_keeper/first_access.dart';
import 'package:dice_keeper/room_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print(userCredential.toString());
      // Login bem-sucedido
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FirstAccess()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro durante o login: $e")),
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();

      if (!userDoc.exists) {
        await _firestore.collection('users').doc(userCredential.user?.uid).set({
          'email': userCredential.user?.email,
          'name': userCredential.user?.displayName,
          'lastSignIn': Timestamp.now(),
        });
      } else {
        await _firestore
            .collection('users')
            .doc(userCredential.user?.uid)
            .update({
          'lastSignIn': Timestamp.now(),
        });
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FirstAccess()),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro durante o login: $e")),
      );
    }
  }

  registrar() async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        print('Este email já está cadastrado');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white,
                Colors.white,
              ],
            ),
          ),
          child: Column(
            children: [
              Image.asset('assets/login_background.png'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'E-mail',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Senha',
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(74, 84, 140, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        onPressed: () {
                          _login();
                        },
                        child: const Text('INICIAR AVENTURA'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text('Ou'),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          _signInWithGoogle();
                        },
                        icon: SvgPicture.asset(
                          './assets/vectors/icons/google.svg',
                        ),
                        label: const Text("Entrar com Google"),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(179, 38, 30, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text:
                            'Ao entrar no sistema você está de acordo com nossa ',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                          color: Color(0xFF000000),
                        ),
                        children: [
                          TextSpan(
                            text: 'Política de Privacidade',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                              color: Color(0xFF4A548C),
                            ),
                          ),
                          TextSpan(
                            text: ' e ',
                          ),
                          TextSpan(
                            text: 'Termos de Uso',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                              color: Color(0xFF4A548C),
                            ),
                          ),
                          TextSpan(
                            text: '.',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
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
