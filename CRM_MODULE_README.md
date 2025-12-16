# CRM Module Implementation

## Overview
The CRM (Customer Relationship Management) module has been implemented following the same architectural pattern as the authentication module in your app.

## Changes Made

### 1. **Files Removed** (Unused Demo Files)
- `lib/presentation/pages/layout/leads/leads.dart` ❌
- `lib/presentation/pages/layout/follow_up/follow_up.dart` ❌
- `lib/presentation/pages/layout/clients/clients.dart` ❌

### 2. **New Files Created**

#### Repository Layer
- `lib/domain/repositories/i_crm_repository.dart` - Interface defining CRM operations
- `lib/domain/repositories/crm_repository.dart` - Implementation of CRM repository

#### Presentation Layer
- `lib/presentation/pages/layout/crm/crm_page.dart` - Main CRM listing page
- `lib/presentation/pages/layout/crm/add_edit_crm.dart` - Add/Edit CRM form
- `lib/presentation/pages/layout/crm/crm_detail.dart` - CRM detail view

### 3. **Files Modified**

#### API Constants
- `lib/core/constants/api_constants.dart` - Added CRM API endpoints

#### API Service
- `lib/data/datasources/api_service.dart` - Clean implementation (removed direct API calls)

#### Dependencies
- `pubspec.yaml` - Added `url_launcher: ^6.3.1` for phone call functionality

#### Layout
- `lib/presentation/pages/layout/layout.dart` - Updated to use CRMPage and removed unused pages

## API Endpoints Used

```dart
static const String crmMastersList = 'BusCrmAPI/BusCRMMastersList';
static const String crmGetList = 'BusCrmAPI/BusCrmGetList';
static const String crmViewById = 'BusCrmAPI/BusCrmViewById';
static const String crmAdd = 'BusCrmAPI/BusCrmAdd';
static const String crmUpdate = 'BusCrmAPI/BusCrmUpdate';
```

## Architecture Pattern

The CRM module follows the **Repository Pattern** similar to your auth implementation:

```
Presentation Layer (UI)
         ↓
Domain Layer (Repository Interface)
         ↓
Domain Layer (Repository Implementation)
         ↓
Data Layer (API Service)
         ↓
External API
```

### Example Flow:

1. **CRMPage** (UI) calls `_crmRepository.getCrmList()`
2. **CrmRepository** uses `_apiService.post()` with proper endpoints
3. **ApiService** makes HTTP request using Dio
4. Response flows back through the layers

## Features Implemented

### CRM Page (`crm_page.dart`)
- ✅ Tabbed interface for different CRM types (Lead, Appointment, Sales)
- ✅ Filter by status (New, Follow Up, Close)
- ✅ Search functionality (by name, mobile, notes)
- ✅ Responsive layout (Grid view for web, List view for mobile)
- ✅ Statistics cards showing total entries and active count
- ✅ Direct phone call integration
- ✅ Master data loading (types, sources, statuses)

### Add/Edit CRM Page (`add_edit_crm.dart`)
- ✅ Form validation
- ✅ Date picker for follow-up dates
- ✅ Dropdown selections for Type, Source, Status
- ✅ Create and Update functionality
- ✅ Loading state management
- ✅ Success/error notifications

### CRM Detail Page (`crm_detail.dart`)
- ✅ Professional card-based layout
- ✅ Contact information display
- ✅ Important dates section
- ✅ Source information
- ✅ Notes section
- ✅ Quick actions (Call, Edit)
- ✅ Status badges with color coding

## Responsive Design

The module is designed to work well on both **Web** and **Mobile**:

### Web (> 900px width)
- Grid layout with 2 columns
- More information visible at once
- Statistics cards in header

### Mobile (< 600px width)
- List layout for better scrolling
- Floating action button
- Compact cards
- Touch-optimized interactions

## Color Coding

- **Blue**: New leads
- **Orange**: Follow-up required
- **Green**: Closed/Completed

## How to Use

### 1. Navigate to CRM
Click on "CRM" in the sidebar menu

### 2. View CRM Entries
- Switch between tabs (Lead, Appointment, Sales)
- Use search to find specific entries
- Filter by status using dropdown

### 3. Add New CRM
- Click "Add CRM" button in app bar
- Or click floating action button (mobile)
- Fill in required fields
- Select follow-up date
- Submit form

### 4. Edit CRM
- Click edit icon on any CRM card
- Or click edit button in detail view
- Modify fields as needed
- Submit changes

### 5. View Details
- Click on any CRM card
- View complete information
- Make phone calls directly
- Edit from detail view

## API Authentication

All API calls use the authentication token stored in `LocalStorage`:
```dart
final auth = LocalStorage.getToken();
```

Make sure user is logged in before accessing CRM features.

## Error Handling

- Network errors are caught and displayed as SnackBar notifications
- Loading states prevent duplicate requests
- Validation ensures data integrity

## Next Steps (Optional Enhancements)

- [ ] Add delete CRM functionality
- [ ] Implement bulk actions
- [ ] Add export to CSV/Excel
- [ ] Activity timeline for each CRM
- [ ] Email integration
- [ ] Reminder notifications
- [ ] Analytics dashboard

## Dependencies Required

Before running, execute:
```bash
flutter pub get
```

This will install the `url_launcher` package needed for phone call functionality.

---

**Note**: The implementation follows your existing code patterns and uses the same API structure as your authentication module.

