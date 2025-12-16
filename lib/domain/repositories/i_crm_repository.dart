abstract class ICrmRepository {
  Future<Map<String, dynamic>> getCrmMasters({String? fetchBusCRMSourcList, String? fetchBusCRMTypeList, String? fetchBusCRMSalesStatusList});

  Future<List<dynamic>> getCrmList({String? busCRMTypeid, String? busCRMSalesStatusid});

  Future<Map<String, dynamic>> getCrmById(String busSaleCRMID);

  Future<Map<String, dynamic>> addCrm({
    required String busCRMTypeid,
    required String followDate,
    required String crmParty,
    required String mobileNumber,
    required String crmNotes,
    String? busCRMSourceId,
  });

  Future<Map<String, dynamic>> updateCrm({
    required String busSaleCRMID,
    required String busCRMTypeid,
    required String followDate,
    required String crmParty,
    required String mobileNumber,
    required String crmNotes,
    required String busCRMSalesStatusid,
    String? busCRMSourceId,
  });
}
