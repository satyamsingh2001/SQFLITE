import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_data/common_widgets/const_textfield.dart';
import 'package:users_data/screens/views/show_details.dart';
import 'package:users_data/services/database/db_test.dart';

import '../../colors/colors_const.dart';
import '../controllers/image_controller.dart';

class AddUsersData extends StatefulWidget {
  const AddUsersData({Key? key}) : super(key: key);

  @override
  State<AddUsersData> createState() => _AddDataState();
}

class _AddDataState extends State<AddUsersData> {

  final ImageController imageController = Get.put(ImageController());
  final TextEditingController name = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add User Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GetBuilder<ImageController>(
              builder: (imageController) {
                return InkWell(
                  onTap: () async {
                    await imageController.pickedProfile();
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: imageController.profile != null
                            ? FileImage(imageController.profile!)
                            : const AssetImage("assets/pic.png") as ImageProvider,
                      ),
                    ),
                  ),
                );
              }
            ),


             ConstTextField(
              controller: name,
              hintText: "Enter Your Name",
            ),
             ConstTextField(
               controller: mobile,
              hintText: "Enter Your Mobile Number",
              inputType: TextInputType.number,
              maxLength: 10,

            ),
             ConstTextField(
               controller: address,
              hintText: "Enter Your Address ",
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              addDataToDatabase(imageController.profile, name.text, mobile.text, address.text);
              Get.to(ShowDetailsScreen(

              ));
            }, child: const Text("Add Details"))
          ],
        ),
      ),
    );
  }
}
