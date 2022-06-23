import 'package:demoapp/home/controller/home_controller.dart';
import 'package:demoapp/home/view/list_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  HomePageController homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homePageController.selectImage();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
                onTap: () {
                  Get.to(() => const ListPro());
                },
                child: const Icon(Icons.arrow_forward_rounded)),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Add Description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blueAccent))),
            ),
          ),
          GetBuilder(
              init: HomePageController(),
              builder: (context) {
                return SizedBox(
                  // height: 200,
                  // width: 200,
                  child: homePageController.image == null
                      ? const Text("Add Image")
                      : Image.file(homePageController.image),
                );
              }),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
                onPressed: () {
                  homePageController.uploadImage();
                },
                child: const Text("Save Post")),
          )
        ],
      ),
    );
  }
}
