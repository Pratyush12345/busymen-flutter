import 'package:Busyman/screens/Bottom_Tabs/Account_Manage_Section/QR_code_page.dart';
import 'package:Busyman/screens/Bottom_Tabs/Account_Manage_Section/QR_scan_page.dart';
import 'package:flutter/material.dart';

class ManageAccountPage extends StatefulWidget {
  const ManageAccountPage({ Key? key }) : super(key: key);

  @override
  State<ManageAccountPage> createState() => _ManageAccountPageState();
}

class _ManageAccountPageState extends State<ManageAccountPage> { 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Account Access"),),
      body: ListView(
        children: [
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>QRCodePage()));
            },
            child: Text("Your QR Code")),
          SizedBox(height: 20.0,),
          InkWell(          
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>QRScanPage()));
            },
            child: Text("Scan QR Code")),
          SizedBox(height: 20.0,),
          Text("Account Managed By"),
          Container(
            height: 300,
            child: ListView.builder(
              itemCount: 0,
              itemBuilder: (context, index){
                return InkWell(); 
              } 
              )
          ),
          SizedBox(height: 10.0,),
          Text("Account Managing Of"),
          Container(
            height: 300,
            
          )
        ],
      ),
    );
  }
}