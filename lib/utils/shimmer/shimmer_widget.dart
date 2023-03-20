import 'package:humble_warrior/hw.dart';

class CustomShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final margin;
  final child;
  final double? borderRadius;

  const CustomShimmer({super.key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.margin, this.child, this.borderRadius = 5
  });

  const CustomShimmer.rectangular({super.key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.margin, this.child, this.borderRadius = 5
  });

  const CustomShimmer.circular(
      {super.key, this.width = double.infinity,
        this.height = double.infinity,
        this.borderRadius = 100,
        this.margin, this.child});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: Colors.grey[400]!,
    highlightColor: Colors.grey[100]!,
    period: const Duration(seconds: 2),
    child: Container(
      margin: margin ?? 0.pa,
      width: width,
      height: height,
      child: child,
      decoration: BoxDecoration(
        color:  Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(borderRadius!),
      ),
    ),
  );
}