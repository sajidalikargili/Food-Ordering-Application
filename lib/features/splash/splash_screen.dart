import 'package:code/features/splash/splash_service.dart';
import 'package:code/features/theme/bloc/theme_bloc.dart';
import 'package:code/features/theme/bloc/theme_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    SplashService.moveNext(context);
    context.read<ThemeBloc>().add(LoadTheme());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: SafeArea(
        child: Stack(
          children: [

            // =====================================================
            // BACKGROUND DECORATIONS
            // =====================================================



            // =====================================================
            // MAIN CONTENT
            // =====================================================

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  // =============
                  // ====================================
                  // FOOD LOGO CIRCLE
                  // =================================================

                  Container(
                    width: 190,
                    height: 190,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      // Theme-aware surface
                      color: colorScheme.surface,

                      border: Border.all(
                        color: colorScheme.primary.withOpacity(0.08),
                        width: 1,
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withOpacity(
                            isDark ? 0.08 : 0.04,
                          ),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),

                    child: Center(
                      child: _FoodLogo(
                        primaryColor: colorScheme.primary,
                        isDark: isDark,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // =================================================
                  // APP NAME
                  // =================================================

                  Text(
                    'Foodie',
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: colorScheme.primary,
                      letterSpacing: -1,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // =================================================
                  // SUBTITLE
                  // =================================================

                  Text(
                    'Delicious Food',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),

                  Text(
                    'At Your Doorstep',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 80),

                  // =================================================
                  // LOADING
                  // =================================================

                  SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        colorScheme.primary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 55),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // DECORATIVE FOOD ICON
  // ===============================================================

  Widget _foodIcon({
    required IconData icon,
    double? top,
    double? bottom,
    double? left,
    double? right,
    double size = 25,
  }) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Icon(
        icon,
        size: size,

        color: Theme.of(context)
            .colorScheme
            .primary
            .withOpacity(
          isDark ? 0.10 : 0.08,
        ),
      ),
    );
  }
}


// =================================================================
// FOOD LOGO
// =================================================================

class _FoodLogo extends StatelessWidget {
  final Color primaryColor;
  final bool isDark;

  const _FoodLogo({
    required this.primaryColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final darkColor = isDark
        ? const Color(0xFFE5E7EB)
        : const Color(0xFF252525);

    return SizedBox(
      width: 145,
      height: 145,
      child: Stack(
        alignment: Alignment.center,
        children: [

          // =======================================================
          // SERVING PLATE
          // =======================================================

          Positioned(
            bottom: 28,
            child: Container(
              width: 105,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor,
                  width: 5,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),

          // =======================================================
          // FOOD / CLOCHE
          // =======================================================

          Positioned(
            bottom: 42,
            child: Container(
              width: 72,
              height: 45,
              decoration: BoxDecoration(
                color: darkColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
            ),
          ),

          // =======================================================
          // CLOCHE HANDLE
          // =======================================================

          Positioned(
            top: 42,
            child: Container(
              width: 20,
              height: 10,
              decoration: BoxDecoration(
                color: darkColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          // =======================================================
          // CHEF HAT
          // =======================================================

          Positioned(
            top: 12,
            left: 38,
            child: SizedBox(
              width: 70,
              height: 60,
              child: CustomPaint(
                painter: _ChefHatPainter(
                  borderColor: darkColor,
                ),
              ),
            ),
          ),

          // =======================================================
          // ORANGE DECORATION
          // =======================================================

          Positioned(
            right: 10,
            top: 62,
            child: Transform.rotate(
              angle: -0.4,
              child: Container(
                width: 25,
                height: 6,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          Positioned(
            right: 5,
            top: 78,
            child: Container(
              width: 20,
              height: 5,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// =================================================================
// CHEF HAT PAINTER
// =================================================================

class _ChefHatPainter extends CustomPainter {
  final Color borderColor;

  _ChefHatPainter({
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final border = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = Path();

    // =============================================================
    // CHEF HAT
    // =============================================================

    path.moveTo(15, 45);

    path.cubicTo(
      5,
      38,
      8,
      25,
      18,
      23,
    );

    path.cubicTo(
      12,
      10,
      27,
      2,
      37,
      13,
    );

    path.cubicTo(
      45,
      0,
      62,
      7,
      58,
      21,
    );

    path.cubicTo(
      70,
      21,
      72,
      38,
      60,
      44,
    );

    path.lineTo(15, 45);

    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, border);

    // =============================================================
    // HAT BOTTOM
    // =============================================================

    final bottom = RRect.fromRectAndRadius(
      const Rect.fromLTWH(
        15,
        39,
        47,
        14,
      ),
      const Radius.circular(4),
    );

    canvas.drawRRect(bottom, paint);
    canvas.drawRRect(bottom, border);
  }

  @override
  bool shouldRepaint(
      covariant CustomPainter oldDelegate,
      ) {
    return false;
  }
}