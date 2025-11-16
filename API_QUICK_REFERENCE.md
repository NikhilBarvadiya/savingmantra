# API Quick Reference Guide

## 🔑 How to Use APIs in SavingMantra

### Basic Pattern

```dart
// 1. Import the provider
import 'package:savingmantra/presentation/providers/auth_provider.dart';

// 2. In your ConsumerWidget/ConsumerStatefulWidget
class YourPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<YourPage> createState() => _YourPageState();
}

class _YourPageState extends ConsumerState<YourPage> {
  
  void callAPI() async {
    // 3. Get the notifier
    final authNotifier = ref.read(authProvider.notifier);
    
    try {
      // 4. Call the method
      await authNotifier.sendLoginOTP(phoneNumber);
      
      // 5. Success handling
      appToast.successToast(txt: 'Success!');
      
    } catch (e) {
      // 6. Error handling
      appToast.internalServerError(e.toString());
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // 7. Watch state for UI updates
    final authState = ref.watch(authProvider);
    
    return Scaffold(
      body: authState.isLoading 
        ? CircularProgressIndicator()
        : YourContent(),
    );
  }
}
```

## 📞 Available API Methods

### 1. Send Login OTP
```dart
await ref.read(authProvider.notifier).sendLoginOTP(phoneNumber);
```
**Parameters:**
- `phoneNumber` (String): 10-digit mobile number

**Response:** Updates state with `authToken`

---

### 2. Send Registration OTP
```dart
await ref.read(authProvider.notifier).sendRegisterOTP(phoneNumber);
```
**Parameters:**
- `phoneNumber` (String): 10-digit mobile number

**Response:** Updates state with `authToken`

---

### 3. Verify Login OTP
```dart
await ref.read(authProvider.notifier).verifyLoginOTP(otp);
```
**Parameters:**
- `otp` (String): 4-digit OTP

**Response:** 
- Saves token to local storage
- Updates state with verified `authToken`
- Auto-saves login state

---

### 4. Verify Registration OTP
```dart
await ref.read(authProvider.notifier).verifyRegisterOTP(otp);
```
**Parameters:**
- `otp` (String): 4-digit OTP

**Response:** Updates state with verified `authToken`

---

### 5. Register User
```dart
await ref.read(authProvider.notifier).registerUser(
  fullName: 'John Doe',
  email: 'john@example.com',
  countryId: '1',
  city: 'Mumbai',
  authPin: '1234',
);
```
**Parameters:**
- `fullName` (String): User's full name
- `email` (String): Valid email address
- `countryId` (String): Selected country ID
- `city` (String): User's city
- `authPin` (String): 4-digit PIN

**Response:** Completes registration

---

### 6. Get Countries
```dart
await ref.read(authProvider.notifier).getCountries();
```
**Parameters:** None

**Response:** Updates `authState.countries` list

**Usage:**
```dart
final countries = ref.watch(authProvider).countries;
final isLoading = ref.watch(authProvider).isLoadingCountries;
```

---

## 🎯 State Management

### Accessing State

```dart
// Read current state
final authState = ref.watch(authProvider);

// Access state properties
bool isLoading = authState.isLoading;
String? phoneNumber = authState.phoneNumber;
String? authToken = authState.authToken;
String? error = authState.error;
List<Country> countries = authState.countries;
bool isLoadingCountries = authState.isLoadingCountries;
```

### State Updates

State is automatically updated by the provider methods. You don't need to manually update it.

---

## 🔐 Local Storage

### Save Token
```dart
await LocalStorage.setToken(token);
```

### Get Token
```dart
String token = LocalStorage.getToken();
```

### Check Login Status
```dart
bool isLoggedIn = LocalStorage.isLoggedIn();
```

### Logout
```dart
await LocalStorage.clearAll();
```

---

## 🎨 Toast Notifications

### Success Toast
```dart
appToast.successToast(txt: 'Operation successful!');
```

