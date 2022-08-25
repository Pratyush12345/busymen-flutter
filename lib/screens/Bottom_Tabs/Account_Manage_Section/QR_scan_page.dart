import 'package:flutter/material.dart';
import 'package:scan/scan.dart';
//import 'package:mobile_scanner/mobile_scanner.dart';

class QRScanPage extends StatelessWidget {
  QRScanPage({ Key? key }) : super(key: key);
final ScanController controller = ScanController();
final String qrcode = 'Unknown';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your QR Code"),),
      body: Container(
  width: 250, // custom wrap size
  height: 250,
  child: ScanView(
    controller: controller,
// custom scan area, if set to 1.0, will scan full area
    scanAreaScale: .7,
    scanLineColor: Colors.green.shade400,
    onCapture: (data) {
      print(data);
      print("data isasssssssssssss");
      
      // do something
    },
  ),
),
    );
  }
}