abstract class ITodoRepository {
  Future<List<dynamic>> getTodoList({required String planDate, required String planStatus});

  Future<Map<String, dynamic>> addTodo({required String planDate, required String taskDes});

  Future<Map<String, dynamic>> updateTodoStatus({required String busPlannerid, required String planStatus});
}
