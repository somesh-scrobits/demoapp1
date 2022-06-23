import 'package:demoapp/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoDetails extends StatelessWidget {
  VideoDetails({Key? key}) : super(key: key);

  HomePageController homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.edit),onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Column(
                      children: [
                       // TextFormField(),
                        ElevatedButton(onPressed: () {}, child:  const Text("Save"))
                      ],
                    ),
                  ),
                );
              });
        }),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: SizedBox(
                height: Get.height/1.1,
                width: Get.width/1.1,
                child: Image.file(homePageController.image)),
          ),
        ),
      ),
    );
    //
    // Scaffold(
    //   body: SafeArea(
    //     child: Center(
    //       child: Column(
    //         children: [
    //           Container(
    //             height: Get.height / 1.2,
    //             width: Get.width / 1.2,
    //             child: Image.file(homePageController.image),
    //           ),
    //           Align(
    //             alignment: AlignmentDirectional.bottomCenter,
    //             child: Row(
    //               children: [
    //                 TextFormField(
    //                   decoration: InputDecoration(
    //                       border: OutlineInputBorder(
    //                           borderSide:
    //                               const BorderSide(color: Colors.blueAccent),
    //                           borderRadius: BorderRadius.circular(10))),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
