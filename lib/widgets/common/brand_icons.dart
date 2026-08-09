import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class _SocialBrandIcon extends StatelessWidget {
  final Widget icon;
  final String? url;
  final String? tooltip;
  final double borderRadius;

  const _SocialBrandIcon({
    required this.icon,
    this.url,
    this.tooltip,
    this.borderRadius = 6.0,
  });

  Future<void> _openUrl() async {
    if (url == null || url!.trim().isEmpty) return;

    final uri = Uri.tryParse(url!);

    if (uri == null) return;

    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    Widget result = icon;

    if (url != null && url!.trim().isNotEmpty) {
      result = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(onTap: _openUrl, child: result),
      );
    }

    // Add tooltip only when valid text exists.
    if (tooltip != null && tooltip!.trim().isNotEmpty) {
      result = Tooltip(message: tooltip!, child: result);
    }

    return result;
  }
}

class GitHubBrandIcon extends StatelessWidget {
  final double size;
  final Color color;
  final String? url;
  final String? tooltip;

  const GitHubBrandIcon({
    super.key,
    this.size = 18.0,
    this.color = Colors.white,
    this.url,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return _SocialBrandIcon(
      url: url,
      tooltip: tooltip,
      icon: CustomPaint(
        size: Size(size, size),
        painter: _GitHubBrandPainter(color),
      ),
    );
  }
}

class _GitHubBrandPainter extends CustomPainter {
  final Color color;

  _GitHubBrandPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24.0;
    canvas.scale(scale, scale);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final path = Path()
      ..moveTo(12, 0)
      ..cubicTo(5.37, 0, 0, 5.37, 0, 12)
      ..cubicTo(0, 17.31, 3.435, 21.795, 8.205, 23.385)
      ..cubicTo(8.805, 23.49, 9.03, 23.13, 9.03, 22.815)
      ..cubicTo(9.03, 22.53, 9.015, 21.585, 9.015, 20.58)
      ..cubicTo(5.7, 21.3, 5, 19.01, 4.76, 18.335)
      ..cubicTo(4.625, 17.99, 4.04, 16.925, 3.53, 16.64)
      ..cubicTo(3.11, 16.415, 2.51, 15.86, 3.515, 15.845)
      ..cubicTo(4.46, 15.83, 5.135, 16.715, 5.36, 17.075)
      ..cubicTo(6.44, 18.89, 8.165, 18.38, 8.855, 18.065)
      ..cubicTo(8.96, 17.285, 9.275, 16.76, 9.62, 16.46)
      ..cubicTo(6.95, 16.16, 4.16, 15.125, 4.16, 10.535)
      ..cubicTo(4.16, 9.23, 4.625, 8.15, 5.39, 7.31)
      ..cubicTo(5.27, 7.01, 4.85, 5.78, 5.51, 4.13)
      ..cubicTo(5.51, 4.13, 6.515, 3.815, 8.81, 5.37)
      ..cubicTo(9.77, 5.1, 10.79, 4.965, 11.81, 4.965)
      ..cubicTo(12.83, 4.965, 13.85, 5.1, 14.81, 5.37)
      ..cubicTo(17.105, 3.815, 18.11, 4.13, 18.11, 4.13)
      ..cubicTo(18.77, 5.78, 18.35, 7.01, 18.23, 7.31)
      ..cubicTo(18.995, 8.15, 19.46, 9.215, 19.46, 10.535)
      ..cubicTo(19.46, 15.14, 16.655, 16.155, 13.985, 16.455)
      ..cubicTo(14.42, 16.83, 14.795, 17.55, 14.795, 18.675)
      ..cubicTo(14.795, 20.28, 14.78, 21.57, 14.78, 21.975)
      ..cubicTo(14.78, 22.29, 15.005, 22.665, 15.605, 22.545)
      ..cubicTo(20.375, 20.955, 23.81, 16.47, 23.81, 11.955)
      ..cubicTo(23.81, 5.37, 18.44, 0, 12, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _GitHubBrandPainter oldDelegate) =>
      oldDelegate.color != color;
}

class LinkedInBrandIcon extends StatelessWidget {
  final double size;
  final Color color;
  final String? url;
  final String? tooltip;

  const LinkedInBrandIcon({
    super.key,
    this.size = 18.0,
    this.color = Colors.white,
    this.url,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return _SocialBrandIcon(
      url: url,
      tooltip: tooltip,
      icon: CustomPaint(
        size: Size(size, size),
        painter: _LinkedInBrandPainter(color),
      ),
    );
  }
}

class _LinkedInBrandPainter extends CustomPainter {
  final Color color;

