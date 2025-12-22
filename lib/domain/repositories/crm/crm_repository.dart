import 'package:savingmantra/core/constants/api_constants.dart';
import 'package:savingmantra/data/datasources/api_service.dart';
import 'package:savingmantra/data/datasources/local_storage.dart';
import 'package:savingmantra/domain/repositories/crm/i_crm_repository.dart';

class CrmRepository implements ICrmRepository {
  final ApiService _apiService = ApiService();

  @override
  Future<Map<String, dynamic>> getCrmMasters({String? fetchBusCRMSourcList, String? fetchBusCRMTypeList, String? fetchBusCRMSalesStatusList}) async {
    try {
      // final auth = "jvZVSzvERAlIB9tiyK5c/1Bc3z3PzMWsnuh7O16yzQdA/x/HXBFwPqhd4fc6FSaK/y8KKArnmwFX2oWNa/IukeIqY/Uh3HS+ZhkHltuvgIU="; // final auth = LocalStorage.getToken();
      final auth = LocalStorage.getToken();
      final response = await _apiService.post(ApiConstants.crmMastersList, {
        'Auth': auth,
        'FetchBusCRMSourcList': fetchBusCRMSourcList ?? 'Y',
        'FetchBusCRMTypeList': fetchBusCRMTypeList ?? 'Y',
        'FetchBusCRMSalesStatusList': fetchBusCRMSalesStatusList ?? 'Y',
      });
      return response;
    } catch (e) {
      throw Exception('Failed to load CRM masters: $e');
    }
  }

  @override
  Future<List<dynamic>> getCrmList({String? busCRMTypeid, String? busCRMSalesStatusid}) async {
    try {
      // final auth = "jvZVSzvERAlIB9tiyK5c/1Bc3z3PzMWsnuh7O16yzQdA/x/HXBFwPqhd4fc6FSaK/y8KKArnmwFX2oWNa/IukeIqY/Uh3HS+ZhkHltuvgIU="; // final auth = LocalStorage.getToken();
      final auth = LocalStorage.getToken();
      final response = await _apiService.post(ApiConstants.crmGetList, {'Auth': auth, 'BusCRMTypeid': busCRMTypeid ?? '', 'BusCRMSalesStatusid': busCRMSalesStatusid ?? ''});
      return response as List<dynamic>;
    } catch (e) {
      throw Exception('Failed to load CRM list: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getCrmById(String busSaleCRMID) async {
    try {
      // final auth = "jvZVSzvERAlIB9tiyK5c/1Bc3z3PzMWsnuh7O16yzQdA/x/HXBFwPqhd4fc6FSaK/y8KKArnmwFX2oWNa/IukeIqY/Uh3HS+ZhkHltuvgIU="; // final auth = LocalStorage.getToken();
      final auth = LocalStorage.getToken();
      final response = await _apiService.post(ApiConstants.crmViewById, {'Auth': auth, 'BusSaleCRMID': busSaleCRMID});
      return response;
    } catch (e) {
      throw Exception('Failed to load CRM details: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> addCrm({
    required String busCRMTypeid,
    required String followDate,
    required String crmParty,
    required String mobileNumber,
    required String crmNotes,
    String? busCRMSourceId,
  }) async {
    try {
      // final auth = "jvZVSzvERAlIB9tiyK5c/1Bc3z3PzMWsnuh7O16yzQdA/x/HXBFwPqhd4fc6FSaK/y8KKArnmwFX2oWNa/IukeIqY/Uh3HS+ZhkHltuvgIU="; // final auth = LocalStorage.getToken();
      final auth = LocalStorage.getToken();
      final data = {'Auth': auth, 'BusCRMTypeid': busCRMTypeid, 'FollowDate': followDate, 'CRMParty': crmParty, 'MobileNumber': mobileNumber, 'CRMNotes': crmNotes};
      if (busCRMSourceId != null && busCRMSourceId.isNotEmpty) {
        data['BusCRMSourceId'] = busCRMSourceId;
      }
      final response = await _apiService.post(ApiConstants.crmAdd, data);
      return response;
    } catch (e) {
      throw Exception('Failed to add CRM: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> updateCrm({
    required String busSaleCRMID,
    required String busCRMTypeid,
    required String followDate,
    required String crmParty,
    required String mobileNumber,
    required String crmNotes,
    required String busCRMSalesStatusid,
    String? busCRMSourceId,
  }) async {
    try {
      // final auth = "jvZVSzvERAlIB9tiyK5c/1Bc3z3PzMWsnuh7O16yzQdA/x/HXBFwPqhd4fc6FSaK/y8KKArnmwFX2oWNa/IukeIqY/Uh3HS+ZhkHltuvgIU="; // final auth = LocalStorage.getToken();
      final auth = LocalStorage.getToken();
      final data = {
        'Auth': auth,
        'BusSaleCRMID': busSaleCRMID,
        'BusCRMTypeid': busCRMTypeid,
        'FollowDate': followDate,
        'CRMParty': crmParty,
        'MobileNumber': mobileNumber,
        'CRMNotes': crmNotes,
        'BusCRMSalesStatusid': busCRMSalesStatusid,
      };
      if (busCRMSourceId != null && busCRMSourceId.isNotEmpty) {
        data['BusCRMSourceId'] = busCRMSourceId;
      }
      final response = await _apiService.post(ApiConstants.crmUpdate, data);
      return response;
    } catch (e) {
      throw Exception('Failed to update CRM: $e');
    }
  }
}
