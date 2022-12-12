import 'package:http/http.dart' as http;

class AttandanceAPI {



  //function to split the id from the qrcode data to send the id to the api
  String getID(String result) {
    String id;
    id = result.split(' ')[0];
    if (id.length > 9) {
      return 'please try again';
    }
    // print(id);

    return id;
  }

  void takeAttendance(String data) async {
    // String baseURl;
    // This will be sent as form data in the post requst
    var map = <String, dynamic>{};
    map['username'] = 'username';
    map['password'] = 'password';

    // ignore: unused_local_variable
    final response = await http.post(
      Uri.parse('http/url/of/your/api'),
      body: map,
    );

    //  print(response.body);
  }
}
