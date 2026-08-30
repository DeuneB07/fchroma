import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/web.dart' as web;

import '../../state/theme_lab_state.dart';
import '../widgets/lab_widgets.dart';

/// About page — Credits and project information.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeLabState s = ThemeLabScope.of(context);
    final ThemeData theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(24),
      children: <Widget>[
        PageHeader(
          badge: 'about',
          title: 'About FChroma',
          subtitle: 'Credits and project information',
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'FChroma',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'An interactive lab for Flutter\'s ThemeData',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'FChroma exists to make learning Flutter\'s theming system accessible and intuitive. Instead of reading documentation in isolation, you can interact with every property of ThemeData in real-time and see how it affects your app. This hands-on approach helps developers understand not just what each property does, but why and when to use it.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                SectionTitle('Made by', icon: Icons.person),
                Text(
                  'DeuneDev',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                SectionTitle('License', icon: Icons.description),
                Text(
                  'Commons Clause + MIT License',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Non-commercial use with attribution required.',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 24),
                SectionTitle('Repository', icon: Icons.code),
                GestureDetector(
                  onTap: () {
                    _openUrl('https://github.com/DeuneB07/fchroma');
                  },
                  child: Text(
                    'github.com/DeuneB07/fchroma',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _openUrl(String url) {
    try {
      web.window.open(url, '_blank');
    } catch (e) {
      launchUrl(Uri.parse(url));
    }
  }
}
