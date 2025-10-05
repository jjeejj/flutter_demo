import 'package:flutter_demo/shared/utils/logger.dart';
import 'package:url_launcher/url_launcher.dart';

void launchPhone(String phoneNumber) async {
  final url = Uri.parse('tel:$phoneNumber');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    LoggerHelper.e('can not lunch $url');
  }
}
