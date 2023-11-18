import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mobile_developer_test_task/models/user_model.dart';
import 'package:mobile_developer_test_task/services/user_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final messageCtrl = TextEditingController();
  bool isButtonEnabled = false;
  bool isLoading = false;
  String resultLoaded = '';

  void checkButtonAvailability() {
    setState(() => isButtonEnabled = nameCtrl.text.trim().isNotEmpty &&
        EmailValidator.validate(emailCtrl.text.trim()) &&
        messageCtrl.text.trim().isNotEmpty);
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
              // Куди вона перекидатиме, якщо це перший екран?
            },
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    icon: _Icon(),
                    labelText: 'Name',
                  ),
                ),
                TextFormField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(
                    icon: _Icon(),
                    labelText: 'Email',
                  ),
                ),
                TextFormField(
                  controller: messageCtrl,
                  decoration: const InputDecoration(
                    icon: _Icon(),
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
                  onPressed: isButtonEnabled ? sendUser : null,
                  child: Text(
                    isLoading ? "Please wait" : "Send",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendUser() async {
    setState(() => isLoading = true);
    final user = UserModel(
      name: nameCtrl.text.trim(),
      email: emailCtrl.text.trim(),
      message: messageCtrl.text.trim(),
    );
    await UserApi().sendUser(user).then((result) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result
              ? "User data has been successfully uploaded to the server"
              : "Error uploading user data to the server"),
        ),
      );
    });
  }
}

class _Icon extends StatelessWidget {
  const _Icon();
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.orange[100],
      child: const Icon(
        Icons.lock_open_outlined,
        size: 18,
        color: Colors.orange,
      ),
    );
  }
}
