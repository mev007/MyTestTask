import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_developer_test_task/models/user_model.dart';
import 'package:mobile_developer_test_task/screens/home/bloc/home_bloc.dart';

import 'widgets/icon_field.dart';

class HomeBlocScreen extends StatelessWidget {
  const HomeBlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: const _HomeBlocScreen(),
    );
  }
}

class _HomeBlocScreen extends StatefulWidget {
  const _HomeBlocScreen();
  @override
  State<_HomeBlocScreen> createState() => __HomeBlocScreenState();
}

class __HomeBlocScreenState extends State<_HomeBlocScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final messageCtrl = TextEditingController();

  void checkButtonAvailability() {
    final user = UserModel(
      name: nameCtrl.text.trim(),
      email: emailCtrl.text.trim(),
      message: messageCtrl.text.trim(),
    );
    context.read<HomeBloc>().add(ChangeFieldEvent(user));
  }

  @override
  void initState() {
    super.initState();
    nameCtrl.addListener(() => checkButtonAvailability());
    emailCtrl.addListener(() => checkButtonAvailability());
    messageCtrl.addListener(() => checkButtonAvailability());
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    messageCtrl.dispose();
    super.dispose();
  }

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
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is LoadedState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.result
                          ? "User data has been successfully uploaded to the server"
                          : "Error uploading user data to the server"),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(
                        icon: IconField(),
                        labelText: 'Name',
                      ),
                    ),
                    TextFormField(
                      controller: emailCtrl,
                      decoration: const InputDecoration(
                        icon: IconField(),
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                      controller: messageCtrl,
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
                      onPressed: context.watch<HomeBloc>().isButtonEnabled
                          ? () => context
                              .read<HomeBloc>()
                              .add(SendUserEvent(UserModel(
                                name: nameCtrl.text.trim(),
                                email: emailCtrl.text.trim(),
                                message: messageCtrl.text.trim(),
                              )))
                          : null,
                      child: Text(
                        context.watch<HomeBloc>().isLoading
                            ? "Please wait"
                            : "Send",
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

