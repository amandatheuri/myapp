// superadmin_login.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/admins_authentication/admin_service/adminauth_service.dart';
import 'package:myapp/superadmin/screens/superadmin_screen.dart';

class SuperAdminLoginScreen extends StatefulWidget {
  const SuperAdminLoginScreen({super.key});

  @override
  _SuperAdminLoginScreenState createState() => _SuperAdminLoginScreenState();
}

class _SuperAdminLoginScreenState extends State<SuperAdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final AuthService authService = Get.find<AuthService>(); // GetX way to access service

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Super Admin Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Admin Email'),
                validator: (value) => value!.contains('@') ? null : 'Invalid email',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => value!.length >= 6 ? null : 'Minimum 6 characters',
              ),
              SizedBox(height: 30),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _handleLogin,
                      child: Text('Login as Super Admin'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    try {
      await authService.loginAdmin(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      Get.offAll(() => SuperAdminDashboard()); // Better navigation with GetX
    } catch (e) {
      Get.snackbar( // GetX snackbar
        'Login Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}