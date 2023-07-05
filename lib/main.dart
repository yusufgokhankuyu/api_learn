import 'package:flutter/material.dart';
import 'package:flutter_api/model/user_model.dart';
import 'package:flutter_api/services/user_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserService _service = UserService();

  List<Datum> users = [];

  bool? isLoading;

  @override
  void initState() {
    super.initState();
    _service.fetchUsers().then((value) {
      if (value != null && value.data != null) {
        setState(() {
          users = value.data;
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Restfull API "),
        ),
        body: isLoading == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : isLoading == true
                ? ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            "${index + 1}.  ${users[index].firstName}${users[index].lastName}"),
                        subtitle: Text(users[index].email),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(users[index].avatar),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text("Hata Oluştu"),
                  ),
      ),
    );
  }
}