  _LinkedInBrandPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24.0;
    canvas.scale(scale, scale);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final path = Path()
      ..moveTo(19, 3)
      ..cubicTo(20.1, 3, 21, 3.9, 21, 5)
      ..lineTo(21, 19)
      ..cubicTo(21, 20.1, 20.1, 21, 19, 21)
      ..lineTo(5, 21)
      ..cubicTo(3.9, 21, 3, 20.1, 3, 19)
      ..lineTo(3, 5)
      ..cubicTo(3, 3.9, 3.9, 3, 5, 3)
      ..lineTo(19, 3)
      ..moveTo(18.5, 18.5)
      ..lineTo(18.5, 13.2)
      ..cubicTo(18.5, 11.4, 17.1, 9.94, 15.24, 9.94)
      ..cubicTo(14.39, 9.94, 13.4, 10.46, 12.96, 11.24)
      ..lineTo(12.96, 10.13)
      ..lineTo(10.17, 10.13)
      ..lineTo(10.17, 18.5)
      ..lineTo(12.96, 18.5)
      ..lineTo(12.96, 13.57)
      ..cubicTo(12.96, 12.8, 13.58, 12.17, 14.35, 12.17)
      ..cubicTo(15.12, 12.17, 15.75, 12.8, 15.75, 13.57)
      ..lineTo(15.75, 18.5)
      ..lineTo(18.5, 18.5)
      ..moveTo(6.46, 10.13)
      ..lineTo(6.46, 18.5)
      ..lineTo(9.25, 18.5)
      ..lineTo(9.25, 10.13)
      ..lineTo(6.46, 10.13)
      ..moveTo(7.86, 5.98)
      ..cubicTo(6.98, 5.98, 6.26, 6.7, 6.26, 7.58)
      ..cubicTo(6.26, 8.46, 6.98, 9.18, 7.86, 9.18)
      ..cubicTo(8.74, 9.18, 9.46, 8.46, 9.46, 7.58)
      ..cubicTo(9.46, 6.7, 8.74, 5.98, 7.86, 5.98)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _LinkedInBrandPainter oldDelegate) =>
      oldDelegate.color != color;
}

class WhatsAppBrandIcon extends StatelessWidget {
  final double size;
  final Color color;
  final String? url;
  final String? tooltip;

  const WhatsAppBrandIcon({
    super.key,
    this.size = 18.0,
    this.color = Colors.white,
    this.url,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return _SocialBrandIcon(
      url: url,
      tooltip: tooltip,
      icon: CustomPaint(
        size: Size(size, size),
        painter: _WhatsAppBrandPainter(color),
      ),
    );
  }
}

class _WhatsAppBrandPainter extends CustomPainter {
  final Color color;

  _WhatsAppBrandPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24.0;
    canvas.scale(scale, scale);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final path = Path()
      ..moveTo(12.012, 2)
      ..cubicTo(6.506, 2, 2.023, 6.478, 2.023, 11.984)
      ..cubicTo(2.023, 13.742, 2.482, 15.453, 3.355, 16.962)
      ..lineTo(2, 22)
      ..lineTo(7.223, 20.666)
      ..cubicTo(8.683, 21.46, 10.33, 21.895, 12.012, 21.895)
      ..cubicTo(17.518, 21.895, 22, 17.416, 22, 11.91)
      ..cubicTo(22, 6.404, 17.518, 2, 12.012, 2)
      ..close()
      ..moveTo(17.832, 16.372)
      ..cubicTo(17.588, 17.058, 16.412, 17.684, 15.864, 17.75)
      ..cubicTo(15.316, 17.816, 14.605, 17.844, 12.222, 16.874)
      ..cubicTo(9.351, 15.706, 7.502, 12.788, 7.359, 12.596)
      ..cubicTo(7.216, 12.405, 6.196, 11.049, 6.196, 9.646)
      ..cubicTo(6.196, 8.243, 6.928, 7.552, 7.188, 7.266)
      ..cubicTo(7.447, 6.981, 7.755, 6.91, 7.944, 6.91)
      ..cubicTo(8.133, 6.91, 8.322, 6.912, 8.488, 6.92)
      ..cubicTo(8.664, 6.929, 8.902, 6.853, 9.135, 7.413)
      ..cubicTo(9.379, 8.0, 9.965, 9.439, 10.037, 9.586)
      ..cubicTo(10.109, 9.732, 10.157, 9.903, 10.061, 10.095)
      ..cubicTo(9.965, 10.287, 9.917, 10.407, 9.773, 10.576)
      ..cubicTo(9.629, 10.744, 9.47, 10.952, 9.34, 11.08)
      ..cubicTo(9.196, 11.224, 9.046, 11.382, 9.214, 11.67)
      ..cubicTo(9.382, 11.958, 9.961, 12.903, 10.817, 13.665)
      ..cubicTo(11.917, 14.645, 12.845, 14.95, 13.133, 15.094)
      ..cubicTo(13.421, 15.238, 13.589, 15.214, 13.757, 15.022)
      ..cubicTo(13.925, 14.83, 14.477, 14.182, 14.669, 13.894)
      ..cubicTo(14.861, 13.606, 15.053, 13.654, 15.317, 13.75)
      ..cubicTo(15.581, 13.846, 16.997, 14.542, 17.285, 14.686)
      ..cubicTo(17.573, 14.83, 17.765, 14.902, 17.837, 15.022)
      ..cubicTo(17.909, 15.142, 17.909, 15.718, 17.665, 16.404)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WhatsAppBrandPainter oldDelegate) =>
      oldDelegate.color != color;
}

class EmailIcon extends StatelessWidget {
  final double size;
  final Color color;
  final String email;
  final String? tooltip;

  const EmailIcon({
    super.key,
    this.size = 18,
    this.color = Colors.white,
    required this.email,
    this.tooltip,
  });

  Future<void> _sendEmail() async {
    final uri = Uri(scheme: 'mailto', path: email);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget icon = Icon(Icons.email_outlined, size: size, color: color);

    if (tooltip != null && tooltip!.trim().isNotEmpty) {
      icon = Tooltip(message: tooltip!, child: icon);
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(onTap: _sendEmail, child: icon),
    );
  }
}
