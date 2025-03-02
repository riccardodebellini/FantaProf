import 'package:fanta_prof/src/widgets/login.widget.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Center(
        child: (MediaQuery.of(context).size.width > 500 &&
                MediaQuery.of(context).size.height > 450)
            ? SizedBox(
                width: 480,
                child: Card(child: LoginWidget()),
              )
            : LoginWidget(),
      ),
    );
  }
}
