import 'package:Busyman/screens/Twitter/backend/utils/appconstant.dart';
import 'package:Busyman/services/sizeconfig.dart';
import 'package:Busyman/view_models/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpScreen extends StatefulWidget {
  final String? phoneNumber; 
  OtpScreen({@required this.phoneNumber, Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _pinPutController = TextEditingController();

  final _pinPutFocusNode = FocusNode();
  int count = 0;
  bool keyboard = false;
  bool _showIndicator = false;

  @override
  Widget build(BuildContext context) {
    App _app = App(context);
    BoxDecoration pinPutDecoration = BoxDecoration(
      border: Border.all(
        color: const Color(0xFFA9E0FF),
        width: 1,
      ),
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    );
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
                    'OTP\nVerification !',
                    style: TextStyle(
                        color: Color(0xff297687),
                        fontSize: 32,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: _app.appHeight(10),
                  ),
                  const Text(
                      'Please type the verification code sent to your entered mobile number',
                      style: TextStyle(
                          color: Color(0xff297687),
                          fontSize: 16,
                          fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: _app.appHeight(5),
                  ),
                  Container(
                    width: _app.appWidth(100),
                    child: PinPut(
                      onTap: () {
                        keyboard = true;
                      },
                      onSubmit: (value) {
                        keyboard = false;
                      },
                      onSaved: (value) {
                        keyboard = true;
                      },
                      withCursor: true,
                      fieldsCount: 6,
                      textStyle: TextStyle(fontSize: 20, color: Colors.red),
                      eachFieldWidth: 40,
                      eachFieldHeight: 40,
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,
                      submittedFieldDecoration: pinPutDecoration,
                      selectedFieldDecoration: pinPutDecoration,
                      followingFieldDecoration: pinPutDecoration,
                      checkClipboard: true,
                      enabled: true,
                    ),
                  ),
                  SizedBox(
                    height: _app.appHeight(5),
                  ),
                   InkWell(
                    onTap: () {
                         count++;
                         LoginVM.instance.verifyPhone(
                              context, '+91' + widget.phoneNumber!, count); 
                         setState(() { });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          count==0?'No Otp ' : "",
                          style: TextStyle(
                            color: Color(0xff959595),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          count==0? 'Resend it!' : "OTP Resent!",
                          style: TextStyle(
                            color: Color(0xff297687),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  ),
                  SizedBox(
                    height: _app.appHeight(10),
                  ),
                  _showIndicator ? AppConstant.circulerProgressIndicator():
                  TextButton(
                      onPressed: () async {
                        _showIndicator = true;
                        
                        setState(() {});
                        
                        await LoginVM.instance
                            .manualLogin(_pinPutController.text);
                        
                        _showIndicator = false;
                        
                        setState(() {});  

                        Navigator.of(context).pushReplacementNamed('/connectivityWrapper');
                      },
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        child: const Center(
                          child: const Text("Verify",
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
                left: _app.appHorizontalPadding(27),
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
