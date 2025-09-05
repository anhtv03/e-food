# E-Food - Ứng dụng Đặt Cơm

<img src="assets/images/background_1.jpg" width="200" alt="Login Background"/>

## 📖 Giới thiệu

E-Food là một ứng dụng di động được xây dựng bằng Flutter, giúp người dùng dễ dàng đặt món ăn trực tuyến. Ứng dụng hỗ trợ đa ngôn ngữ (Tiếng Việt và Tiếng Anh) và cung cấp giao diện người dùng thân thiện.

## ✨ Tính năng chính

- 🔐 **Xác thực người dùng**: Đăng nhập/Đăng ký tài khoản
- 🍽️ **Đặt món**: Xem và đặt món ăn trong tuần
- 📊 **Thống kê**: Theo dõi lịch sử đặt món và chi tiêu
- 📱 **Giao diện**: UI/UX thân thiện, responsive
- 🌐 **Đa ngôn ngữ**: Hỗ trợ Tiếng Việt và Tiếng Anh

## 🛠️ Công nghệ sử dụng

- **Flutter**: Framework phát triển ứng dụng
- **Bloc Pattern**: Quản lý state
- **Shared Preferences**: Lưu trữ local
- **HTTP**: Giao tiếp API
- **Intl**: Đa ngôn ngữ

## 🚀 Cài đặt và Chạy ứng dụng

### Yêu cầu hệ thống
- Flutter SDK ^3.7.2
- Dart SDK
- Android Studio/VS Code

### Các bước cài đặt

1. Clone repository:
```
bash git clone [repository-url]
``` 

2. Cài đặt dependencies:
```
bash flutter pub get
``` 

3. Chạy ứng dụng:
```
bash flutter run
``` 

## 🏗️ Cấu trúc project
```
lib/ 
   ├── blocs/ # Business Logic Components 
   ├── constants/ # Các hằng số, màu sắc, styles 
   ├── l10n/ # Đa ngôn ngữ 
   ├── models/ # Data models 
   ├── screens/ # Màn hình ứng dụng 
   ├── services/ # Services (API, local storage) 
   └── widgets/ # Các widget tái sử dụng
``` 

## 🔧 Cấu hình

### API Configuration
Cấu hình API endpoint trong `lib/constants/api_constants.dart`:
```
dart static const String baseUrl = '[http://your-api-endpoint](http://your-api-endpoint)';
``` 

### Ngôn ngữ
Thêm/sửa các chuỗi trong:
- `lib/l10n/app_en.arb` (Tiếng Anh)
- `lib/l10n/app_vi.arb` (Tiếng Việt)


