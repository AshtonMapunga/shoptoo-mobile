import 'package:flutter/material.dart';


class GeneralHelpers {
  // Method to navigate to another screen with back function
  static void temporaryNavigator(BuildContext context, Widget nextScreen) {
    Navigator.push(context, MaterialPageRoute(builder: (c) => nextScreen));
  }

  // Method to navigate to another screen without back function
  static void permanentNavigator(BuildContext context, Widget nextScreen) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (c) => nextScreen));
  }

  // Method to navigate to previous screen
  static void back(BuildContext context) {
    Navigator.pop(context);
  }



  static String formatTimeDifference(String isoDateTime) {
    DateTime givenTime = DateTime.parse(isoDateTime);
    DateTime currentTime = DateTime.now();
    Duration diff = currentTime.difference(givenTime);

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} minutes ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hours ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else if (diff.inDays < 30) {
      int weeks = (diff.inDays / 7).round();
      return '$weeks weeks ago';
    } else {
      int months = (diff.inDays / 30).round();
      return '$months months ago';
    }
  }

  // Function to check if a string represents a numeric value
  static bool isNumeric(String str) {
    return double.tryParse(str) != null;
  }

  // Function to check if a string represents an integer value
  static bool isInteger(String str) {
    final pattern = RegExp(r'^[0-9]+$');
    return pattern.hasMatch(str);
  }

  static bool isEmail(String email) {
    final pattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return pattern.hasMatch(email);
  }

  static bool isStrongPassword(String password) {
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);

    // Check for at least one lowercase letter
    final hasLowercase = RegExp(r'[a-z]').hasMatch(password);

    // Check for at least one number
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);

    // Check for at least one special character
    final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

    // Return true if all criteria are met
    return hasUppercase && hasLowercase && hasNumber && hasSpecialChar;
  }


}

