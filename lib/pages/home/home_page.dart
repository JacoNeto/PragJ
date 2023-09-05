import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pragj/controllers/home_controller.dart';
import 'package:pragj/pages/result/ResultPage.dart';
import 'package:pragj/utils/shared_widgets/my_button.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("PragJ"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() => _homeController.hasImageFile()
                      ? SizedBox(
                          height: 500,
                          width: 500,
                          child: kIsWeb
                              ? Image.network(
                                  _homeController.imageFile.value!.path)
                              : Image.file(
                                  File(_homeController.imageFile.value!.path)))
                      : const SizedBox(
                          height: 400,
                          width: double.infinity,
                          child: Icon(Icons.image),
                        )),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: MyButton(
                        leading: const Icon(
                          Icons.photo,
                          color: Colors.black,
                        ),
                        label: "Galeria",
                        onPressed: () {
                          _homeController.pickImageFromGallery();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: MyButton(
                        leading: const Icon(Icons.camera, color: Colors.black),
                        label: "Foto",
                        onPressed: () {
                          _homeController.pickImageFromCamera();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() => Padding(
                    padding: const EdgeInsets.all(8),
                    child: _homeController.hasImageFile()
                        ? MyButton(
                            leading: const Icon(Icons.generating_tokens),
                            label: "Gerar texto",
                            onPressed: () {
                              Get.to(ResultPage());
                            },
                          )
                        : const SizedBox.shrink(),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}