import 'package:counter_next/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:counter_next/pages/pass_forgot.dart';

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

Future<void> registerWithEmailAndPassword(String email, String password) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      //print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      //print('The account already exists for that email.');
    }
  } catch (e) {
    //print(e);
  }
}

Future<void> signInWithEmailAndPassword(
    String email, String password, BuildContext context) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      // print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      // print('Wrong password provided for that user.');
    }
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Fondo(),
          Contenido(),
        ],
      ),
    );
  }
}

class Fondo extends StatelessWidget {
  const Fondo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Colors.blue.shade300, Colors.blue],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      )),
    );
  }
}

class Contenido extends StatefulWidget {
  const Contenido({super.key});

  @override
  State<Contenido> createState() => _ContenidoState();
}

class _ContenidoState extends State<Contenido> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Bienvenido a tu cuenta',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 1.5,
            ),
          ),
          Datos(),
          SizedBox(
            height: 5,
          ),
          Privacidad(),
        ],
      ),
    );
  }
}

class Datos extends StatefulWidget {
  const Datos({super.key});

  @override
  State<Datos> createState() => _DatosState();
}

class _DatosState extends State<Datos> {
  bool showPass = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Email',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Ingresa tu correo electronico',
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Password',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: showPass,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Contraseña',
              suffixIcon: IconButton(
                icon: const Icon(Icons.remove_red_eye_outlined),
                onPressed: () => {
                  setState(() {
                    showPass = !showPass;
                  }),
                },
              ),
            ),
          ),
          const Remember(),
          const SizedBox(
            height: 30,
          ),
          const Botones(),
        ],
      ),
    );
  }
}

class Remember extends StatefulWidget {
  const Remember({super.key});

  @override
  State<Remember> createState() => _RememberState();
}

class _RememberState extends State<Remember> {
  bool ischecked = true;

  void forgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPassword()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: ischecked,
            onChanged: (value) => {
                  setState(() => ischecked == false
                      ? ischecked = true
                      : ischecked = false),
                }),
        const Text(
          'Recuerdame',
          style: TextStyle(fontSize: 12),
        ),
        const Spacer(),
        TextButton(
            onPressed: forgotPassword,
            child: const Text(
              '¿Olvido su contraseña?',
              style: TextStyle(fontSize: 12),
            )),
      ],
    );
  }
}

class Botones extends StatelessWidget {
  const Botones({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              signInWithEmailAndPassword(
                  _emailController.text, _passwordController.text, context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xff142047),
              ),
            ),
            child: const Text('Iniciar Sesion',
                style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(
          height: 25,
          width: double.infinity,
        ),
        const Text(
          "Ingresa con",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 25,
          width: double.infinity,
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: () {
              registerWithEmailAndPassword(
                  _emailController.text, _passwordController.text);
            },
            child: const Text(
              'Google',
              style: TextStyle(
                color: Color(0xff142047),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
          width: double.infinity,
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: () => {},
            child: const Text(
              'Facebook',
              style: TextStyle(
                color: Color(0xff142047),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Privacidad extends StatelessWidget {
  const Privacidad({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => {},
        child: const Text(
          'Politica de privacidad',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
