import 'package:drive_tales/src/design/dt_colors.dart';
import 'package:flutter/material.dart';

class DTButton extends StatefulWidget {
  const DTButton({
    super.key,
    this.height,
    this.width,
    this.onPressed,
    this.child,
    this.backgroundColor = DTColors.opal,
  });

  final double? height;
  final double? width;
  final Widget? child;
  final VoidCallback? onPressed;
  final Color backgroundColor;

  @override
  State<StatefulWidget> createState() => _DTButtonState();
}

class _DTButtonState extends State<DTButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )
        ),

        child: widget.child,
      ),
    );
  }
}
