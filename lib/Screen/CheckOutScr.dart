import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import '../Backend/Resp/reg_login_resp.dart';
import '../Elements/baseAppbar.dart';
import '../Elements/button.dart';
import '../Elements/formfield.dart';

import '../Elements/validate.dart';
import '../utils/app_constants.dart';
import '../utils/common.dart';
import '../utils/shared_helper.dart';
import '../utils/style.dart';

import 'Order.dart';
import 'addressScr.dart';

// class CheckOutScreen extends StatefulWidget {
//   final dynamic cartData;
//   final dynamic shipPrice;
//   final dynamic subPrice;
//   const CheckOutScreen({Key? key, this.cartData, this.shipPrice, this.subPrice})
//       : super(key: key);

//   @override
//   State<CheckOutScreen> createState() => _CheckOutScreenState();
// }

// class _CheckOutScreenState extends State<CheckOutScreen> {
//   dynamic value1 = false;
//   dynamic value2 = false;

//   final TextEditingController fNameController = TextEditingController();
//   final TextEditingController lNameController = TextEditingController();

//   final TextEditingController companyController = TextEditingController();
//   final TextEditingController countryController = TextEditingController();

//   final TextEditingController street1Controller = TextEditingController();
//   final TextEditingController street2Controller = TextEditingController();

//   final TextEditingController townController = TextEditingController();
//   final TextEditingController stateController = TextEditingController();
//   final TextEditingController pinCodeController = TextEditingController();

//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController mobileController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController fNameController2 = TextEditingController();
//   final TextEditingController lNameController2 = TextEditingController();

//   final TextEditingController companyController2 = TextEditingController();
//   final TextEditingController countryController2 = TextEditingController();

//   final TextEditingController street1Controller2 = TextEditingController();
//   final TextEditingController street2Controller2 = TextEditingController();

//   final TextEditingController townController2 = TextEditingController();
//   final TextEditingController stateController2 = TextEditingController();
//   final TextEditingController pinCodeController2 = TextEditingController();

//   final TextEditingController orderDesController = TextEditingController();

//   dynamic billing;
//   dynamic shipping;
//   dynamic description;
//   bool? isLogin =false;
//   dynamic userId;

//   SharedHelper sharedHelper = SharedHelper();

//   @override
//   void initState() {
//     // TODO: implement initState
//     _checkLogin();

//     super.initState();
//   }

//   _checkLogin() async {
//     bool isLog = await sharedHelper.containsKey('current_user');
//     bool isUser = await sharedHelper.containsKey('userIdType');

//     dynamic userIds = await sharedHelper.getUserTypeScr('userIdType');

//     setState(() {
//       isLogin = isLog;
//       userId = isUser == true ? userIds : 0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('isLogin in checkout $isLogin');
//     _saveMethod() async {
//       var isvalid = _formKey.currentState!.validate();

//       if (!isvalid) {
//         return 'Please Enter Valid Data';
//       }
//       _formKey.currentState!.save();
//       if (isvalid == true) {
//         // print("condtion is true");

//         setState(() {
//           billing = {
//             "first_name": fNameController.text,
//             "last_name": lNameController.text,
//             "company": companyController.text,
//             "address_1": street1Controller.text,
//             "address_2": street2Controller.text,
//             "city": townController.text,
//             "state": stateController.text,
//             "postcode": pinCodeController.text,
//             "country": countryController.text,
//             "email": emailController.text,
//             "phone": mobileController.text
//           };

//           shipping = {
//             "first_name": fNameController2.text,
//             "last_name": lNameController2.text,
//             "company": companyController2.text,
//             "address_1": street1Controller2.text,
//             "address_2": street2Controller2.text,
//             "city": townController2.text,
//             "state": stateController2.text,
//             "postcode": pinCodeController2.text,
//             "country": countryController2.text,
//             "phone": mobileController.text
//           };

//           description = orderDesController.text;
//         });

//         navigationPush(
//             context,
//             OrderScreen(
//                 isLogin: isLogin,
//                 userId: userId,
//                 password: passwordController.text,
//                 billing: billing,
//                 shipping: shipping,subPrice:widget.subPrice,
//                 description: description));
//       }
//     }

//     return Scaffold(
//       appBar: BaseAppBar(
//         title: 'CheckOut Screen',
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//             key: _formKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 // shrinkWrap: true,
//                 children: [
//                   AddressField(
//                     fNameController: fNameController,
//                     lNameController: lNameController,
//                     companyController: companyController,
//                     countryController: countryController,
//                     townController: townController,
//                     stateController: stateController,
//                     street1Controller: street1Controller,
//                     street2Controller: street2Controller,
//                     pinCodeController: pinCodeController,
//                     emailController: emailController,
//                     mobileController: mobileController,
//                   ),
//                   // ! Create an Account

