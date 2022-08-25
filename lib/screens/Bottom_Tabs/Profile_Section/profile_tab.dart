
import 'package:Busyman/provider/loginprovider.dart';
import 'package:Busyman/screens/Twitter/backend/providers/change_bottom_tab_provider.dart';
import 'package:Busyman/screens/Twitter/backend/providers/dashboard_provider.dart';
import 'package:Busyman/screens/Twitter/backend/utils/appconstant.dart';
import 'package:Busyman/screens/Twitter/backend/utils/global_variable.dart';
import 'package:Busyman/screens/Twitter/frontened/TopBars/topbar.dart';
import 'package:Busyman/screens/Bottom_Tabs/Profile_Section/profile_tab_vm.dart';
import 'package:Busyman/services/appColor.dart';
import 'package:Busyman/services/sizeconfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {

  const ProfileTab({ Key? key }) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late App _app;
  bool ischanged = false;
  String uid = "";

  void showAppLogoutDialog(){
     showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(cornerRadiusTaskWidget)),
                    
                    title: const Text(
                      'Are You sure, You want to Logout?',
                      style: TextStyle(
                          color: Color(0xff2E2E2E),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    actions: [
                      MaterialButton(
                          height: 45.0,
                          minWidth: 100.0,
                          elevation: 0.0,
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('NO', style: TextStyle(color: blueColour),)),
                        MaterialButton(
                          height: 45.0,
                          minWidth: 100.0, 
                          elevation: 0.0,
                          
                          color: blueColour,
                          onPressed: () async{
                             Navigator.of(context).pop();
                             Auth.instance.signOut(); 
                          },
                          child: Text('YES', style: TextStyle(color: Colors.white) )),
                        
                  
                    ],
                  );
                });
  }
  Widget getRowSvg(String path,String labeltext, String text){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Expanded(
         flex: 1,
         child: SvgPicture.asset(
                    "$path",
                    color: blueColour,
                    width: 20.0,
                    placeholderBuilder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(2.0),
                        child: const CircularProgressIndicator()),
                  ),  
         ),
       SizedBox(width: 24.0),
       Expanded(
         flex: 5,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(labeltext, style: TextStyle(fontSize: 15.0, color: Colors.grey),),
             SizedBox(
                      height: _app.appVerticalPadding(1.3),
                    ),
             Text(text, style: TextStyle(fontSize: 17.0,),),
             SizedBox(
                      height: _app.appVerticalPadding(3.5),
                    ),
           ],
         ),
       )
     ],
    );
  }

  Widget getRow(IconData icon,String labeltext, String text){
    return InkWell(
      onDoubleTap:  labeltext == "Switch Account"? (){
        ischanged= !ischanged;
        // if(ischanged){
        //   uid = "BzQQyCZeXTaKuunaVQZ8jBqzOI32";
        // }
        // else{
        //   uid = FirebaseAuth.instance.currentUser!.uid;
        // }

        if(GlobalVariable.uid == "BzQQyCZeXTaKuunaVQZ8jBqzOI32"){
          uid = FirebaseAuth.instance.currentUser!.uid;
        }else{
          uid = "BzQQyCZeXTaKuunaVQZ8jBqzOI32";
        }

        print("uid-----------------$uid");
        GlobalVariable.uid = uid;
        Provider.of<ChangeBottomTabProvider>(context, listen: false).changeBottomTabProvider(selectedIndexLocal: 0);
      } : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Expanded(
           flex: 1,
           child: Icon(icon, color: blueColour, size: 26.0,
           )),
         SizedBox(width: 24.0),
         Expanded(
           flex: 5,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(labeltext, style: TextStyle(fontSize: 15.0, color: Colors.grey),),
               SizedBox(
                        height: _app.appVerticalPadding(1.3),
                      ),
               Text( text, style: TextStyle(fontSize: 17.0,),),
               SizedBox(
                        height: _app.appVerticalPadding(3.5),
                      ),
             ],
           ),
         )
       ],
      ),
    );
  }
  Widget getLogOUT(IconData icon,String labeltext){
    return InkWell(
      onTap: () {
        showAppLogoutDialog();
        //  for(int i=1;i<=1000;i++){
        //   FirebaseDatabase.instance.reference().child("RobotDetail/robot$i").update({
        //   "id" : i,
        //   "robot_status" : 6,
        //   "robot_dir" : 6,
        //   "brush_status" : 6
        //  });
        //  }
         //Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestScreen()));
         
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Expanded(
           flex: 1,
           child: Icon(icon, color: Colors.red, size: 26.0,)),
         SizedBox(width: 24.0),
         Expanded(
           flex: 5,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(labeltext, style: TextStyle(fontSize: 15.0, color: Colors.black)),
               SizedBox(
                        height: _app.appVerticalPadding(1.3),
                      ),
                Text( "", style: TextStyle(fontSize: 17.0,),),
              //  SizedBox(
              //           height: _app.appVerticalPadding(3.5),
              //         ),
             
               ],
           ),
         )
       ],
      ),
    );
  }

  @override
    void initState() {
      ProfileTabVM.instance.fetchUserDetail(context);
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    
   _app = App(context);
    return Scaffold(
      body: Column(
        children: [
          TwitterTopView(headerName: "Your Profile"),
          SizedBox(
            height: _app.appVerticalPadding(8.5),
          ),
          SizedBox(height: 15.0,),
          SingleChildScrollView(
            child: Padding(
              
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Consumer<UserProfileProvider>(
                builder: (context, model, child)=>
                 model.boolerrorOccured? AppConstant.noDataFound("Error Occurred") : ProfileTabVM.instance.showIndicator ? AppConstant.circulerProgressIndicator(): 
                 model.usermodel!.name.isEmpty? AppConstant.noDataFound("Please Add Your Profile") :
                 Column(
                  children: [
                   getRow(Icons.perm_identity, "Name", model.usermodel!.name), 
                   getRow(Icons.location_searching_outlined , "Position", model.usermodel!.positionName),
                   getRow(Icons.phone_outlined, "Phone Number", model.usermodel!.phoneNumber),
                   
                   //getRowSvg("assets/svg/phone.svg", "Phone Number", model.usermodel!.phoneNumber),
                   getRow(Icons.location_on_outlined, "Office Address", model.usermodel!.officeAddress),
                   getRow(Icons.home_outlined, "Local Address" , model.usermodel!.localAddress),
                   //getRow(Icons.radio_button_checked, "Switch Account" , ""),
                   //getRowSvg("assets/svg/local-address.svg", "Local Address" , model.usermodel!.localAddress),
                   SizedBox(height: 8.0,),
                  ],
                ),
              ),
            ),
          ),
                 Spacer(),
                 Padding(
                   
                   padding: const EdgeInsets.symmetric(horizontal: 18.0),
                   child: getLogOUT(Icons.logout, "Log Out"),
                 ),
        ],
      ),
    );
  }
}