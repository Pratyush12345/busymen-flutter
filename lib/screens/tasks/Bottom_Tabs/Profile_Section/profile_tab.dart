import 'package:Busyman/provider/loginprovider.dart';
import 'package:Busyman/screens/Twitter/backend/providers/dashboard_provider.dart';
import 'package:Busyman/screens/Twitter/backend/utils/appconstant.dart';
import 'package:Busyman/screens/Twitter/frontened/TopBars/topbar.dart';
import 'package:Busyman/screens/tasks/Bottom_Tabs/Profile_Section/profile_tab_vm.dart';
import 'package:Busyman/services/appColor.dart';
import 'package:Busyman/services/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {

  const ProfileTab({ Key? key }) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late App _app;
  
  
  Widget getRow(IconData icon,String labeltext, String text){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Expanded(
         flex: 1,
         child: Icon(icon, color: blueColour, size: 28.0,)),
       SizedBox(width: 24.0),
       Expanded(
         flex: 5,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(labeltext, style: TextStyle(fontSize: 18.0, color: Colors.grey),),
             SizedBox(
                      height: _app.appVerticalPadding(1.0),
                    ),
             Text(text, style: TextStyle(fontSize: 18.0,),),
             SizedBox(
                      height: _app.appVerticalPadding(3.5),
                    ),
           ],
         ),
       )
     ],
    );
  }
  Widget getLogOUT(IconData icon,String labeltext){
    return InkWell(
      onTap: (){
         Auth.instance.signOut();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Expanded(
           flex: 1,
           child: Icon(icon, color: Colors.red, size: 28.0,)),
         SizedBox(width: 24.0),
         Expanded(
           flex: 5,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(labeltext, style: TextStyle(fontSize: 18.0, color: Colors.black)),
               SizedBox(
                        height: _app.appVerticalPadding(1.0),
                      ),
                Text("", style: TextStyle(fontSize: 12.0)),
                     
               SizedBox(
                        height: _app.appVerticalPadding(2.0),
                      ),
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
            height: _app.appVerticalPadding(10.5),
          ),

          SingleChildScrollView(
            child: Padding(
              
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Consumer<UserProfileProvider>(
                builder: (context, model, child)=>
                 model.boolerrorOccured? AppConstant.noDataFound("Error Occurred") : ProfileTabVM.instance.showIndicator ? AppConstant.circulerProgressIndicator(): 
                 model.usermodel!.name.isEmpty? AppConstant.noDataFound("Please Add Your Profile") :
                 Column(
                  children: [
                   getRow(Icons.supervised_user_circle_outlined, "Name", model.usermodel!.name), 
                   getRow(Icons.location_searching_outlined , "Position", model.usermodel!.positionName),
                   getRow(Icons.phone_in_talk_outlined, "Phone Number", model.usermodel!.phoneNumber),
                   getRow(Icons.location_on_outlined, "Office Address", model.usermodel!.officeAddress),
                   getRow(Icons.home_outlined, "Local Address" , model.usermodel!.localAddress),
                   SizedBox(height: 40.0,),
                  ],
                ),
              ),
            ),
          ),
                 Spacer(),
                 Padding(
                   
                   padding: const EdgeInsets.symmetric(horizontal: 32.0),
                   child: getLogOUT(Icons.logout, "Log Out"),
                 ),
        ],
      ),
    );
  }
}