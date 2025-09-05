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
  /// In vi, this message translates to:
  /// **'ĐẶT CƠM'**
  String get appTitle;

  /// No description provided for @login.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In vi, this message translates to:
  /// **'Đăng xuất'**
  String get logout;

  /// No description provided for @loginTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xin chào!'**
  String get loginTitle;

  /// No description provided for @subLoginTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập để tiếp tục'**
  String get subLoginTitle;

  /// No description provided for @placeholderUsername.
  ///
  /// In vi, this message translates to:
  /// **'Tên đăng nhập'**
  String get placeholderUsername;

  /// No description provided for @placeholderPassword.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu'**
  String get placeholderPassword;

  /// No description provided for @register.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký'**
  String get register;

  /// No description provided for @comeBack.
  ///
  /// In vi, this message translates to:
  /// **'Quay lại'**
  String get comeBack;

  /// No description provided for @fullName.
  ///
  /// In vi, this message translates to:
  /// **'Tên đầy đủ'**
  String get fullName;

  /// No description provided for @employeeId.
  ///
  /// In vi, this message translates to:
  /// **'Mã nhân viên'**
  String get employeeId;

  /// No description provided for @accountName.
  ///
  /// In vi, this message translates to:
  /// **'Tên tài khoản'**
  String get accountName;

  /// No description provided for @password.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu'**
  String get password;

  /// No description provided for @fullNameBlank.
  ///
  /// In vi, this message translates to:
  /// **'Tên đầy đủ không được để trống'**
  String get fullNameBlank;

  /// No description provided for @employeeIdBlank.
  ///
  /// In vi, this message translates to:
  /// **'Mã nhân viên không được để trống'**
  String get employeeIdBlank;

  /// No description provided for @employeeIdInvalid.
  ///
  /// In vi, this message translates to:
  /// **'Mã nhân viên không hợp lệ'**
  String get employeeIdInvalid;

  /// No description provided for @usernameBlank.
  ///
  /// In vi, this message translates to:
  /// **'Tên tài khoản không được để trống'**
  String get usernameBlank;

  /// No description provided for @usernameInvalid.
  ///
  /// In vi, this message translates to:
  /// **'Tên tài khoản đã tồn tại'**
  String get usernameInvalid;

  /// No description provided for @passwordBlank.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu không được để trống'**
  String get passwordBlank;

  /// No description provided for @passwordTooShort.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu phải có ít nhất 6 ký tự'**
  String get passwordTooShort;

  /// No description provided for @forgotPassword.
  ///
  /// In vi, this message translates to:
  /// **'Quên mật khẩu?'**
  String get forgotPassword;

  /// No description provided for @createAccount.
  ///
  /// In vi, this message translates to:
  /// **'Tạo tài khoản mới'**
  String get createAccount;

  /// No description provided for @weeklyMeals.
  ///
  /// In vi, this message translates to:
  /// **'Món ăn trong tuần này'**
  String get weeklyMeals;

  /// No description provided for @noteOrder.
  ///
  /// In vi, this message translates to:
  /// **'Lưu ý: đặt cơm chậm nhất trước 10:00 AM'**
  String get noteOrder;

  /// No description provided for @no.
  ///
  /// In vi, this message translates to:
  /// **'STT'**
  String get no;

  /// No description provided for @dishName.
  ///
  /// In vi, this message translates to:
  /// **'Tên món'**
  String get dishName;

  /// No description provided for @supplyDate.
  ///
  /// In vi, this message translates to:
  /// **'Ngày cung cấp'**
  String get supplyDate;

  /// No description provided for @status.
  ///
  /// In vi, this message translates to:
  /// **'Trạng thái'**
  String get status;

  /// No description provided for @amount.
  ///
  /// In vi, this message translates to:
  /// **'Giá (VNĐ)'**
  String get amount;

  /// No description provided for @formatAmount.
  ///
  /// In vi, this message translates to:
  /// **'Giá: {amount}₫'**
  String formatAmount(Object amount);

  /// No description provided for @formatDate.
  ///
  /// In vi, this message translates to:
  /// **'Ngày: {date}'**
  String formatDate(Object date);

  /// No description provided for @welcomeUser.
  ///
  /// In vi, this message translates to:
  /// **'Xin chào, {name}!'**
  String welcomeUser(Object name);

  /// No description provided for @mealCount.
  ///
  /// In vi, this message translates to:
  /// **'{count, plural, =0{Không có bữa ăn nào} =1{1 bữa ăn} other{{count} bữa ăn}}'**
  String mealCount(num count);

  /// No description provided for @successRegister.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký thành công'**
  String get successRegister;

  /// No description provided for @failRegister.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký thất bại'**
  String get failRegister;

  /// No description provided for @successLogin.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập thành công'**
  String get successLogin;

  /// No description provided for @failLogin.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập thất bại'**
  String get failLogin;

  /// No description provided for @mealStatistics.
  ///
  /// In vi, this message translates to:
  /// **'Thống kê suất ăn'**
  String get mealStatistics;

  /// No description provided for @orderHistory.
  ///
  /// In vi, this message translates to:
  /// **'Lịch sử đặt món'**
  String get orderHistory;

  /// No description provided for @month.
  ///
  /// In vi, this message translates to:
  /// **'Tháng'**
  String get month;

  /// No description provided for @year.
  ///
  /// In vi, this message translates to:
  /// **'Năm'**
  String get year;

  /// No description provided for @search.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm'**
  String get search;

  /// No description provided for @totalAmount.
  ///
  /// In vi, this message translates to:
  /// **'Tổng tiền trong tháng: {amount} VND'**
  String totalAmount(Object amount);

  /// No description provided for @noData.
  ///
  /// In vi, this message translates to:
  /// **'Không có dữ liệu'**
  String get noData;

  /// No description provided for @order.
  ///
  /// In vi, this message translates to:
  /// **'Đặt món'**
  String get order;

  /// No description provided for @ordered.
  ///
  /// In vi, this message translates to:
  /// **'Đã đặt'**
  String get ordered;

  /// No description provided for @cancel.
  ///
  /// In vi, this message translates to:
  /// **'Hủy món'**
  String get cancel;

  /// No description provided for @expired.
  ///
  /// In vi, this message translates to:
  /// **'Hết hạn'**
  String get expired;

  /// No description provided for @confirmCancel.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận hủy món'**
  String get confirmCancel;

  /// No description provided for @confirmOrder.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận đặt món'**
  String get confirmOrder;

  /// No description provided for @confirmMsgCancel.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn huỷ món {mealName} không?'**
  String confirmMsgCancel(Object mealName);

  /// No description provided for @confirmMsgOrder.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn đặt món {mealName} không?'**
  String confirmMsgOrder(Object mealName);

  /// No description provided for @usernameIsEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Tên đăng nhập không được để trống'**
  String get usernameIsEmpty;

  /// No description provided for @passwordIsEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu không được để trống'**
  String get passwordIsEmpty;

  /// No description provided for @incorrectInputLogin.
  ///
  /// In vi, this message translates to:
  /// **'Bạn nhập sai tên tài khoản hoặc mật khẩu!'**
  String get incorrectInputLogin;

  /// No description provided for @loginFailedServer.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập thất bại do lỗi hệ thống'**
  String get loginFailedServer;

  /// No description provided for @fillFullName.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập tên đầy đủ'**
  String get fillFullName;

  /// No description provided for @fillEmployeeId.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập mã nhân viên'**
  String get fillEmployeeId;

  /// No description provided for @fillUsername.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập tên tài khoản'**
  String get fillUsername;

  /// No description provided for @fillPassword.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập mật khẩu'**
  String get fillPassword;

  /// No description provided for @passwordMinCharacters.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu phải có ít nhất 6 ký tự'**
  String get passwordMinCharacters;

  /// No description provided for @registrationSuccessful.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký thành công!'**
  String get registrationSuccessful;

  /// No description provided for @errorOccurred.
  ///
  /// In vi, this message translates to:
  /// **'Đã có lỗi xảy ra. Vui lòng thử lại.'**
  String get errorOccurred;

  /// No description provided for @loadFailedHistory.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải lịch sử đặt món'**
  String get loadFailedHistory;

  /// No description provided for @failedRenewHistory.
  ///
  /// In vi, this message translates to:
  /// **'Không thể làm mới lịch sử'**
  String get failedRenewHistory;

  /// No description provided for @cantOrder.
  ///
  /// In vi, this message translates to:
  /// **'Không thể đặt món'**
  String get cantOrder;

  /// No description provided for @cantCancel.
  ///
  /// In vi, this message translates to:
  /// **'Không thể hủy món'**
  String get cantCancel;

  /// No description provided for @noOrdered.
  ///
  /// In vi, this message translates to:
  /// **'Hãy đặt món đầu tiên của bạn!'**
  String get noOrdered;

  /// No description provided for @updateSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật thành công'**
  String get updateSuccess;

  /// No description provided for @confirm.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận'**
  String get confirm;

  /// No description provided for @unconfirm.
  ///
  /// In vi, this message translates to:
  /// **'Không'**
  String get unconfirm;

  /// No description provided for @chooseOtherYear.
  ///
  /// In vi, this message translates to:
  /// **'Hãy chọn tháng/năm khác để xem thống kê'**
  String get chooseOtherYear;

  /// No description provided for @yes.
  ///
  /// In vi, this message translates to:
  /// **'Đồng ý'**
  String get yes;

  /// No description provided for @usernameExisted.
  ///
  /// In vi, this message translates to:
  /// **'Tên đăng nhập đã tồn tại'**
  String get usernameExisted;

  /// No description provided for @employeeCodeExisted.
  ///
  /// In vi, this message translates to:
  /// **'Mã nhân viên đã tồn tại, vui lòng kiểm tra lại!'**
  String get employeeCodeExisted;

  /// No description provided for @confirmLogout.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn đăng xuất không?'**
  String get confirmLogout;

  /// No description provided for @logoutTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận đăng xuất'**
  String get logoutTitle;

  /// No description provided for @cancelLogout.
  ///
  /// In vi, this message translates to:
  /// **'Hủy'**
  String get cancelLogout;
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
