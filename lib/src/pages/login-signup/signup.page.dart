import 'package:fanta_prof/src/widgets/signup.widget.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Center(
        child: (MediaQuery.of(context).size.width > 500 &&
                MediaQuery.of(context).size.height > 620)
            ? SizedBox(
                width: 480,
                child: Card(child: SignUpWidget()),
              )
            : SignUpWidget(),
      ),
    );
  }
}
