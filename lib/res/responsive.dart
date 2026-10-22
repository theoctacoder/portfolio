import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class Responsive {
  static const maxContentWidth = 1180.0;

  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;

  static bool isMobile(BuildContext context) => width(context) < 720;

  static bool isTablet(BuildContext context) => width(context) < 1080;

  static double gutter(BuildContext context) {
    final w = width(context);
    if (w < 720) return 16;
    if (w < 1080) return 32;
    return 48;
  }
}

Future<void> openUrl(String url) =>
    launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
