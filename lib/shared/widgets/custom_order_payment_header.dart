import 'package:flutter/material.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_strings.dart';

class CustomOrderPaymentHeader extends StatelessWidget {
  const CustomOrderPaymentHeader({
    super.key,
    this.title = AppStrings.orderInfoTitle,
    this.currentStep = 1,
    this.totalSteps = 3,
    this.onBack,
    this.onStepTap,
  });

  final String title;
  final int currentStep; // 1-based
  final int totalSteps;
  final VoidCallback? onBack;
  final void Function(int step)? onStepTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              GestureDetector(
                onTap: onBack,
                child: Image.asset(
                  FigmaAssets.checkoutBackButton,
                  width: 48,
                  height: 48,
                ),
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004917),
                ),
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 21.5,
                backgroundColor: Color(0xFF900407),
                child: Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
        ),
        // Subtitle
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            AppStrings.stepOfTotal(currentStep, totalSteps),
            style: const TextStyle(
              color: Color(0xFF989793),
              fontSize: 15,
            ),
          ),
        ),
        // Progress indicators with dashed connector
        SizedBox(
          height: 72,
          child: Stack(
            children: [
              // Dashed line
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64),
                  child: CustomPaint(
                    painter: _DashedLinePainter(color: const Color(0xFF8A8A8A)),
                  ),
                ),
              ),
              // Step icons
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(totalSteps, (index) {
                      final step = index + 1;
                      final bool active = step == currentStep;
                      return GestureDetector(
                        onTap:
                            onStepTap == null ? null : () => onStepTap!(step),
                        child: _StepIcon(active: active, step: step),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StepIcon extends StatelessWidget {
  const _StepIcon({required this.active, required this.step});
  final bool active;
  final int step;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (step) {
      case 1:
        icon = Icons.place;
        break;
      case 2:
        icon = Icons.credit_card;
        break;
      default:
        icon = Icons.local_shipping_outlined;
    }
    const Color borderColor = Color(0xFF8A8A8A);
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: active ? const Color(0xFFFF6B00) : Colors.white,
        border: Border.all(color: borderColor, width: active ? 0 : 1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 24,
        color: active ? Colors.white : borderColor,
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  _DashedLinePainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const double dashWidth = 6;
    const double dashSpace = 6;
    double startX = 0;
    final double y = size.height / 2;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
