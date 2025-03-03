import 'package:fanta_prof/src/utils/functions/userdata.function.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  Future<String> fetchUserName() async {
    final data = await supabase.from("users (public)").select().single();
    final name = data['username'];
    print("name"+name);
    return name;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        AppBar(
          title: Text("Classi"),
          trailing: [
            IconButton.text(
                onPressed: () {
                  context.go('/settings');
                },
                density: ButtonDensity.compact,
                icon: FutureBuilder(
                    future: GetUsername.future(),
                    builder: GetUsername.buildAvatar)), // Handle null email
          ],
        ),
        Divider()
      ],
      child: Center(child: Text("Classe")),
    );
  }
}
