import 'service/firebase.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Hive extends StatefulWidget {
  final String userId;
  final String apiaryId;// Add userId parameter
  const Hive({Key? key, required this.userId,required this.apiaryId }) : super(key: key);

  @override
  State<Hive> createState() => _UserState();
}

class _UserState extends State<Hive>{
  TextEditingController NameController = TextEditingController();
  TextEditingController KeyController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Add",
              style: TextStyle(
                  color: const Color.fromARGB(255, 169, 158, 60),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Hives",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 193, 37),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name",style: TextStyle(color:Colors.black,fontSize: 20.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0,),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration:BoxDecoration(
                  color: Color.fromARGB(70, 251, 247, 5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black),
                ),
                child: TextField(
                  controller: NameController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(height: 20.0,),
              Text("Key",style: TextStyle(color:Colors.black,fontSize: 20.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0,),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration:BoxDecoration(
                  color: Color.fromARGB(70, 251, 247, 5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black),
                ),
                child: TextField(
                  controller: KeyController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(height: 40.0,),
              Center(
                child: ElevatedButton(
                  onPressed: ()async {
                    String HiveID = randomAlphaNumeric(10);
                    Map<String, dynamic> userInfoMap = {
                      "name": NameController.text,
                      "key": KeyController.text,
                    };

                    // Add the user details
                    bool success = await DatabaseMethods().addHiveDetails(userInfoMap, widget.userId, widget.apiaryId,HiveID);

                    if (success) {
                      Fluttertoast.showToast(
                        msg: "Hive details added successfully!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green, // Change the background color to green for success
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "Failed to add Hive details!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                  child: Text("Add",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Set text color to black
                    ),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow, // Set button color to yellow
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}