### Error Toast
```dart
appToast.internalServerError('Error message');
```

### Info Toast
```dart
appToast.infoToast(
  icon: Icons.info,
  txt: 'Information message'
);
```

### Warning Toast
```dart
appToast.dioToast(
  icon: Icons.warning,
  txt: 'Warning message'
);
```

---

## 🧭 Navigation Patterns

### Push New Page
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => NextPage(),
  ),
);
```

### Replace Current Page
```dart
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => NextPage(),
  ),
);
```

### Clear Stack and Navigate
```dart
Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => NextPage()),
  (route) => false,
);
```

### Named Routes
```dart
Navigator.pushNamed(context, '/home');
Navigator.pushReplacementNamed(context, '/login');
Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
```

---

## 📝 Form Validation

### Phone Number Validator
```dart
import 'package:savingmantra/core/utils/validators.dart';

CustomTextField(
  validator: Validators.phoneValidator,
  // ... other properties
)
```

**Validates:**
- 10 digits
- Starts with 6-9

### Custom Validators

```dart
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}
```

---

## 🎨 Custom Widgets

### CustomTextField
```dart
CustomTextField(
  label: 'Phone Number',
  hintText: 'Enter your phone number',
  controller: _phoneController,
  validator: Validators.phoneValidator,
  keyboardType: TextInputType.phone,
  prefixIcon: Icon(Icons.phone),
  suffixIcon: Icon(Icons.clear),
)
```

### CustomButton
```dart
CustomButton(
  text: 'Submit',
  onPressed: _handleSubmit,
  isLoading: authState.isLoading,
  isEnabled: !authState.isLoading,
  backgroundColor: AppColors.primary,
  textColor: AppColors.white,
)
```

---

## 🚨 Error Handling Best Practices

```dart
void callAPI() async {
  final authNotifier = ref.read(authProvider.notifier);
  
  try {
    // Show loading
    setState(() => _isLoading = true);
    
    // Call API
    await authNotifier.someMethod();
    
    // Success
    if (mounted) {
      appToast.successToast(txt: 'Success!');
      Navigator.pushNamed(context, '/next-page');
    }
    
  } catch (e) {
    // Error
    if (mounted) {
      appToast.internalServerError(e.toString());
    }
    
  } finally {
    // Cleanup
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }
}
```

---

## 🔄 Complete Login Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savingmantra/core/utils/app_toast.dart';
import 'package:savingmantra/core/utils/validators.dart';
import 'package:savingmantra/presentation/providers/auth_provider.dart';
import 'package:savingmantra/presentation/widgets/common/custom_button.dart';
import 'package:savingmantra/presentation/widgets/common/custom_textfield.dart';

class LoginExample extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginExample> createState() => _LoginExampleState();
}

class _LoginExampleState extends ConsumerState<LoginExample> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _sendOTP() async {
    if (_formKey.currentState!.validate()) {
      final phoneNumber = _phoneController.text.trim();
      final authNotifier = ref.read(authProvider.notifier);
      
      try {
        await authNotifier.sendLoginOTP(phoneNumber);
        appToast.successToast(txt: 'OTP sent successfully!');
        
        if (mounted) {
          // Navigate to OTP page
        }
      } catch (e) {
        appToast.internalServerError(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              label: 'Phone Number',
              hintText: 'Enter phone number',
              controller: _phoneController,
              validator: Validators.phoneValidator,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Send OTP',
              onPressed: _sendOTP,
              isLoading: authState.isLoading,
              isEnabled: !authState.isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 💡 Tips

1. **Always use `mounted` check** before navigation or setState after async operations
2. **Use `FocusScope.of(context).unfocus()`** before API calls to dismiss keyboard
3. **Dispose controllers** in the dispose method
4. **Use `ref.watch`** for UI updates, `ref.read` for one-time reads
5. **Handle errors gracefully** with try-catch blocks
6. **Show loading states** for better UX

---

**Happy Coding! 🚀**

