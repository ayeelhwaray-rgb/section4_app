import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    print('LoginPage: initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('LoginPage: didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    print('LoginPage: build');

    return Scaffold(
        appBar: AppBar(
          title: const Text('Shopping App'),
        ),
        body: Center(
            child: ElevatedButton(
                onPressed: () {
                  context.goNamed(
                    'products',
                    queryParameters: {'user': 'Guest'},
                  );
                },

  child: const Text('Enter Shopping App'),
  ),
  ),
  );
}

@override
void deactivate() {
  print('LoginPage: deactivate');
  super.deactivate();
}

@override
void dispose() {
  print('LoginPage: dispose');
  super.dispose();
}
}