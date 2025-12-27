import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoptoo/shared/themes/colors.dart';

class PasswordInputField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Color fillColor;
  final Color borderColor;
  final Color focusBorderColor;
  final Color labelColor;
  final Color hintColor;
  final Color textColor;
  final bool showLabel;

  const PasswordInputField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.validator,
    this.fillColor = const Color.fromARGB(255, 235, 233, 233),
    this.borderColor = Colors.transparent,
    this.focusBorderColor = Pallete.secondaryColor,
    this.labelColor = Pallete.lightPrimaryTextColor,
    this.hintColor = Pallete.lightPrimaryTextColor,
    this.textColor = Pallete.lightPrimaryTextColor,
    this.showLabel = true,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel) ...[
          Text(
            widget.label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: widget.labelColor,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          style: GoogleFonts.poppins(
            color: widget.textColor,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: GoogleFonts.poppins(
              fontSize: 12,
              color: widget.hintColor,
            ),
            prefixIcon: Icon(
              Icons.lock_outline,
              color: Pallete.lightPrimaryTextColor.withOpacity(0.7),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: Pallete.lightPrimaryTextColor.withOpacity(0.7),
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            filled: true,
            fillColor: widget.fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: widget.borderColor,
                width: widget.borderColor == Colors.transparent ? 0 : 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: widget.borderColor,
                width: widget.borderColor == Colors.transparent ? 0 : 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: widget.focusBorderColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
          ),
          validator: widget.validator ?? (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
      ],
    );
  }
}