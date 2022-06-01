import 'package:flutter/material.dart';
import '../Elements/button.dart';
import '../Elements/formfield.dart';
import '../Elements/validate.dart';
import '../utils/common.dart';
import '../utils/style.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
        child: Container(
          child: BillingAddress(),
        ),
      ),
    );
  }
}

class BillingAddress extends StatelessWidget {
  BillingAddress({Key? key}) : super(key: key);
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
  final TextEditingController mobileController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _saveMethod() async {
      var isvalid = _formKey.currentState!.validate();

      if (!isvalid) {
        return 'Please Enter Valid Data';
      }
      _formKey.currentState!.save();
      // if (isvalid == true) {
      //   print("condtion is true");
      // navigationPush(
      //     context,
      //     UserNavigationBar(
      //       currentTab: 0,
      //     ));
      // }
    }

    return Stack(
      children: [
        Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
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
                // validator: validateField,
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
                // validator: validateField,
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
                // validator: validateField,
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
                // validator: validateField,
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
                // validator: validateField,
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
                // validator: validateField,
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
                vertical: 15,
                // validator: validateField,
                validator: (v) => validateField(v!),
              ),

              heightSizedBox(10.0),
              EditTextField(
                textAlign: TextAlign.left,
                txtColor: txtBlackColor,
                formBox: true,
                fillColor: borderColor,
                headTxt: 'PIN',
                keyboardType: TextInputType.number,
                controller: pinCodeController,
                vertical: 15,
                // validator: validateField,
                validator: (v) => validateField(v!),
              ),

              // ! Email and Phonen
              heightSizedBox(10.0),
              EditTextField(
                textAlign: TextAlign.left,
                txtColor: txtBlackColor,
                formBox: true,
                fillColor: borderColor,
                headTxt: 'Email',
                // hintText: 'Enter Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                vertical: 15,
                // validator: validateField,
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
                maxLength: 10,
                controller: mobileController,
                keyboardType: TextInputType.phone,
                validator: (v) => validateField(v!),
                vertical: 15,
                // validator: validateField,
              ),
              heightSizedBox(50.0)
            ],
          ),
        ),

        // ! Button
        Positioned(
          left: 50.0,
          bottom: 0.0,
          width: getWidth(context) / 1.3,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: offWhiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Btn(
              onTap: _saveMethod,
              height: 40,
              btnName: ' Save',
              color: redColor,
            ),
          ),
        ),
      ],
    );
  }
}

// ! Address Scrren in CheckoUT SCREEN
class AddressField extends StatelessWidget {
  final TextEditingController? fNameController;
  final TextEditingController? lNameController;

  final TextEditingController? companyController;
  final TextEditingController? countryController;

  final TextEditingController? street1Controller;
  final TextEditingController? street2Controller;

  final TextEditingController? townController;
  final TextEditingController? stateController;
  final TextEditingController? pinCodeController;

  final TextEditingController? emailController;
  final TextEditingController? mobileController;
  final bool? fieldShow;
  final bool? validate;

  const AddressField(
      {Key? key,
      this.validate = true,
      this.fieldShow = true,
      this.companyController,
      this.countryController,
      this.emailController,
      this.fNameController,
      this.lNameController,
      this.mobileController,
      this.pinCodeController,
      this.stateController,
      this.street1Controller,
      this.street2Controller,
      this.townController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
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
        // validator: validateField,
        validator: validate == false ? null : (v) => validateField(v!),
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
        // validator: validateField,
        validator: (v) => validate == false ? null : validateField(v!),
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
        // validator: validateField,
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
        // validator: validateField,
        validator: validate == false ? null : (v) => validateField(v!),
      ),

      heightSizedBox(10.0),
      EditTextField(
        textAlign: TextAlign.left,
        txtColor: txtBlackColor,
        formBox: true,
        fillColor: borderColor,
        hintText: 'Apartment , suite ,etc',
        controller: street2Controller,
        vertical: 15,
        // validator: validateField,
        validator: validate == false ? null : (v) => validateField(v!),
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
        // validator: validateField,
        validator: validate == false ? null : (v) => validateField(v!),
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
        // validator: validateField,
        validator: validate == false ? null : (v) => validateField(v!),
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
        // validator: validateField,
        validator: validate == false ? null : (v) => validateField(v!),
      ),

      // ! Email and Phonen
      Container(
        child: fieldShow == false
            ? null
            : Column(
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
                    // validator: validateField,
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
                    // validator: validateField,
                  ),
                ],
              ),
      )
    ]);
  }
}
