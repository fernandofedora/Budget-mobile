import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class LoadScreen extends ConsumerWidget {
  const LoadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(title: const Text('Load Screen')),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      body: Center(child: const Text('Load Screen')),
    );
  }
}
