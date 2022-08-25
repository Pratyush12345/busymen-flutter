import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodePage extends StatelessWidget {
  const QRCodePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your QR Code"),),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10.0),
        child: QrImage(
              data: "BzQQyCZeXTaKuunaVQZ8jBqzOI32&&name&&7985624428",
              version: QrVersions.auto,
              size: 200.0,
            ) ,
      ),
    );
  }
}