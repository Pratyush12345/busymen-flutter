
import 'package:Busyman/models/models.dart';
import 'package:Busyman/screens/Twitter/backend/providers/dashboard_provider.dart';
import 'package:Busyman/screens/Bottom_Tabs/Profile_Section/profile_tab_vm.dart';
import 'package:Busyman/services/appColor.dart';
import 'package:Busyman/services/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProfileTab extends StatefulWidget {
  final bool isEdit;
  const AddProfileTab({ Key? key, required this.isEdit }) : super(key: key);

  @override
  _AddProfileTabState createState() => _AddProfileTabState();
}

class _AddProfileTabState extends State<AddProfileTab> {
  late App _app;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _positioncontroller = TextEditingController();
  TextEditingController _phoneNumbercontroller = TextEditingController();
  TextEditingController _officaladdresscontroller = TextEditingController();
  TextEditingController _localAddresscontroller = TextEditingController();
  
  @override
    void initState() {
      if(widget.isEdit){
        UserDetailModel? model = Provider.of<UserProfileProvider>(context, listen: false).usermodel;
        _namecontroller.text = model!.name;
        _positioncontroller.text = model.positionName;
        _phoneNumbercontroller.text = model.phoneNumber;
        _officaladdresscontroller.text = model.officeAddress;
        _localAddresscontroller.text = model.localAddress;
      }
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    const sty = TextStyle(fontSize: 20.0);
    _app = App(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Color(0xff297687)),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff297687),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _app.appVerticalPadding(10.5),
            ),

            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Column(
                  children: [
                    TextFormField(
                              controller: _namecontroller,
                              keyboardType: TextInputType.name,
                              validator: (str) {
                                if (str == null || str.isEmpty) {
                                  return 'This field can not be empty';
                                }
                              },
                              decoration:
                                  const InputDecoration(labelText: 'Name',labelStyle: sty ) ,
                            ),
                    SizedBox(
                          height: _app.appVerticalPadding(3.0),
                        ),
                    TextFormField(
                              controller: _positioncontroller,
                              keyboardType: TextInputType.name,
                              validator: (str) {
                                if (str == null || str.isEmpty) {
                                  return 'This field can not be empty';
                                }
                              },
                              decoration:
                                  const InputDecoration(labelText: 'Position Name', labelStyle: sty),
                            ),
                    SizedBox(
                          height: _app.appVerticalPadding(3.0),
                        ),
                    TextFormField(
                              controller: _phoneNumbercontroller,
                              keyboardType: TextInputType.number,
                              validator: (str) {
                                if (str == null || str.isEmpty) {
                                  return 'This field can not be empty';
                                }
                              },
                              decoration:
                                  const InputDecoration(labelText: 'Phone Number', labelStyle: sty),
                            ),
                    SizedBox(
                          height: _app.appVerticalPadding(3.0),
                        ),
                    TextFormField(
                              controller: _officaladdresscontroller,
                              keyboardType: TextInputType.name,
                              validator: (str) {
                                if (str == null || str.isEmpty) {
                                  return 'This field can not be empty';
                                }
                              },
                              decoration:
                                  const InputDecoration(labelText: 'Office Address', labelStyle: sty),
                            ),
                    SizedBox(
                          height: _app.appVerticalPadding(3.0),
                        ),
                    TextFormField(
                              controller: _localAddresscontroller,
                              keyboardType: TextInputType.name,
                              validator: (str) {
                                if (str == null || str.isEmpty) {
                                  return 'This field can not be empty';
                                }
                              },
                              decoration:
                                  const InputDecoration(labelText: 'Local Address', labelStyle: sty),
                            ),
                    SizedBox(
                          height: _app.appVerticalPadding(3.0),
                        ),    
                    SizedBox(
                          height: _app.appVerticalPadding(9.0),
                        ),
                    ],
                ),
              ),
            ),
            TextButton(        
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            UserDetailModel model = UserDetailModel(
                              name: _namecontroller.text.trim(),
                              positionName: _positioncontroller.text.trim(),
                              phoneNumber: _phoneNumbercontroller.text.trim(),
                              localAddress: _localAddresscontroller.text.trim(),
                              officeAddress: _officaladdresscontroller.text.trim()
                            );
                            await ProfileTabVM.instance.addUpdateProfile(context, model);
                            await ProfileTabVM.instance.fetchUserDetail(context);
                            Navigator.of(context).pop();
                          }
                        },
                        child: Container(
                          width: _app.appWidth(90),
                          height: 40,
                          child: const Center(
                            child: const Text("Save",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: const [
                                Color(0xff205072),
                                Color(0xff2E8C92)
                              ]),
                              borderRadius: BorderRadius.circular(buttonRadius)),
                        ))        
                      
                    
          ],
        ),
      ),
    );
  }
}