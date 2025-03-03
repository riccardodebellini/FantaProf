import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class GetUsername {
  GetUsername._();
  static future() async {
    final data = await supabase.from("users (public)").select().single();
    return data['username'];
  }
  static Widget buildAvatar(BuildContext context, AsyncSnapshot snapshot) {

    final String? string;

    if (snapshot.hasData &&
        snapshot.data != "" &&
        snapshot.data != null) {
      string = (snapshot.data as String);
      print(string);
    } else {
      string = supabase.auth.currentUser?.email ?? "User";
    }

    return Avatar(initials: Avatar.getInitials(string));
  }

  static Widget buildWelcomeText (BuildContext context, AsyncSnapshot snapshot) {
    final String? string;

    if (snapshot.hasData &&
        snapshot.data != "" &&
        snapshot.data != null) {
      string = (snapshot.data as String);
      print(string);
    } else {
      string = supabase.auth.currentUser?.email ?? "User";
    }

   return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: DefaultTextStyle.of(context).style.copyWith(
            fontSize:
            Theme.of(context).typography.x6Large.fontSize),
        children: [
          const TextSpan(
            text: 'Ciao, ',
          ),
          TextSpan(
              text: string,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary)),
        ],
      ),
    );
  }
}
