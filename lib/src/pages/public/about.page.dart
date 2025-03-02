import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        child: Center(
      child: PrimaryButton(
        child: Text("Login"),
        onPressed: () {
          print("press");
          context.go('/login');
        },
      ),
    ));
  }
}
