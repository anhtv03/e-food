// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'ORDER FOOD';

  @override
  String get login => 'Login';

  @override
  String get loginTitle => 'Hello!';

  @override
  String get subLoginTitle => 'Sign in to continue';

  @override
  String get placeholderUsername => 'Username';

  @override
  String get placeholderPassword => 'Password';

  @override
  String get register => 'Register';

  @override
  String get comeBack => 'Come back';

  @override
  String get fullName => 'FullName';

  @override
  String get employeeId => 'Employee Id';

  @override
  String get accountName => 'Account Name';

  @override
  String get password => 'Password';

  @override
  String get fullNameBlank => 'FullName cannot be left blank';

  @override
  String get employeeIdBlank => 'Employee Id cannot be left blank';

  @override
  String get employeeIdInvalid => 'Invalid EmployeeId';

  @override
  String get usernameBlank => 'Username cannot be left blank';

  @override
  String get usernameInvalid => 'Account already exists';

  @override
  String get passwordBlank => 'Password cannot be left blank';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get createAccount => 'Create New Account';

  @override
  String get weeklyMeals => 'Meals for this week';

  @override
  String get noteOrder => 'Note: Please place your meal order no later than 10:00 AM';

  @override
  String get no1 => 'No.';

  @override
  String get dishName => 'Dish Name';

  @override
  String get supplyDate => 'Supply Date';

  @override
  String get status => 'Status';

  @override
  String get amount => 'Amount (VNĐ)';

  @override
  String formatAmount(Object amount) {
    return 'Amount: $amount₫';
  }

  @override
  String formatDate(Object date) {
    return 'Date: $date';
  }

  @override
  String welcomeUser(String name) {
    return 'Welcome, $name!';
  }

  @override
  String mealCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meals',
      one: '1 meal',
      zero: 'No meals',
    );
    return '$_temp0';
  }

  @override
  String get successRegister => 'Registration successful';

  @override
  String get failRegister => 'Registration failed';

  @override
  String get successLogin => 'Login successful';

  @override
  String get failLogin => 'Login failed';

  @override
  String get mealStatistics => 'Meal Statistics';

  @override
  String get orderHistory => 'Order History';

  @override
  String get month => 'Month';

  @override
  String get year => 'Year';

  @override
  String get search => 'Search';

  @override
  String totalAmount(String amount) {
    return 'Total amount for the month: $amount VND';
  }

  @override
  String get noData => 'No data';

  @override
  String get order => 'Order';

  @override
  String get ordered => 'Ordered';

  @override
  String get cancel => 'Cancel';

  @override
  String get expired => 'Expired';

  @override
  String get confirmCancel => 'Confirm Cancel Order';

  @override
  String get confirmOrder => 'Confirm Order';

  @override
  String confirmMsgCancel(Object mealName) {
    return 'Are you sure you want to cancel the meal $mealName?';
  }

  @override
  String confirmMsgOrder(Object mealName) {
    return 'Are you sure you want to order the meal $mealName?';
  }
}
