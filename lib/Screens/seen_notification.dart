import 'package:doctor_appointment_app/Services/ApiServices.dart';
import 'package:doctor_appointment_app/model/seen_notfication.dart';
import 'package:flutter/material.dart';

class SeenNotiScreen extends StatefulWidget {
  const SeenNotiScreen({super.key});

  @override
  State<SeenNotiScreen> createState() => _SeenNotiScreenState();
}

class _SeenNotiScreenState extends State<SeenNotiScreen> {
  @override
  Widget build(BuildContext context) {
    bool isdelete = true;
    return Scaffold(
        appBar: AppBar(
            title: const Text("All Notifications"),
            backgroundColor: Colors.grey,
            actions: [
              ElevatedButton(
                onPressed: () async {
                  isdelete = await Apiservices.deleteNoti();
                  setState(() {});
                },
                child: const Text("Delete All"),
              ),
            ]),
        body: FutureBuilder<SeenNotification>(
          future: Apiservices.seenAllNoti(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.data == null) {
              return const Center(
                child: Text('No data available'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.data!.seenNotifications!.length,
                itemBuilder: (context, index) {
                  final seenNotification =
                      snapshot.data!.data!.seenNotifications![index];
                  if (seenNotification.data != null) {
                    final seenData = seenNotification.data!;
                    return isdelete
                        ? ListTile(
                            title: Text(seenData.name ?? 'Name not available'),
                            subtitle: Text(seenNotification.message ??
                                'Name not available'),
                          )
                        : Container();
                  } else {
                    return const Text('No data available');
                  }
                },
              );
            }
          },
        ));
  }
}
