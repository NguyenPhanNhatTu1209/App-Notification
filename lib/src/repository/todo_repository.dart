import 'package:http/http.dart' as http;

const String baseUrl = "todolist-cosy.herokuapp.com";

class TodoRepository {
  Future<http.Response> getToDo() async {
    var respone = await http.get(Uri.https(baseUrl, '/task/show-task'));
    return respone;
  }

  Future<int> addToDo(Map<String, String> todoJson) async {
    var respone = await http.post(Uri.https(baseUrl, '/task/create-task'),
        body: todoJson);
    return respone.statusCode;
  }

  Future<int> doneToDo(Map<String, String> body) async {
    var respone = await http.put(Uri.https(baseUrl, '/task/done-task'),
        body: {"_id": "60e3333d0e13b80023c6da58"});
    print(body);
    print('TuData:' + respone.body.toString());
    return respone.statusCode;
  }

  Future<int> deleteToDo(Map<String, String> body) async {
    var respone =
        await http.put(Uri.https(baseUrl, '/task/delete-task'), body: body);
    return respone.statusCode;
  }
}
