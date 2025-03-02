import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class ClassesPage extends StatelessWidget {
  const ClassesPage({super.key});

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
                icon: Avatar(
                    initials: Avatar.getInitials(
                        supabase.auth.currentUser?.userMetadata?['name'] ??
                            supabase.auth.currentUser?.email ??
                            ""))), // Handle null email
          ],
        ),
        Divider()
      ],
      child: Center(child: Text("Classe")),
    );
  }
}
