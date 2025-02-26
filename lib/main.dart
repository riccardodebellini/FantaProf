import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ShadcnApp(theme: ThemeData(
      colorScheme: ColorSchemes.lightNeutral(),
      radius: 1.0,
      surfaceOpacity: 0.55,
      surfaceBlur: 20.0,
    ),
      home: HomePage(),
      );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: ListView(
        controller: _controller,
        children: [
          Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style.copyWith(
                        fontSize:
                        Theme.of(context).typography.x6Large.fontSize),
                    children: [
                      const TextSpan(
                        text: 'Coming ',
                      ),
                      TextSpan(
                          text: 'Soon',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary)),
                    ],
                  ),
                ),
                const Gap(10),
                const Text(
                  'Stiamo lavorando duramente per offrirti qualcosa di incredibile. Resta sintonizzato!',
                  textAlign: TextAlign.center,
                ).lead(),
                const Gap(10),

                PrimaryButton(
                  child: Text("Segui il progetto")
                      , leading: Icon(LucideIcons.github),
                  onPressed: () {
                    print("press");
                    final url = Uri.parse('https://github.com/riccardodebellini/fantaprof');
                    launchUrl(url);
                  },
                )
              ])
              .sized(height: MediaQuery.of(context).size.height)
              .withPadding(horizontal: 20, bottom: 0),
          const FooterWidget()
        ],
      ),
    );
  }
}

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Divider(
          height: 60.0,
        ).withPadding(
            horizontal: SizeBased(context,
                ifSmall: 20.0, ifLarge: 200.0, breakpoint: 1000)
                .get()),
        const Text("Sito protetto da Copyright - (C) 2025 Riccardo Debellini")
            .muted()
            .small()
            .withPadding(
            left: SizeBased(context,
                ifSmall: 20.0, ifLarge: 200.0, breakpoint: 1000)
                .get(),
            right: SizeBased(context,
                ifSmall: 20.0, ifLarge: 200.0, breakpoint: 1000)
                .get(),
            bottom: 30)
      ],
    );
  }
}

class SizeBased {
  final dynamic ifSmall;
  final dynamic ifLarge;
  final int breakpoint;
  final BuildContext context;

  const SizeBased(
      this.context, {
        required this.ifSmall,
        required this.ifLarge,
        this.breakpoint = 800,
      });

  get() {
    final size = MediaQuery.of(context).size.width;
    bool isLarge = true;
    size < breakpoint ? isLarge = false : null;
    if (isLarge) return ifLarge;
    return ifSmall;
  }
}