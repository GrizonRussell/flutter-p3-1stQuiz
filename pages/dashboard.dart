import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kunwari_study/components/my_button.dart';
import 'package:kunwari_study/components/my_textfield.dart';
import 'package:kunwari_study/components/show_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List contact = [];
  List filteredLists = [];
  final TextEditingController _searchController = TextEditingController();

  Future<List> _getContact() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt("userId");

    var url = Uri.parse("http://localhost/contact/api/users.php");
    Map<String, dynamic> jsonData = {
      // "userId": userId,
      "userId": 1,
    };
    Map<String, dynamic> requestBody = {
      "json": jsonEncode(jsonData),
      "operation": "getContact"
    };

    try {
      var response = await http.post(url, body: requestBody);
      print("Response: ${response.body}");

      var res = jsonDecode(response.body);
      if (res != 0) {
        return res;
      } else {
        print("No contacts found.");
        return [];
      }
    } catch (e) {
      print("Error fetching contacts: $e");
      return [];
    }
  }

  void handleGetEmployee() async {
    var url = Uri.parse("http://localhost/contact/api/users.php");
    Map<String, dynamic> jsonData = {
      // "userId": userId,
      "userId": _searchController.text,
    };

    print('jsondata: ${jsonData}');

    Map<String, dynamic> requestBody = {
      "json": jsonEncode(jsonData),
      "operation": "getEmployee"
    };

    try {
      var response = await http.post(url, body: requestBody);
      print("Response: ${response.body}");

      var res = jsonDecode(response.body);
      if (res != 0) {
        setState(() {
          filteredLists = res;
        });
      } else {
        ShowAlert().showAlert("error", "No employee found.");
        print("No contacts found.");
        filteredLists.clear();
      }
    } catch (e) {
      print("Error fetching contacts: $e");
    }
  }

  // void handleSearchEmployee() {
  //   List filteredEmployee = handleGetEmployee().toList();
  // }

  // void handleSearch() {
  //   String searchText = _searchController.text;
  //   if (searchText.isNotEmpty) {
  //     List filteredList = contact
  //         .where((contact) => contact['contact_phone'].contains(searchText))
  //         .toList();
  //     setState(() {
  //       filteredLists = filteredList;
  //     });
  //   } else {
  //     fetchContact();
  //   }
  // }

  // void fetchContact() async {
  //   List contacts = await _getContact();
  //   setState(() {
  //     contact = contacts;
  //     filteredLists = contacts;
  //   });
  //   print("Contacts fetched: ${contact.length}");
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchContact();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Employee"),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: MyTextfield(
                        labelText: "Search", controller: _searchController)),
                const SizedBox(width: 8),
                MyButton(
                  onPressed: () {
                    handleGetEmployee();
                  },
                  text: "Search",
                  color: Colors.black,
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: 10),
            filteredLists.isEmpty
                ? const Text("No employee yet.")
                : Expanded(
                    child: ListView.builder(
                      itemCount: filteredLists.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Column(children: [
                              Text("Name: ${filteredLists[index]['emp_name']}"),
                              Text("Dept: ${filteredLists[index]['department_text']}"),
                              Text("Status: ${filteredLists[index]['stat_text']}"),
                              Text("Basic: ${filteredLists[index]['emp_basic_salary']}"),
                            ],)
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ));
  }
}
