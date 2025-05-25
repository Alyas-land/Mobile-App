import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';




class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: Color(0xFF164A74),
      child: Icon(LineAwesomeIcons.telegram,
        size: 25,
        color: Color(0xFFB9FFFF),

      ),
      onPressed: () async {
        final telegramUri = Uri.parse('tg://resolve?domain=alyas_zone');

        if (await canLaunchUrl(telegramUri)) {
          await launchUrl(telegramUri);
        } else {
          final fallbackUrl = Uri.parse('https://t.me/alyas_msy');
          await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
        }

      },
    );
  }
}


