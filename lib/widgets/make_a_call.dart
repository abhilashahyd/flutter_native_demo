import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // call with dial pad
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class MakeACall extends StatelessWidget {
  Future<void> _makePhoneCall(String contact, bool direct) async {
    if (direct == true) {
      bool res = await FlutterPhoneDirectCaller.callNumber(contact);
      print(res);
    } else {
      String telScheme = 'tel:$contact';

      if (await canLaunch(telScheme)) {
        await launch(telScheme);
      } else {
        throw 'Could not launch $telScheme';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 130),
          child: Card(
            elevation: 15,
            child: Container(
                height: 80,
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone),
                    Text("Make a Call",
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                )),
          )),
      onTap: () => _makePhoneCall('0123456789', true),
    );
  }
}
