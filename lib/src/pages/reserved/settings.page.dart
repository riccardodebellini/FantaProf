import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Safely access user metadata
          IconButton.primary(icon: Icon(LucideIcons.arrow_left), onPressed: () {
            context.go('/classes');
          },),
          Text("Ciao ${supabase.auth.currentUser?.userMetadata?['name'] ?? "Utente"}")
              .large()
              .medium(),
          Text(supabase.auth.currentUser?.email ?? "")
              .muted(), // Handle null email
          Gap(16),
          DestructiveButton(
            onPressed: () async {
              try {
                await supabase.auth.signOut(); // Sign out
                context.go('/');
              } catch (e) {
                // Handle sign-out errors
                print("Sign-out error: $e");
              }
            },
            child: Text('Esci'),
          ),
        ],
      ),
    );
  }
}
