import 'package:wingu/util/export_files.dart';

// ignore: must_be_immutable
class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.9),
      height: 8,
      width: isActive ? 28 : 8,
      decoration: BoxDecoration(
        border: Border.all(
          color: isActive ? ColorResources.getYellowColor() : Colors.white,
          width: 1,
        ),
        color: isActive ? ColorResources.getYellowColor() : Colors.white,
        
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
