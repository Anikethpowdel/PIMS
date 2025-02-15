import 'package:flutter/material.dart';
import 'package:programme_information_management_system/Programme/BEIT/BEITModules.dart';
import 'BEAPLs.dart';
import 'BEAElectives.dart';
import 'package:programme_information_management_system/DateRetrival/data_retrival.dart';
import 'package:skeleton_text/skeleton_text.dart';





class AProgramPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        
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
  final DataRetrievalService dataRetrievalService = DataRetrievalService();
  List<Map<String, dynamic>> students = [];
  String _displayedData = '';
  String _DeptName = 'initial';
  String _Established = '';
  String _HodName = '';
  String _HoDEmail = '';

  bool _connectedToDatabase = false;

  @override
  void initState() {
    super.initState();
    fetchData('D04'); // Fetch data automatically when the page loads.
  }

  Future<void> fetchData(String deptId) async {
    final isConnectionSuccessful = await dataRetrievalService.testDatabaseConnection();

    if (isConnectionSuccessful) {
      _connectedToDatabase = true;
    }

    if (_connectedToDatabase) {
      final departmentDetails = await dataRetrievalService.getStudents(deptId);

      if (departmentDetails != null) {
        final List<Map<String, dynamic>> combinedData = [];

        for (final department in departmentDetails) {
          final hodid = department['hodid'];
          final staffDetails = await dataRetrievalService.getStaff(hodid);

          if (staffDetails != null) {
            department['staffDetails'] = staffDetails;
          }

          combinedData.add(department);
        }

        setState(() {

          for (final data in students) {
            _DeptName = data['dname'];
            _Established =  data['Established_date'];

            final staffDetails = data['staffDetails'];

            if (staffDetails != null) {
              for (final staff in staffDetails) {
                _HodName = staff['name'];
                _HoDEmail = staff['email'];
              }
            }
          }
        });
      }
    }
    else{
      _DeptName = 'Database not working';
    }
  }

  
  @override
  Widget build(BuildContext context) {
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
            SkeletonAnimation(
        shimmerColor: Colors.grey,
        borderRadius: BorderRadius.circular(10.0),
        shimmerDuration: 1000,
        child: Container(
          width: 150,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[300],
          ),
        ),
      ),
            SizedBox(height: 16),
            Text(
              'Title of the Award:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SkeletonAnimation(
        shimmerColor: Colors.grey,
        borderRadius: BorderRadius.circular(10.0),
        shimmerDuration: 1000,
        child: Container(
          width: 150,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[300],
          ),
        ),
      ),
            SizedBox(height: 16),
            Text(
              'Programme Duration',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SkeletonAnimation(
        shimmerColor: Colors.grey,
        borderRadius: BorderRadius.circular(10.0),
        shimmerDuration: 1000,
        child: Container(
          width: 150,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[300],
          ),
        ),
      ),
            SizedBox(height: 16),
            Text(
              'Established Date',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SkeletonAnimation(
        shimmerColor: Colors.grey,
        borderRadius: BorderRadius.circular(10.0),
        shimmerDuration: 1000,
        child: Container(
          width: 150,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[300],
          ),
        ),
      ),
            SizedBox(height: 16),
            Text(
              'Last Review Date:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SkeletonAnimation(
        shimmerColor: Colors.grey,
        borderRadius: BorderRadius.circular(10.0),
        shimmerDuration: 1000,
        child: Container(
          width: 150,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[300],
          ),
        ),
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
                        child:  SkeletonAnimation(
                                shimmerColor: Colors.grey,
                                borderRadius: BorderRadius.circular(10.0),
                                shimmerDuration: 1000,
                                child: Container(
                                  width: 150,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey[300],
                                  ),
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
                           SkeletonAnimation(
                              shimmerColor: Colors.grey,
                              borderRadius: BorderRadius.circular(10.0),
                              shimmerDuration: 1000,
                              child: Container(
                                width: 150,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300],
                                ),
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
                             SkeletonAnimation(
                              shimmerColor: Colors.grey,
                              borderRadius: BorderRadius.circular(10.0),
                              shimmerDuration: 1000,
                              child: Container(
                                width: 150,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300],
                                ),
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
                color: Colors.white, // Oval background color (you can replace this)
                child: Center(
                  child: Image.network(
                    'https://cst.edu.bt/images/Campus/cstcampus2.jpg', // Add your image URL here
                    width: 110.0,
                    height: 110.0,
                  ),
                ),
              ),
            ),
            SizedBox(width: 9.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonAnimation(
                      shimmerColor: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                      shimmerDuration: 1000,
                      child: Container(
                        width: 150,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: SkeletonAnimation(
                        shimmerColor: Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                        shimmerDuration: 1000,
                        child: Container(
                          width: 150,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: SkeletonAnimation(
                              shimmerColor: Colors.grey,
                              borderRadius: BorderRadius.circular(10.0),
                              shimmerDuration: 1000,
                              child: Container(
                                width: 150,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300],
                                ),
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
  }

  Widget _buildProgrammeItem(String programmeName, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 24),
        SizedBox(width: 16),
        Text(
          programmeName,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
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
