import 'package:Busyman/services/sizeconfig.dart';
import 'package:Busyman/views/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _mobileController = TextEditingController();
  bool _numberlengtherror = false;
  @override
  Widget build(BuildContext context) {
    App _app = App(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: _app.appHeight(25),
                  ),
                  const Text(
                    'Let\'s get\nstarted !',
                    style: TextStyle(
                        color: Color(0xff297687),
                        fontSize: 32,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: _app.appHeight(10),
                  ),
                  const Text('Please enter your phone number to login',
                      style: TextStyle(
                          color: Color(0xff297687),
                          fontSize: 16,
                          fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: _app.appHeight(5),
                  ),
                  TextField(
                    controller: _mobileController,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      setState(() {
                        _numberlengtherror = false;
                      });
                    },
                    decoration: InputDecoration(
                      errorText: (_numberlengtherror
                          ? 'Please enter a valid phone number'
                          : null),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xff858585))),
                      labelText: 'Phone Number',
                      hintText: '+91xxxxxxxxxx',
                      contentPadding: EdgeInsets.fromLTRB(
                          20.0,
                          MediaQuery.of(context).size.height * 0.02,
                          20.0,
                          MediaQuery.of(context).size.height * 0.02),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xff858585))),
                    ),
                  ),
                  SizedBox(
                    height: _app.appHeight(10),
                  ),
                  TextButton(
                      onPressed: () {
                        if (_mobileController.text.length == 10) {
                          LoginVM.instance.verifyPhone(
                              context, '+91' + _mobileController.text);
                          Navigator.of(context).pushNamed('/otp');
                        } else {
                          setState(() {
                            _numberlengtherror = true;
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        child: const Center(
                          child: const Text("Continue",
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
                            borderRadius: BorderRadius.circular(15)),
                      ))
                ],
              ),
            ),
            Positioned(
                top: _app.appHorizontalPadding(5),
                left: _app.appHorizontalPadding(49),
                child: Image.asset('assets/images/Polygon1.png')),
            Positioned(
                left: _app.appHorizontalPadding(47),
                child: Image.asset('assets/images/Polygon2.png')),
            Positioned(
                left: _app.appHorizontalPadding(67),
                child: Image.asset('assets/images/Polygon3.png')),
            Positioned(
                left: 0,
                bottom: 0,
                child: Image.asset('assets/images/Polygon4.png')),
            Positioned(
                left: _app.appHorizontalPadding(20),
                bottom: 0,
                child: Image.asset('assets/images/Polygon5.png')),
            Positioned(
                left: _app.appHorizontalPadding(52),
                bottom: 0,
                child: Image.asset('assets/images/Polygon6.png')),
          ],
        ));
  }
}
