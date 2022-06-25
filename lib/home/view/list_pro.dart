import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class ListPro extends StatelessWidget {
  ListPro({Key? key}) : super(key: key);

  HomePageController homePageController = Get.put(HomePageController());
  final Stream<QuerySnapshot> posts =
      FirebaseFirestore.instance.collection("posts").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            homePageController.selectImage(context);
          },
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: posts,
          builder: ((BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong!");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            final data = snapshot.requireData;
            return ListView.builder(
                itemCount: data.size,
                itemBuilder: (context, index) {
                  debugPrint(data.docs[index]['photo_url']);
                  return Padding(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        semanticContainer: true,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: GFListTile(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          avatar: InkWell(
                            onTap: () {
                              expandeImage(context);
                            },
                            child: Image(
                                fit: BoxFit.cover,
                                width: Get.height / 6,
                                height: Get.height / 8,
                                image: CachedNetworkImageProvider(
                                    data.docs[index]['photo_url'])),
                          ),
                          //  Image.network(data.docs[index]['photo_url']),
                          title: Text(
                            data.docs[index]['title'],
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          subTitle: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                                "Description: " + data.docs[index]['desc']),
                          ),
                        )),
                  );
                });
          }),
        ));
  }

  void expandeImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(padding: const EdgeInsets.all(8),
            child: Image(image: CachedNetworkImageProvider(homePageController.photo_url)),),
          );
        });
  }
}
