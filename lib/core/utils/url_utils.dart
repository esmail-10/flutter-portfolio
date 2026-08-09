import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlUtils {
  UrlUtils._();

  static Future<bool> open(String url) async {
    final uri = Uri.parse(url);
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }

  static String whatsappUrl(String number) {
    final digits = number.replaceAll(RegExp(r'[^\d]'), '');
    return 'https://wa.me/$digits';
  }
}

class SectionController extends ChangeNotifier {
  static final SectionController instance = SectionController._();
  SectionController._();

  final Map<String, GlobalKey> _keys = {};

  void register(String section, GlobalKey key) {
    _keys[section.toLowerCase()] = key;
  }

  void scrollTo(String section) {
    final key = _keys[section.toLowerCase()];
    final context = key?.currentContext;
    if (context == null) return;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      alignment: 0.08,
    );
  }
}
