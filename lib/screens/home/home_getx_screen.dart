import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';
import 'widgets/icon_field.dart';

class HomeGetxScreen extends StatelessWidget {
  const HomeGetxScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Contact us"),
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              // Куди вона повертатиме, якщо це перший екран?
            },
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: GetX<HomeController>(
              init: HomeController(),
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: controller.nameCtrl,
                      decoration: const InputDecoration(
                        icon: IconField(),
                        labelText: 'Name',
                      ),
                    ),
                    TextFormField(
                      controller: controller.emailCtrl,
                      decoration: const InputDecoration(
                        icon: IconField(),
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                      controller: controller.messageCtrl,
                      decoration: const InputDecoration(
                        icon: IconField(),
                        labelText: 'Message',
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF85577B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        elevation: 0,
                      ),
                      onPressed: controller.isButtonEnabled.value
                          ? controller.sendUser
                          : null,
                      child: Text(
                        controller.isLoading.value ? "Please wait" : "Send",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
