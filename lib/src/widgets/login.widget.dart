import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

final supabase = Supabase.instance.client;

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _emailKey = const TextFieldKey(#email);
  final _passwordKey = const TextFieldKey(#password);
  late bool hidePassword = true;
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        onSubmit: (context, values) async {
          try {
            await supabase.auth.signInWithPassword(
                password: values[FormKey(#password)] as String,
                email: values[FormKey(#email)] as String);
            // Show success message (using a snackbar is better)

            context.go('/classes');
          } catch (e) {
            showToast(
                location: ToastLocation.bottomCenter,
                context: context,
                builder: (context, overlay) {
                  return SurfaceCard(
                    child: Basic(
                      title: const Text('Errore'),
                      subtitle: const Text('Ricontrolla email e password'),
                      trailing: IconButton.text(
                          size: ButtonSize.small,
                          onPressed: () {
                            overlay.close();
                          },
                          icon: const Icon(LucideIcons.x)),
                      trailingAlignment: Alignment.center,
                    ),
                  );
                });
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Stretch items horizontally
            children: [
              const Text(
                'Bentornato', // Add a heading
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24), // Space after the heading
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FormField(
                    key: _emailKey,
                    label: const Text('Email'),
                    child: TextField(
                      controller: _emailController,
                    ),
                  ),
                  const SizedBox(height: 16), // Space between form fields
                  FormField(
                    key: _passwordKey,
                    label: const Text('Password'),
                    child: TextField(
                      obscureText: hidePassword,
                      trailing: IconButton.text(
                        icon: Icon(hidePassword
                            ? LucideIcons.eye
                            : LucideIcons.eye_closed),
                        density: ButtonDensity.compact,
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(24), // Space before submit button
              FormErrorBuilder(
                builder: (context, errors, child) {
                  return PrimaryButton(
                    onPressed:
                        errors.isEmpty ? () => context.submitForm() : null,
                    child: const Text('Entra'), // Changed button text
                  );
                },
              ),
              // Add a "Forgot Password?" link (optional)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Implement forgot password logic here
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Conferma email"),
                            content: SizedBox(
                              width: 300,
                              child: TextField(
                                placeholder: Text("Inserisci la tua email"),
                                controller: _emailController,
                              ),
                            ),
                            actions: [
                              OutlineButton(
                                child: const Text('Annulla'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              PrimaryButton(
                                child: const Text('Conferma'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  final url = Uri.parse(
                                      'mailto:riccardodebellini+fantaprof?subject=%5BFANTAPROF%5D%20Password%20smarrita&body=Ciao%2C%0AHo%20smarrito%20la%20password%20per%20il%20mio%20account%20FantaProf%20(${_emailController.text.toLowerCase()})%2C%20puoi%20reimpostarla%20per%20me%3F');
                                  print(url.path);
                                  launchUrl(url);
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: const Text('Password smarrita?'),
                ),
              ),
              Gap(24),
              Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Non hai un account?").textSmall(),
                      LinkButton(
                        onPressed: () {
                          print('button');
                          // Implement forgot password logic here
                          context.go('/signup');
                        },
                        child: const Text('Registrati'),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
