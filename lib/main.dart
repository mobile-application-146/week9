import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fancy Login App',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class User {
  final String username;
  final String email;
  final String password;

  User(this.username, this.email, this.password);
}

List<User> registeredUsers = [];

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 15), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registration App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 8,
        shadowColor: Colors.purpleAccent,
      ),
      body: Center(child: FlutterLogo(size: 100)),
    );
  }
}

InputDecoration fancyInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2),
      borderRadius: BorderRadius.circular(12),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    String inputEmail = _emailController.text.trim();
    String inputPassword = _passwordController.text;

    bool success = registeredUsers.any(
      (user) =>
          (user.email == inputEmail || user.username == inputEmail) &&
          user.password == inputPassword,
    );

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(success ? 'Login Successful' : 'Login Failed'),
            content: Text(
              success
                  ? 'You have successfully logged in.'
                  : 'Invalid username/email or password.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  void _navigateToSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login Screen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 8,
        shadowColor: Colors.purpleAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: fancyInputDecoration('Username or Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: fancyInputDecoration('Password'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
              ),
            ),
            SizedBox(height: 12),
            TextButton(onPressed: _navigateToSignup, child: Text('Sign Up')),
          ],
        ),
      ),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  void _register() {
    if (_formKey.currentState!.validate()) {
      registeredUsers.add(
        User(_username.text.trim(), _email.text.trim(), _password.text),
      );

      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text('Registration Successful'),
              content: Text('You can now login using your credentials.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context); // Go back to login screen
                  },
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }
  }

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  String? _validatePasswordMatch(String? value) {
    if (value != _password.text) return 'Passwords do not match';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registration',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 8,
        shadowColor: Colors.purpleAccent,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _username,
                decoration: fancyInputDecoration('Username'),
                validator:
                    (value) => value!.isEmpty ? 'Username is required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _email,
                decoration: fancyInputDecoration('Email'),
                validator:
                    (value) => value!.isEmpty ? 'Email is required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _password,
                decoration: fancyInputDecoration('Password'),
                obscureText: true,
                validator:
                    (value) => value!.isEmpty ? 'Password is required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _confirmPassword,
                decoration: fancyInputDecoration('Confirm Password'),
                obscureText: true,
                validator: _validatePasswordMatch,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _register,
                child: Text('Register'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
