import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:budget_mobile/core/routes/router.gr.dart';
import 'package:budget_mobile/features/auth/application/auth_provider.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late TextEditingController _emailCtrl;
  late TextEditingController _passwordCtrl;
  bool _loading = false;

  @override
  void initState() {
    _emailCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordCtrl,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? () {} : _submit,
              child: Text(_loading ? '...' : 'Login'),
            ),
            SizedBox(height: 20.h),
            Text('Don\'t have an account?', style: Theme.of(context).textTheme.bodyMedium),
            TextButton(
              onPressed: () {
                if (mounted) {
                  context.router.replace(const SignupRoute());
                }
              },
              child: const Text('Signup'),
            ),
            SizedBox(height: kToolbarHeight),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    setState(() => _loading = true);
    final success = await ref.read(loginProvider(_emailCtrl.text, _passwordCtrl.text).future);
    setState(() => _loading = false);
    if (success) {
      if (mounted) {
        context.router.replace(const HomeRoute());
      }
    }
  }
}
