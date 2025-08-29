import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'ORDER FOOD'**
  String get appTitle;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Login screen title
  ///
  /// In en, this message translates to:
  /// **'Hello!'**
  String get loginTitle;

  /// Login screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get subLoginTitle;

  /// Placeholder for username field
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get placeholderUsername;

  /// Placeholder for password field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get placeholderPassword;

  /// Register button text
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Come back button text
  ///
  /// In en, this message translates to:
  /// **'Come back'**
  String get comeBack;

  /// FullName field label
  ///
  /// In en, this message translates to:
  /// **'FullName'**
  String get fullName;

  /// FullName field label
  ///
  /// In en, this message translates to:
  /// **'Employee Id'**
  String get employeeId;

  /// FullName field label
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get accountName;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @fullNameBlank.
  ///
  /// In en, this message translates to:
  /// **'FullName cannot be left blank'**
  String get fullNameBlank;

  /// Validation error message for employeeId
  ///
  /// In en, this message translates to:
  /// **'Employee Id cannot be left blank'**
  String get employeeIdBlank;

  /// Validation error message for employeeId
  ///
  /// In en, this message translates to:
  /// **'Invalid EmployeeId'**
  String get employeeIdInvalid;

  /// No description provided for @usernameBlank.
  ///
  /// In en, this message translates to:
  /// **'Username cannot be left blank'**
  String get usernameBlank;

  /// Validation error message for username
  ///
  /// In en, this message translates to:
  /// **'Account already exists'**
  String get usernameInvalid;

  /// No description provided for @passwordBlank.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be left blank'**
  String get passwordBlank;

  /// Validation error message for password
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// Forgot password link text
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// Create new account button text
  ///
  /// In en, this message translates to:
  /// **'Create New Account'**
  String get createAccount;

  /// Weekly meals screen title
  ///
  /// In en, this message translates to:
  /// **'Meals for this week'**
  String get weeklyMeals;

  /// No description provided for @noteOrder.
  ///
  /// In en, this message translates to:
  /// **'Note: Please place your meal order no later than 10:00 AM'**
  String get noteOrder;

  /// No.
  ///
  /// In en, this message translates to:
  /// **'No.'**
  String get no1;

  /// Dish Name field label
  ///
  /// In en, this message translates to:
  /// **'Dish Name'**
  String get dishName;

  /// Supply Date field label
  ///
  /// In en, this message translates to:
  /// **'Supply Date'**
  String get supplyDate;

  /// Status field label
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// Amount field label
  ///
  /// In en, this message translates to:
  /// **'Amount (VNĐ)'**
  String get amount;

  /// No description provided for @formatAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount: {amount}₫'**
  String formatAmount(Object amount);

  /// No description provided for @formatDate.
  ///
  /// In en, this message translates to:
  /// **'Date: {date}'**
  String formatDate(Object date);

  /// Welcome message with user name
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}!'**
  String welcomeUser(String name);

  /// Display meal count with pluralization
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No meals} =1{1 meal} other{{count} meals}}'**
  String mealCount(int count);

  /// Success message for registration
  ///
  /// In en, this message translates to:
  /// **'Registration successful'**
  String get successRegister;

  /// Fail message for registration
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get failRegister;

  /// Success message for login
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get successLogin;

  /// Fail message for login
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get failLogin;

  /// No description provided for @mealStatistics.
  ///
  /// In en, this message translates to:
  /// **'Meal Statistics'**
  String get mealStatistics;

  /// No description provided for @orderHistory.
  ///
  /// In en, this message translates to:
  /// **'Order History'**
  String get orderHistory;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total amount for the month: {amount} VND'**
  String totalAmount(String amount);

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @ordered.
  ///
  /// In en, this message translates to:
  /// **'Ordered'**
  String get ordered;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @confirmCancel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Cancel Order'**
  String get confirmCancel;

  /// No description provided for @confirmOrder.
  ///
  /// In en, this message translates to:
  /// **'Confirm Order'**
  String get confirmOrder;

  /// No description provided for @confirmMsgCancel.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel the meal {mealName}?'**
  String confirmMsgCancel(Object mealName);

  /// No description provided for @confirmMsgOrder.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to order the meal {mealName}?'**
  String confirmMsgOrder(Object mealName);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