//                   Container(
//                     child: isLogin == false
//                         ? EditTextField(
//                             textAlign: TextAlign.left,
//                             txtColor: txtBlackColor,
//                             formBox: true,
//                             fillColor: borderColor,
//                             headTxt: 'Password',
//                             // hintText: 'Enter First Name',
//                             controller: passwordController,
//                             vertical: 15,
//
//                             validator: (v) => validateField(v!),
//                           )
//                         : null,
//                   ),

//                   // Row(
//                   //   children: [
//                   //     Checkbox(
//                   //       value: value1,
//                   //       onChanged: (bool? value) {
//                   //         setState(() {
//                   //           value1 = value;
//                   //         });
//                   //       },
//                   //     ),
//                   //     Text('Create an Account', style: smallTextStyle),
//                   //   ],
//                   // ),
//                   Row(
//                     children: [
//                       Checkbox(
//                         value: value2,
//                         onChanged: (bool? value) {
//                           setState(() {
//                             value2 = value;
//                           });
//                         },
//                       ),
//                       Text('shpping address', style: smallTextStyle),
//                     ],
//                   ),
//                   // ! Shpping Billing Address
//                   Container(
//                       child: value2 == true
//                           ? ListView(
//                               shrinkWrap: true,
//                               // mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text('Shpping Address ', style: labelTextStyle),
//                                 AddressField(
//                                   fieldShow: false,
//                                   validate: value2 == true ? true : false,
//                                   fNameController: fNameController2,
//                                   lNameController: lNameController2,
//                                   companyController: companyController2,
//                                   countryController: countryController2,
//                                   townController: townController2,
//                                   stateController: stateController2,
//                                   street1Controller: street1Controller2,
//                                   street2Controller: street2Controller2,
//                                   pinCodeController: pinCodeController2,
//                                 ),
//                               ],
//                             )
//                           : null),

//                   EditTextField(
//                     textAlign: TextAlign.left,
//                     txtColor: txtBlackColor,
//                     formBox: true,
//                     fillColor: borderColor,
//                     vertical: 15,
//                     controller: orderDesController,
//                     // minLines: 3,
//                     // maxLines: 4,
//                     headTxt: 'Description',
//                     hintText: 'Order Descrtiption (optional)',
//                   )
//                 ],
//               ),
//             )),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
//         child: Btn(
//           height: 35,
//           width: double.infinity,
//           btnName: 'Place Order',
//           txtColor: txtWhiteColor,
//           color: yellowColor,
//           onTap: _saveMethod,
//         ),
//       ),
//     );
//   }
// }

class CheckOutScreen extends StatefulWidget {
  final dynamic cartData;
  final dynamic shipPrice;
  final dynamic subPrice;
  const CheckOutScreen({Key? key, this.cartData, this.shipPrice, this.subPrice})
      : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  dynamic value1 = false;
  dynamic value2 = false;

  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();

  final TextEditingController companyController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  final TextEditingController street1Controller = TextEditingController();
  final TextEditingController street2Controller = TextEditingController();

  final TextEditingController townController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController fNameController2 = TextEditingController();
  final TextEditingController lNameController2 = TextEditingController();

  final TextEditingController companyController2 = TextEditingController();
  final TextEditingController countryController2 = TextEditingController();

  final TextEditingController street1Controller2 = TextEditingController();
  final TextEditingController street2Controller2 = TextEditingController();

  final TextEditingController townController2 = TextEditingController();
  final TextEditingController stateController2 = TextEditingController();
  final TextEditingController pinCodeController2 = TextEditingController();

  final TextEditingController orderDesController = TextEditingController();

  dynamic billing;
  dynamic shipping;
  dynamic description;
  bool? isLogin = false;
  dynamic userId;

  SharedHelper sharedHelper = SharedHelper();

  @override
  void initState() {
    // TODO: implement initState
    _checkLogin();

    super.initState();
  }

