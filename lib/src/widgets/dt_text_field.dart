import 'package:drive_tales/src/design/dt_colors.dart';
import 'package:drive_tales/src/design/dt_text_styles.dart';
import 'package:flutter/material.dart';

class DTTextField extends StatefulWidget {
  const DTTextField({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    required this.controller,
    this.obscureText = false,
  });

  final String hint;
  final IconData? prefixIcon;
  final bool obscureText;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final IconData? suffixIcon;

  @override
  State<StatefulWidget> createState() => _DTTextFieldState();
}

class _DTTextFieldState extends State<DTTextField> {
  late FocusNode _node;

  final Color _focusedColor = DTColors.orange;
  final Color _unfocusedColor = DTColors.lightGrey;
  final Color _cursorColor = DTColors.orange;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _node = FocusNode();
    isFocused = _node.hasFocus;
    _node.addListener(() {
      setState(() {
        isFocused = _node.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: widget.prefixIcon != null,
          child: Row(
            children: [
              Icon(
                widget.prefixIcon,
                color: isFocused ? _focusedColor : _unfocusedColor,
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Expanded(
          child: TextFormField(
            cursorColor: _cursorColor,
            focusNode: _node,
            onTapOutside: (event) {
              _node.unfocus();
            },
            onChanged: widget.onChanged,
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: DTTextStyles.regularBody(
                color: DTColors.grey300,
              ),
              focusColor: _focusedColor,
              isDense: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: _unfocusedColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: _focusedColor),
              ),
            ),
            style: DTTextStyles.regularBody(
              color: isFocused ? _focusedColor : _unfocusedColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }
}
