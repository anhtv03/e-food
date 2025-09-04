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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'ORDER FOOD'**
  String get appTitle;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Hello!'**
  String get loginTitle;

  /// No description provided for @subLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get subLoginTitle;

  /// No description provided for @placeholderUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get placeholderUsername;

  /// No description provided for @placeholderPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get placeholderPassword;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @comeBack.
  ///
  /// In en, this message translates to:
  /// **'Come back'**
  String get comeBack;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'FullName'**
  String get fullName;

  /// No description provided for @employeeId.
  ///
  /// In en, this message translates to:
  /// **'Employee Id'**
  String get employeeId;

  /// No description provided for @accountName.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get accountName;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @fullNameBlank.
  ///
  /// In en, this message translates to:
  /// **'FullName cannot be left blank'**
  String get fullNameBlank;

  /// No description provided for @employeeIdBlank.
  ///
  /// In en, this message translates to:
  /// **'Employee Id cannot be left blank'**
  String get employeeIdBlank;

  /// No description provided for @employeeIdInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid EmployeeId'**
  String get employeeIdInvalid;

  /// No description provided for @usernameBlank.
  ///
  /// In en, this message translates to:
  /// **'Username cannot be left blank'**
  String get usernameBlank;

  /// No description provided for @usernameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Account already exists'**
  String get usernameInvalid;

  /// No description provided for @passwordBlank.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be left blank'**
  String get passwordBlank;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create New Account'**
  String get createAccount;

  /// No description provided for @weeklyMeals.
  ///
  /// In en, this message translates to:
  /// **'Meals for this week'**
  String get weeklyMeals;

  /// No description provided for @noteOrder.
  ///
  /// In en, this message translates to:
  /// **'Note: Please place your meal order no later than 10:00 AM'**
  String get noteOrder;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @dishName.
  ///
  /// In en, this message translates to:
  /// **'Dish Name'**
  String get dishName;

  /// No description provided for @supplyDate.
  ///
  /// In en, this message translates to:
  /// **'Supply Date'**
  String get supplyDate;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @amount.
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

  /// No description provided for @welcomeUser.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}!'**
  String welcomeUser(Object name);

  /// No description provided for @mealCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No meals} =1{1 meal} other{{count} meals}}'**
  String mealCount(num count);

  /// No description provided for @successRegister.
  ///
  /// In en, this message translates to:
  /// **'Registration successful'**
  String get successRegister;

  /// No description provided for @failRegister.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get failRegister;

  /// No description provided for @successLogin.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get successLogin;

  /// No description provided for @failLogin.
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
  String totalAmount(Object amount);

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

  /// No description provided for @usernameIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Username cannot be empty'**
  String get usernameIsEmpty;

  /// No description provided for @passwordIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be empty'**
  String get passwordIsEmpty;

  /// No description provided for @incorrectInputLogin.
  ///
  /// In en, this message translates to:
  /// **'You entered an incorrect username or password!'**
  String get incorrectInputLogin;

  /// No description provided for @loginFailedServer.
  ///
  /// In en, this message translates to:
  /// **'Login failed due to system error'**
  String get loginFailedServer;

  /// No description provided for @fillFullName.
  ///
  /// In en, this message translates to:
  /// **'Please enter full name'**
  String get fillFullName;

  /// No description provided for @fillEmployeeId.
  ///
  /// In en, this message translates to:
  /// **'Please enter employee ID'**
  String get fillEmployeeId;

  /// No description provided for @fillUsername.
  ///
  /// In en, this message translates to:
  /// **'Please enter username'**
  String get fillUsername;

  /// No description provided for @fillPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get fillPassword;

  /// No description provided for @passwordMinCharacters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinCharacters;

  /// No description provided for @registrationSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Registration successful!'**
  String get registrationSuccessful;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get errorOccurred;

  /// No description provided for @loadFailedHistory.
  ///
  /// In en, this message translates to:
  /// **'Failed to load order history'**
  String get loadFailedHistory;

  /// No description provided for @failedRenewHistory.
  ///
  /// In en, this message translates to:
  /// **'Failed to refresh history'**
  String get failedRenewHistory;

  /// No description provided for @cantOrder.
  ///
  /// In en, this message translates to:
  /// **'Cannot order'**
  String get cantOrder;

  /// No description provided for @cantCancel.
  ///
  /// In en, this message translates to:
  /// **'Cannot cancel order'**
  String get cantCancel;

  /// No description provided for @noOrdered.
  ///
  /// In en, this message translates to:
  /// **'Please place your first order!'**
  String get noOrdered;

  /// No description provided for @updateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Update successful'**
  String get updateSuccess;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @unconfirm.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get unconfirm;

  /// No description provided for @chooseOtherYear.
  ///
  /// In en, this message translates to:
  /// **'Please choose another month/year to view statistics'**
  String get chooseOtherYear;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get yes;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