  _checkLogin() async {
    bool isLog = await sharedHelper.containsKey('current_user');
    bool isUser = await sharedHelper.containsKey('userIdType');

    dynamic userIds = await sharedHelper.getUserTypeScr('userIdType');

    setState(() {
      isLogin = isLog;
      userId = isUser == true ? userIds : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    _saveMethod() async {
      var isvalid = _formKey.currentState!.validate();
      dynamic userEs = false;
      if (isLogin != true && userId != true) {
        dynamic userE = await userExists(email: emailController.text);
        if (userE == true) {
          setState(() {
            userEs = true;
          });
          snackBar(context, 'User Already Exists');
        } else {
          setState(() {
            userEs = false;
          });
        }
      }

      if (!isvalid) {
        return 'Please Enter Valid Data';
      }
      _formKey.currentState!.save();
      if (isvalid == true && userEs != true) {
        // print("condtion is true");

        setState(() {
          billing = {
            "first_name": fNameController.text,
            "last_name": lNameController.text,
            "company": companyController.text,
            "address_1": street1Controller.text,
            "address_2": street2Controller.text,
            "city": townController.text,
            "state": stateController.text,
            "postcode": pinCodeController.text,
            "country": countryController.text,
            "email": emailController.text,
            "phone": mobileController.text
          };

          shipping = {
            "first_name": fNameController2.text,
            "last_name": lNameController2.text,
            "company": companyController2.text,
            "address_1": street1Controller2.text,
            "address_2": street2Controller2.text,
            "city": townController2.text,
            "state": stateController2.text,
            "postcode": pinCodeController2.text,
            "country": countryController2.text,
            "phone": mobileController.text
          };

          description = orderDesController.text;
        });

        navigationPush(
            context,
            OrderScreen(
                isLogin: isLogin,
                userId: userId,
                password: passwordController.text,
                billing: billing,
                shipping: shipping,
                subPrice: widget.subPrice,
                description: description));
      }
    }

    return Scaffold(
      appBar: BaseAppBar(
        title: 'CheckOut Screen',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                EditTextField(
                  textAlign: TextAlign.left,
                  txtColor: txtBlackColor,
                  formBox: true,
                  fillColor: borderColor,
                  headTxt: 'FirstName',
                  // hintText: 'Enter First Name',
                  controller: fNameController,
                  vertical: 15,
                  maxLength: 10,

                  validator: (v) => validateField(v!),
                ),
                heightSizedBox(10.0),
                EditTextField(
                  textAlign: TextAlign.left,
                  txtColor: txtBlackColor,
                  formBox: true,
                  fillColor: borderColor,
                  headTxt: 'Last Name',
                  // hintText: 'Enter Last Name',
                  controller: lNameController,
                  vertical: 15,
                  maxLength: 10,

                  validator: (v) => validateField(v!),
                ),
                heightSizedBox(10.0),
                EditTextField(
                  textAlign: TextAlign.left,
                  txtColor: txtBlackColor,
                  formBox: true,
                  fillColor: borderColor,
                  headTxt: 'Country name (optional)',
                  // hintText: 'Enter Email',
                  controller: countryController,
                  vertical: 15,
                  maxLength: 10,
                ),
                heightSizedBox(10.0),
                EditTextField(
                  textAlign: TextAlign.left,
                  txtColor: txtBlackColor,
                  formBox: true,
                  fillColor: borderColor,
                  headTxt: 'Street address',
                  hintText: 'House Number and street number',
                  controller: street1Controller,
                  vertical: 15,
                  validator: (v) => validateField(v!),
                ),

                heightSizedBox(10.0),
                EditTextField(
                  textAlign: TextAlign.left,
                  txtColor: txtBlackColor,
                  formBox: true,
                  fillColor: borderColor,
                  hintText: 'Apartment , suit ,etc',
                  controller: street2Controller,
                  vertical: 15,
                  validator: (v) => validateField(v!),
                ),

                heightSizedBox(10.0),
                EditTextField(
                  textAlign: TextAlign.left,
                  txtColor: txtBlackColor,
                  formBox: true,
                  fillColor: borderColor,
                  headTxt: 'Town/City',
                  controller: townController,
                  vertical: 15,
                  maxLength: 15,
                  validator: (v) => validateField(v!),
                ),
                heightSizedBox(10.0),
                EditTextField(
                  textAlign: TextAlign.left,
                  txtColor: txtBlackColor,
                  formBox: true,
                  fillColor: borderColor,
                  headTxt: 'State',
                  controller: stateController,
                  maxLength: 10,
                  vertical: 15,
                  validator: (v) => validateField(v!),
                ),

                heightSizedBox(10.0),
                EditTextField(
                  textAlign: TextAlign.left,
                  txtColor: txtBlackColor,
                  formBox: true,
                  fillColor: borderColor,
                  headTxt: 'PIN',
                  controller: pinCodeController,
                  vertical: 15,
                  maxLength: 9,
                  validator: (v) => validateField(v!),
                ),

                // ! Email and Phonen
                Container(
                  child:
                      // fieldShow == false
                      //     ? null
                      //     :
                      Column(
                    children: [
                      heightSizedBox(10.0),
                      EditTextField(
                        textAlign: TextAlign.left,
                        txtColor: txtBlackColor,
                        formBox: true,
                        fillColor: borderColor,
                        headTxt: 'Email',
                        // hintText: 'Enter Email',
                        controller: emailController,
                        vertical: 15,

                        maxLength: 25,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) => validateEmail(v!),
                      ),
                      heightSizedBox(10.0),
                      EditTextField(
                        textAlign: TextAlign.left,
                        txtColor: txtBlackColor,
                        formBox: true,
                        fillColor: borderColor,
                        headTxt: 'Mobile',
                        // hintText: 'Enter Username',
                        maxLength: 15,
                        controller: mobileController,
                        validator: (v) => validateField(v!),
                        vertical: 15,
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                ),

                Container(
                  child: isLogin == false
                      ? EditTextField(
                          textAlign: TextAlign.left,
                          txtColor: txtBlackColor,
                          formBox: true,
                          fillColor: borderColor,
                          headTxt: 'Password',
                          // hintText: 'Enter First Name',
                          controller: passwordController,
                          vertical: 15,

                          validator: (v) => validateField(v!),
                        )
                      : null,
                ),

                Row(
                  children: [
                    Checkbox(
                      value: value2,
                      onChanged: (bool? value) {
                        setState(() {
                          value2 = value;
                        });
                      },
                    ),
                    Text('shpping address', style: smallTextStyle),
                  ],
                ),
                // ! Shpping Billing Address
                Container(
                    child: value2 == true
                        ? Column(
                            // shrinkWrap: true,
                            children: [
                              EditTextField(
                                textAlign: TextAlign.left,
                                txtColor: txtBlackColor,
                                formBox: true,
                                fillColor: borderColor,
                                headTxt: 'FirstName',
                                // hintText: 'Enter First Name',
                                controller: fNameController2,
                                vertical: 15,
                                maxLength: 10,

                                // validator: (v) => validateField(v!),
                              ),
                              heightSizedBox(10.0),
                              EditTextField(
                                textAlign: TextAlign.left,
                                txtColor: txtBlackColor,
                                formBox: true,
                                fillColor: borderColor,
                                headTxt: 'Last Name',
                                // hintText: 'Enter Last Name',
                                controller: lNameController2,
                                vertical: 15,
                                maxLength: 10,

                                // validator: (v) => validateField(v!),
                              ),
                              heightSizedBox(10.0),
                              EditTextField(
                                textAlign: TextAlign.left,
                                txtColor: txtBlackColor,
                                formBox: true,
                                fillColor: borderColor,
                                headTxt: 'Country name (optional)',
                                // hintText: 'Enter Email',
                                controller: countryController2,
                                vertical: 15,
                                maxLength: 10,
                              ),
                              heightSizedBox(10.0),
                              EditTextField(
                                textAlign: TextAlign.left,
                                txtColor: txtBlackColor,
                                formBox: true,
                                fillColor: borderColor,
                                headTxt: 'Street address',
                                hintText: 'House Number and street number',
                                controller: street1Controller2,
                                vertical: 15,

                                // validator: (v) => validateField(v!),
                              ),
                              heightSizedBox(10.0),
                              EditTextField(
                                textAlign: TextAlign.left,
                                txtColor: txtBlackColor,
                                formBox: true,
                                fillColor: borderColor,
                                hintText: 'Apartment , suit ,etc',
                                controller: street2Controller2,
                                vertical: 15,

                                // validator: (v) => validateField(v!),
                              ),
                              heightSizedBox(10.0),
                              EditTextField(
                                textAlign: TextAlign.left,
                                txtColor: txtBlackColor,
                                formBox: true,
                                fillColor: borderColor,
                                headTxt: 'Town/City',
                                controller: townController2,
                                vertical: 15,
                                maxLength: 15,

                                // validator: (v) => validateField(v!),/
                              ),
                              heightSizedBox(10.0),
                              EditTextField(
                                textAlign: TextAlign.left,
                                txtColor: txtBlackColor,
                                formBox: true,
                                fillColor: borderColor,
                                headTxt: 'State',
                                controller: stateController2,
                                maxLength: 10,
                                vertical: 15,

                                // validator: (v) => validateField(v!),
                              ),
                              heightSizedBox(10.0),
                              EditTextField(
                                textAlign: TextAlign.left,
                                txtColor: txtBlackColor,
                                formBox: true,
                                fillColor: borderColor,
                                headTxt: 'PIN',
                                controller: pinCodeController2,
                                vertical: 15,
                                maxLength: 9,

                                // validator: (v) => validateField(v!),
                              ),
                            ],
                          )
                        : null),

                EditTextField(
                  textAlign: TextAlign.left,
                  txtColor: txtBlackColor,
                  formBox: true,
                  fillColor: borderColor,
                  vertical: 15,
                  controller: orderDesController,
                  // minLines: 3,
                  // maxLines: 4,
                  headTxt: 'Description',
                  hintText: 'Order Descrtiption (optional)',
                )
              ],
            )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
        child: Btn(
          height: 35,
          width: double.infinity,
          btnName: 'Place Order',
          txtColor: txtWhiteColor,
          color: yellowColor,
          onTap: _saveMethod,
        ),
      ),
    );
  }
}
