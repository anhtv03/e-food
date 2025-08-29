// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'ĐẶT CƠM';

  @override
  String get login => 'Đăng nhập';

  @override
  String get loginTitle => 'Xin chào!';

  @override
  String get subLoginTitle => 'Đăng nhập để tiếp tục';

  @override
  String get placeholderUsername => 'Tên đăng nhập';

  @override
  String get placeholderPassword => 'Mật khẩu';

  @override
  String get register => 'Đăng ký';

  @override
  String get comeBack => 'Quay lại';

  @override
  String get fullName => 'Tên đầy đủ';

  @override
  String get employeeId => 'Mã nhân viên';

  @override
  String get accountName => 'Tên tài khoản';

  @override
  String get password => 'Mật khẩu';

  @override
  String get fullNameBlank => 'Tên đầy đủ không được để trống';

  @override
  String get employeeIdBlank => 'Mã nhân viên không được để trống';

  @override
  String get employeeIdInvalid => 'Mã nhân viên không hợp lệ';

  @override
  String get usernameBlank => 'Tên tài khoản không được để trống';

  @override
  String get usernameInvalid => 'Tên tài khoản đã tồn tại';

  @override
  String get passwordBlank => 'Mật khẩu không được để trống';

  @override
  String get passwordTooShort => 'Mật khẩu phải có ít nhất 6 ký tự';

  @override
  String get forgotPassword => 'Quên mật khẩu?';

  @override
  String get createAccount => 'Tạo tài khoản mới';

  @override
  String get weeklyMeals => 'Món ăn trong tuần này';

  @override
  String get noteOrder => 'Lưu ý: đặt cơm chậm nhất trước 10:00 AM';

  @override
  String get no1 => 'STT';

  @override
  String get dishName => 'Tên món';

  @override
  String get supplyDate => 'Ngày cung cấp';

  @override
  String get status => 'Trạng thái';

  @override
  String get amount => 'Giá (VNĐ)';

  @override
  String formatAmount(Object amount) {
    return 'Giá: $amount₫';
  }

  @override
  String formatDate(Object date) {
    return 'Ngày: $date';
  }

  @override
  String welcomeUser(String name) {
    return 'Xin chào, $name!';
  }

  @override
  String mealCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bữa ăn',
      one: '1 bữa ăn',
      zero: 'Không có bữa ăn nào',
    );
    return '$_temp0';
  }

  @override
  String get successRegister => 'Đăng ký thành công';

  @override
  String get failRegister => 'Đăng ký thất bại';

  @override
  String get successLogin => 'Đăng nhập thành công';

  @override
  String get failLogin => 'Đăng nhập thất bại';

  @override
  String get mealStatistics => 'Thống kê suất ăn';

  @override
  String get orderHistory => 'Lịch sử đặt món';

  @override
  String get month => 'Tháng';

  @override
  String get year => 'Năm';

  @override
  String get search => 'Tìm kiếm';

  @override
  String totalAmount(String amount) {
    return 'Tổng tiền trong tháng: $amount VND';
  }

  @override
  String get noData => 'Không có dữ liệu';

  @override
  String get order => 'Đặt món';

  @override
  String get ordered => 'Đã đặt';

  @override
  String get cancel => 'Hủy món';

  @override
  String get expired => 'Hết hạn';

  @override
  String get confirmCancel => 'Xác nhận hủy món';

  @override
  String get confirmOrder => 'Xác nhận đặt món';

  @override
  String confirmMsgCancel(Object mealName) {
    return 'Bạn có chắc chắn muốn huỷ món $mealName không?';
  }

  @override
  String confirmMsgOrder(Object mealName) {
    return 'Bạn có chắc chắn muốn đặt món $mealName không?';
  }
}
