import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoptoo/shared/themes/colors.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool readOnly;
  final VoidCallback? onTap;
  final int? maxLines;
  final Color fillColor;
  final Color borderColor;
  final Color focusBorderColor;
  final Color labelColor;
  final Color hintColor;
  final Color textColor;
  final bool showLabel;

  const TextInputField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
    this.fillColor = const Color.fromARGB(255, 235, 233, 233),
    this.borderColor = Colors.transparent,
    this.focusBorderColor = Pallete.secondaryColor,
    this.labelColor = Pallete.lightPrimaryTextColor,
    // ignore: deprecated_member_use
    this.hintColor = Pallete.lightPrimaryTextColor,
    this.textColor = Pallete.lightPrimaryTextColor,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: labelColor,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          readOnly: readOnly,
          onTap: onTap,
          maxLines: maxLines,
          style: GoogleFonts.poppins(
            color: textColor,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
              fontSize: 12,
              color: hintColor,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: Pallete.lightPrimaryTextColor.withOpacity(0.7),
                  )
                : null,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: borderColor,
                width: borderColor == Colors.transparent ? 0 : 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: borderColor,
                width: borderColor == Colors.transparent ? 0 : 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: focusBorderColor,
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
          validator: validator,
        ),
      ],
    );
  }
}