import 'package:intl/intl.dart';

class TFormatter {
  // Formats the date as dd-MM-yyyy
  static String formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }

  // Formats the time as HH:mm
  static String formatTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('HH:mm');
    return formatter.format(dateTime);
  }

  // Formats the date and time as dd-MM-yyyy HH:mm
  static String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
    return formatter.format(dateTime);
  }
}

class WasteQuantityFormatter {
  // Formats the waste quantity into a readable string (e.g., 1/4 Bag, 1/2 Bag)
  static String formatWasteQuantity(int quantityInBags) {
    switch (quantityInBags) {
      case 1:
        return '1/4 Bag';
      case 2:
        return '1/2 Bag';
      case 3:
        return '3/4 Bag';
      case 4:
        return '1 Full Bag';
      default:
        return 'Unknown Quantity';
    }
  }
}

class WasteTypeFormatter {
  // Formats the waste type into a human-readable string (e.g., Recyclable Waste, Organic Waste)
  static String formatWasteType(String wasteType) {
    switch (wasteType) {
      case 'recyclable':
        return 'Recyclable Waste';
      case 'organic':
        return 'Organic Waste';
      case 'non-recyclable':
        return 'Non-Recyclable Waste';
      default:
        return 'Unknown Waste Type';
    }
  }
}

class TokenFormatter {
  // Formats the token balance into a readable format
  static String formatTokenBalance(int tokenBalance) {
    return 'Tokens: $tokenBalance';
  }

  // Formats token reward message
  static String formatTokenReward(int rewardTokens) {
    return 'You have earned $rewardTokens tokens!';
  }
}

class CurrencyFormatter {
  // Formats a given amount into Kenyan Shilling currency format (KES)
  static String formatCurrency(double amount) {
    final NumberFormat currencyFormatter = NumberFormat.simpleCurrency(name: 'KES');
    return currencyFormatter.format(amount);
  }
}

class UserProfileFormatter {
  // Formats the user's full name
  static String formatUserName(String firstName, String lastName) {
    return '$firstName $lastName';
  }

  // Formats the user's email to lowercase
  static String formatUserEmail(String email) {
    return email.toLowerCase();
  }
}

class WasteSubmissionFormatter {
  // Formats a waste submission summary with waste type, quantity, and date
  static String formatWasteSubmissionSummary(
      String wasteType, int quantityInBags, DateTime date) {
    String formattedDate = TFormatter.formatDate(date);
    String formattedQuantity = WasteQuantityFormatter.formatWasteQuantity(quantityInBags);
    String formattedWasteType = WasteTypeFormatter.formatWasteType(wasteType);
    
    return '$formattedDate: $formattedWasteType - $formattedQuantity';
  }
}
