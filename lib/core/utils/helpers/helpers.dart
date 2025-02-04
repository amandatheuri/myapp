import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class THelper {
  
  // Helper function to show a simple dialog message
  static Future<void> showDialogMessage(BuildContext context, String title, String message) async {
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
  static bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9]+[a-zA-Z0-9._%+-]*@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
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
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith('0')) {
      return '+254${phoneNumber.substring(1)}'; // Prefix with +254 for Kenya
    } else if (phoneNumber.startsWith('+254')) {
      return phoneNumber;
    } else {
      return '+254$phoneNumber'; // Assuming it's a valid Kenyan phone number
    }
  }

  // Helper function to format a date into 'dd-MM-yyyy' format
  static String formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }

  // Helper function to check if the user is eligible for a reward based on tokens
  static bool isEligibleForReward(int tokenBalance) {
    return tokenBalance >= 100; // For example, users need at least 100 tokens to be eligible for a reward
  }

  // Helper function to calculate waste pickup cost based on waste quantity
  static double calculatePickupCost(int quantityInBags) {
    const double costPerBag = 50.0; // Example: 50 KES per bag
    return quantityInBags * costPerBag;
  }

  // Helper function to convert a list of waste types into human-readable format
  static String formatWasteTypeList(List<String> wasteTypes) {
    return wasteTypes.map((wasteType) => wasteType[0].toUpperCase() + wasteType.substring(1)).join(', ');
  }

  // Helper function to check if the user has provided all required information for a waste submission
  static bool isValidWasteSubmission(String wasteType, int quantity) {
    return isValidWasteType(wasteType) && isValidWasteQuantity(quantity);
  }
  
  // Helper function to show a snack bar with a message
  static void showSnackBar(BuildContext context, String message, {Duration duration = const Duration(seconds: 3)}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
      ),
    );
  }

  /// Validates the strength of a given password.
/// Returns null if the password is valid, otherwise returns an error message.
String? validatePassword(String password) {
  // Minimum password length requirement
  const int minLength = 8;

  // Check if the password is long enough
  if (password.length < minLength) {
    return 'Password must be at least $minLength characters long.';
  }

  // Check for at least one uppercase letter
  if (!RegExp(r'[A-Z]').hasMatch(password)) {
    return 'Password must contain at least one uppercase letter.';
  }

  // Check for at least one lowercase letter
  if (!RegExp(r'[a-z]').hasMatch(password)) {
    return 'Password must contain at least one lowercase letter.';
  }

  // Check for at least one digit
  if (!RegExp(r'[0-9]').hasMatch(password)) {
    return 'Password must contain at least one digit.';
  }

  // Check for at least one special character
  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
    return 'Password must contain at least one special character.';
  }

  // Check for spaces
  if (password.contains(' ')) {
    return 'Password must not contain spaces.';
  }

  // Password is valid
  return null;
}

}
