import 'package:flutter/material.dart';

import 'package:programme_information_management_system/Programme/BEIT/BEITModules.dart';
import 'BEAPLs.dart';
import 'BEAElectives.dart';

import 'BEALoading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';





void main() {
  runApp(MaterialApp(
    home: AProgramPage(),
  ));
}

class AProgramPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Architecture'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Information'),
              Tab(text: 'Modules'),
              Tab(text: 'Electives'),
              Tab(text: 'Previous PLs'),
            ],
          ),
        ),
        body: ITDepartmentContent(),
      ),
    );
  }
}
class ITDepartmentContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        InformationTab(),
        Modules(),
        Electives(),
        PreviousPLsTab(),
      ],
    );
  }
}

class InformationTab extends StatefulWidget {
  @override
  _InformationTabState createState() => _InformationTabState();
}


class _InformationTabState extends State<InformationTab> {
  String apiUrl = 'https://node-api-6l0w.onrender.com/api/v1/students/programmedetails/P02';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Data is still being fetched, display a loading placeholder
          return buildLoadingPlaceholder();
        } else if (snapshot.hasError) {
          // An error occurred while fetching data, display an error message
          return buildErrorPlaceholder(snapshot.error.toString());
        } else if (snapshot.hasData) {

        // final jsonData = snapshot.data;
        // final departmentData = jsonData['department'];
        // final jsonString = json.encode(departmentData);
        // final departmentName = departmentData['dname'];
      final jsonData = snapshot.data;

      final Department = jsonData['department'][0];
      final departmentname = Department['dname'];
      final newDepartmentName = 'Department of Architecture';
      // final establishedDate = Department['established_date'];
      // final datePart = establishedDate.split('T')[0];
      // final programmOffered = Department['nprogram'].toString();
      final programList = jsonData['Programme'][0]; 
      final programName = 'B.Architecture';
      final programDuration = 5.toString();
      final establishedDate = programList['established_date'];
      final establishedDataPart =establishedDate.split('T')[0];
      final lastReviewDate = programList['last_reviwed_date'];
      final reviewdDatePart = lastReviewDate.split('T')[0];
     
      final StaffList = jsonData['staff'][0];
      final hodname = StaffList['name'];
      final email = StaffList['email'];
      final link = 'https://www.cst.edu.bt/images/faculty-profile/archdept/sumitra.jpg';

          // Data has been successfully fetched
          return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        Container(
      color: Color.fromARGB(255, 255, 255, 255), // Background color
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 188,
            child: Stack(
              children: [
                Container(
                  width: 400, // Match the width of the blue container
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image(
                      image: NetworkImage('https://cst.edu.bt/images/Campus/cstcampus2.jpg'), // Replace with your image URL
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Color(0x960028a8), // Positioned rectangle color
                    ),
                    child: Center( // Center the text
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Center text vertically
                        children: [
                          Text('AIM:', style: TextStyle(fontSize: 16, color: Colors.white)),
                          SizedBox(height: 4), // Add some spacing
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8), // Add horizontal padding
                            child: Text(
                              'The Department of Information Technology aims to develop Information Technology Professionals with specializations in Networking, Software Engineering, or Information Security who will be able to contribute to the development of computing technology in the country through Research, Innovation, Creativity, and Enterprise with ethical and professional responsibility.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                              maxLines: 5, // Limit the number of lines to fit within the container
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    SizedBox(height: 16),
      Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color(0xFFF97E0C),
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        height: 310,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Department:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              newDepartmentName,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Title of the Award:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              programName,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Programme Duration:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              programDuration,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Established Date: ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              establishedDataPart,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Last Review Date:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              reviewdDatePart,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
        SizedBox(height: 16),
     Container(
      decoration: BoxDecoration(
            border: Border.all(color: Colors.grey), // Add border styling as needed
            borderRadius: BorderRadius.circular(15.0), // Add border radius as needed
          ),
       child: ExpansionTile(
              title: Text('Programme Batch'),
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xFFF97E0C),
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  height: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Current Batch of Students',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F3F3),
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: Color(0xFFF97E0C),
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.school,
                              color: Color(0xFF000000),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Fourth Years : 11th batch',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F3F3),
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: Color(0xFFF97E0C),
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.school,
                              color: Color(0xFF000000),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'First Years : 14th batch',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
     ),



       
          SizedBox(height: 10),
          
          
        Container(
           decoration: BoxDecoration(
            border: Border.all(color: Colors.grey), // Add border styling as needed
            borderRadius: BorderRadius.circular(8.0), // Add border radius as needed
          ),
          child: ExpansionTile(
          title: Text('Present Programme Leader'),
          children: [
            Container(
              margin: EdgeInsets.all(1.0),
              decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFF87D0C),
            width: 4.0,
          ),
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(25.0),
              ),
              width: double.infinity,
              height: 118,
              child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: Container(
                width: 100.0,
                height: 100.0,
                color: const Color.fromARGB(255, 199, 198, 198), // Oval background color (you can replace this)
                child: Center(
                  child: Image.network(
                    link, // Add your image URL here
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
              ),
            ),
            SizedBox(width: 9.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sumitra Ghalley',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF000000),
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Master in Blockchain',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF87D0C),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'sumitragahlley.cst@rub.edu.bt',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF87D0C),
                    ),
                  ),
                ),
              ],
            ),
          ],
              ),
            ),
          ],
        ),
        ),
      ],
    );
        

        } else {
          // Data is null or empty
          return buildErrorPlaceholder('Data not available');
        }
      },
    );
  }

  Widget buildLoadingPlaceholder() {
    return AProgramPage1();
  }

  Widget buildErrorPlaceholder(String errorMessage) {
    return Center(
      child: Text('Error: $errorMessage'),
    );
  }

  Future<dynamic> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl)).timeout(Duration(seconds: 30));


      if (response.statusCode == 200) {
        final dynamic apiResponse = json.decode(response.body);
        // print(apiResponse); // Print the JSON data in the terminal
        return apiResponse;
      } else {
        print('API Error: Failed to load data');
        return null; // Return null to indicate an error.
      }
    } catch (e) {
      print('Error: $e');
      print('Network Error: Failed to load data');
      return null; // Return null to indicate an error.
    }
  }
}




class Modules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Add your staff details here
    return newModules();
  }
}
class Electives extends StatelessWidget {
  @override
  Widget build(BuildContext){
    return newElectives();
  }
}

class PreviousPLsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Add your previous HoDs details here
    return PreviousPLContent();
  }
}
