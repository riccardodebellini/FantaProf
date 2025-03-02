import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final _emailKey = const TextFieldKey(#email);
  final _passwordKey = const TextFieldKey(#password);
  final _confirmPasswordKey = const TextFieldKey(#confirmPassword);
  final _usernameKey = const TextFieldKey(#username);
  late bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        onSubmit: (context, values) async {
          try {
            final username =  values[FormKey(#_usernameKey)]
            ;
            print(username);
            await supabase.auth.signUp(
                password: values[FormKey(#password)] as String,
                email: values[FormKey(#email)] as String);



            await supabase.auth.signInWithPassword(
                password: values[FormKey(#password)] as String,
                email: values[FormKey(#email)] as String);


            await supabase.auth.updateUser(
              UserAttributes(
                data: { 'name': username},
              ),
            );

            context.go('/classes');
          } catch (e) {
            print(e.toString());
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
                'Benvenuto', // Add a heading
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24), // Space after the heading
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FormField(
                    key: _emailKey,
                    label: const Text('Email'),
                    child: TextField(),
                  ),
                  Gap(16),
                  FormField(
                    hint: Text(
                        "8 Caratteri (lettere maiuscole/minuscole e numeri)"),
                    key: _passwordKey,
                    label: const Text('Password'),
                    validator:
                        LengthValidator(min: 8, message: "Minimo 8 caratteri")
                            .combine(
                      SafePasswordValidator(
                          message: "La password non è abbastanza sicura",
                          requireDigit: true,
                          requireLowercase: true,
                          requireUppercase: true,
                          requireSpecialChar: false),
                    ),
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
                  Gap(16),
                  FormField(
                    validator: CompareWith.equal(_passwordKey,
                        message: 'Le password non corrispondono'),
                    key: _confirmPasswordKey,
                    label: const Text('Conferma password'),
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
                  Gap(16),
                  FormField(
                    key: _usernameKey,
                    label: const Text('Username'),
                    child: TextField(),
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

              Gap(24),
              Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Sei già registrato?").textSmall(),
                      LinkButton(
                        onPressed: () {
                          // Implement forgot password logic here
                          context.go('/login');
                        },
                        child: const Text('Entra'),
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
