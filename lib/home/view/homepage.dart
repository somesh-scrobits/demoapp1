import 'package:demoapp/home/controller/home_controller.dart';
import 'package:demoapp/home/view/list_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  HomePageController homePageController = Get.put(HomePageController());

  var title = TextEditingController();
  var desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      
      // appBar: AppBar(
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.all(10.0),
      //       child: InkWell(
      //           onTap: () {
      //            // homePageController.getImage();
      //             Get.to(() => ListPro());
      //           },
      //           child: const Icon(Icons.arrow_forward_rounded)),
      //     )
      //   ],
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            
            children: [
             
              GetBuilder(
                  init: HomePageController(),
                  builder: (context) {
                    return SizedBox(
                      // height: 200,
                      // width: 200,
                      child: homePageController.image == null
                          ? InkWell(
                              onTap: () {
                                homePageController.selectImage(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(top:30),
                                child: Text("Add Image"),
                              ))
                          : Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: AspectRatio(
                              aspectRatio: 3/4,
                              child: Image.file(homePageController.image)),
                          ),
                    );
                  }),
                   Padding(
                padding: const EdgeInsets.only(top: 5, left: 30, right: 30),
                child: TextFormField(
                  controller: title,
                  decoration: InputDecoration(
                      hintText: "Add Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blueAccent))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 20),
                child: TextFormField(
                  controller: desc,
                  decoration: InputDecoration(
                      hintText: "Add Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blueAccent))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                    onPressed: () {
                      homePageController.title = title.text;
                      homePageController.desc = desc.text;
                      homePageController.uploadImage();
                      // homePageController.addData();
                    },
                    child: const Text("Save Post")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
