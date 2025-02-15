import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class THelper {
  static String? validateTextFields(String? fieldName, String value) {
    if (value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Helper function to show a simple dialog message
  static Future<void> showDialogMessage(
      BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Helper function to validate an email format
  static String? isValidEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9]+[a-zA-Z0-9._%+-]*@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  // Helper function to validate if the waste quantity is within a valid range
  static bool isValidWasteQuantity(int quantity) {
    return quantity >= 1 && quantity <= 3;
  }

  // Helper function to validate that the waste type is correct
  static bool isValidWasteType(String wasteType) {
    List<String> validTypes = ['recyclable', 'organic', 'non-recyclable'];
    return validTypes.contains(wasteType.toLowerCase());
  }

  // Helper function to format a phone number (e.g., adding country code for Kenyan numbers)
  
  static String formatPhoneNumber(String value) {
  if (value.startsWith('0')) {
    return '+254${value.substring(1)}'; // Converts 07XX to +2547XX
  } else if (value.startsWith('+2540')) {
    return '+254${value.substring(5)}'; // Fixes incorrect +2540 format
  } else if (value.startsWith('+254')) {
    return value; // Already in correct format
  } else {
    return '+254$value'; // Prefixes non-Kenyan numbers with +254
  }
}

static String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number is required';  // ❌ Error message for empty input
  }
  if (!RegExp(r'^\+?(\d{9,12})$').hasMatch(value)) {
    return 'Enter a valid phone number'; // ❌ Error message for invalid numbers
  }
  return null; // ✅ Valid input
}

  // Helper function to format a date into 'dd-MM-yyyy' format
  static String formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }

  // Helper function to check if the user is eligible for a reward based on tokens
  static bool isEligibleForReward(int tokenBalance) {
    return tokenBalance >=
        100; // For example, users need at least 100 tokens to be eligible for a reward
  }

  // Helper function to calculate waste pickup cost based on waste quantity
  static double calculatePickupCost(int quantityInBags) {
    const double costPerBag = 50.0; // Example: 50 KES per bag
    return quantityInBags * costPerBag;
  }

  // Helper function to convert a list of waste types into human-readable format
  static String formatWasteTypeList(List<String> wasteTypes) {
    return wasteTypes
        .map((wasteType) => wasteType[0].toUpperCase() + wasteType.substring(1))
        .join(', ');
  }

  // Helper function to check if the user has provided all required information for a waste submission
  static bool isValidWasteSubmission(String wasteType, int quantity) {
    return isValidWasteType(wasteType) && isValidWasteQuantity(quantity);
  }

  // Helper function to show a snack bar with a message
  static void showSnackBar(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 3)}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
      ),
    );
  }

  /// Validates the strength of a given password.
  /// Returns null if the password is valid, otherwise returns an error message.
  static String? validatePassword(String? value) {
    // Minimum password length requirement
    const int minLength = 8;
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    // Check if the password is long enough
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters long, contain a special character and a digit.';
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter.';
    }

    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter.';
    }

    // Check for at least one digit
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit.';
    }

    // Check for at least one special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}_|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character.';
    }

    // Check for spaces
    if (value.contains(' ')) {
      return 'Password must not contain spaces.';
    }

    // Password is valid
    return null;
  }
}
