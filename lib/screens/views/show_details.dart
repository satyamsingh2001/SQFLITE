import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_data/screens/models/db_model.dart';
import 'package:users_data/screens/views/add_data.dart';
import 'package:users_data/services/database/db_test.dart';

class ShowDetailsScreen extends StatefulWidget {
  // final String name;
  // final String mobile;
  // final String address;
  // final File? image;

  const ShowDetailsScreen({
    Key? key,

  }) : super(key: key);

  @override
  State<ShowDetailsScreen> createState() => _ShowDetailsScreenState();
}

class _ShowDetailsScreenState extends State<ShowDetailsScreen> {
  late Future<List<Map<String, Object?>>?> _dataListFuture;

  @override
  void initState() {
    super.initState();
    _dataListFuture = DbTesting.instance.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Users"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, Object?>>?>(
        future: _dataListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available.'));
          } else {
            List<Map<String, Object?>> dataList = snapshot.data!;
            return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                Map<String, Object?> data = dataList[index];
                int userId = data[DbTesting.id] as int;

                return ListTile(
                  // leading:widget.image != null
                  //     ? Image.file(
                  //   widget.image!,
                  //   width: 50,
                  //   height: 50,
                  //   fit: BoxFit.cover,
                  // )
                  //     : null,
                  title: Text('Name: ${data[DbTesting.userName]}'),
                  trailing: SizedBox(
                    height: 90,
                    child: Column(
                      children: [
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            // Handle menu item selection
                            print('Selected: $value');
                          },
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                onTap: (){removeProduct(userId);},
                                value: 'option1',
                                child: Text('Remove'),
                              ),

                            ];
                          },
                        ),
                        Text('Mobile: ${data[DbTesting.userMobile]}'),
                      ],
                    ),
                  ),
                  subtitle: Text('Email: ${data[DbTesting.userEmail]}'),
                  onTap: () {
                    // Handle onTap action if needed
                    Get.to(AddUsersData());
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
