import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  registrar() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);

      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'name': _nameController.text,
        'email': _emailController.text,
        'senha': md5.convert(utf8.encode(_passwordController.text)).toString(),
        'lastSignIn': Timestamp.now(),
      });

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("A senha é muito fraca!")),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Este email já está cadastrado.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      keyboardType: TextInputType.name,
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome',
                      ),
                    ),
                    const SizedBox(height: 16),
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
                          registrar();
                        },
                        child: const Text('CRIAR CONTA'),
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
