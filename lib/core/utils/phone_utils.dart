
import 'package:url_launcher/url_launcher.dart';

class PhoneUtils {

  static String formatPhoneNumber(String? number) {
    if (number == null || number.isEmpty) return '-';


    final digits = number.replaceAll(RegExp(r'[^\d+]'), '');


    if (digits.startsWith('+1')) {
      final clean = digits.substring(2);
      if (clean.length >= 10) {
        return '+1 (${clean.substring(0, 3)}) ${clean.substring(3, 6)}-${clean.substring(6)}';
      }
    }


    if (!digits.startsWith('+') && digits.length >= 10) {
      return '+1 (${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
    }

    return number;
  }


  static Future<void> makePhoneCall(String? number) async {
    if (number == null || number.isEmpty) return;

    final uri = Uri(scheme: 'tel', path: number.replaceAll(' ', ''));
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
