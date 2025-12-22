import 'package:savingmantra/core/constants/api_constants.dart';
import 'package:savingmantra/data/datasources/api_service.dart';
import 'package:savingmantra/data/datasources/local_storage.dart';
import 'package:savingmantra/domain/repositories/todo/i_todo_repository.dart';

class TodoRepository implements ITodoRepository {
  final ApiService _apiService = ApiService();

  @override
  Future<List<dynamic>> getTodoList({required String planDate, required String planStatus}) async {
    try {
      // final auth = "jvZVSzvERAlIB9tiyK5c/1Bc3z3PzMWsnuh7O16yzQdA/x/HXBFwPqhd4fc6FSaK/y8KKArnmwFX2oWNa/IukeIqY/Uh3HS+ZhkHltuvgIU=";
      final auth = LocalStorage.getToken();
      final response = await _apiService.post(ApiConstants.plannerDayList, {'Auth': auth, 'PlanDate': planDate, 'PlanStatus': planStatus});
      return response as List<dynamic>;
    } catch (e) {
      throw Exception('Failed to load todo list: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> addTodo({required String planDate, required String taskDes}) async {
    try {
      // final auth = "jvZVSzvERAlIB9tiyK5c/1Bc3z3PzMWsnuh7O16yzQdA/x/HXBFwPqhd4fc6FSaK/y8KKArnmwFX2oWNa/IukeIqY/Uh3HS+ZhkHltuvgIU=";
      final auth = LocalStorage.getToken();
      final response = await _apiService.post(ApiConstants.plannerAddPlan, {'Auth': auth, 'PlanDate': planDate, 'TaskDes': taskDes});
      return response;
    } catch (e) {
      throw Exception('Failed to add todo: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> updateTodoStatus({required String busPlannerid, required String planStatus}) async {
    try {
      // final auth = "jvZVSzvERAlIB9tiyK5c/1Bc3z3PzMWsnuh7O16yzQdA/x/HXBFwPqhd4fc6FSaK/y8KKArnmwFX2oWNa/IukeIqY/Uh3HS+ZhkHltuvgIU=";
      final auth = LocalStorage.getToken();
      final response = await _apiService.post(ApiConstants.plannerUpdateStatus, {'Auth': auth, 'BusPlannerId': busPlannerid, 'PlanStatus': planStatus});
      return response;
    } catch (e) {
      throw Exception('Failed to update todo status: $e');
    }
  }
}
