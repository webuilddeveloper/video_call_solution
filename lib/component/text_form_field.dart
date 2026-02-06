import 'package:flutter/material.dart';

labelTextFormField(String label, {bool mandatory = false}) {
  String title = mandatory ? '* ' : '';
  return Padding(
    padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
    child: RichText(
      text: TextSpan(
        text: title,
        style: TextStyle(fontFamily: 'Kanit', color: Colors.red),
        children: <TextSpan>[
          TextSpan(
            text: label,
            style: TextStyle(fontFamily: 'Kanit', color: Colors.black),
          ),
        ],
      ),
    ),
  );
}

textFormField(
  TextEditingController model,
  String? modelMatch,
  String hintText,
  String validator,
  bool enabled,
  bool isPassword,
  bool isEmail,
) {
  return TextFormField(
    obscureText: isPassword,
    style: TextStyle(
      color: enabled ? Color(0xFFA9151D) : Color(0xFFFFFFFF),
      // fontWeight: FontWeight.normal,
      fontFamily: 'Kanit',
      // fontSize: 15.00,
    ),
    decoration: InputDecoration(
      filled: true,
      fillColor: enabled ? Color(0xFFEEBA33) : Color(0xFF707070),
      contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      // hintText: hintText,
      // focusedBorder: UnderlineInputBorder(
      //   borderSide: BorderSide(color: Colors.amber, width: 0.5),
      // ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      errorStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: 'Kanit',
        fontSize: 10.0,
      ),
    ),
    validator: (model) {
      model = model ?? "";
      if (model.isEmpty) {
        return 'กรุณากรอก${validator}.';
      }
      if (isPassword && model != modelMatch) {
        return 'กรุณากรอกรหัสผ่านให้ตรงกัน.';
      }

      if (isPassword) {
        String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{6,}$';
        RegExp regex = RegExp(pattern);
        if (!regex.hasMatch(model)) {
          return 'กรุณากรอกรูปแบบรหัสผ่านให้ถูกต้อง.';
        }
      }
      if (isEmail) {
        String pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = RegExp(pattern);
        if (!regex.hasMatch(model)) {
          return 'กรุณากรอกรูปแบบอีเมลให้ถูกต้อง.';
        }
      }
      return null;
    },
    controller: model,
    enabled: enabled,
  );
}

textFormPhoneField(
  TextEditingController model,
  String hintText,
  String validator,
  bool enabled,
  bool isPhone,
) {
  return TextFormField(
    keyboardType: TextInputType.number,
    style: TextStyle(
      color: enabled ? Color(0xFFA9151D) : Color(0xFFFFFFFF),
      fontWeight: FontWeight.normal,
      fontFamily: 'Kanit',
      fontSize: 15.00,
    ),
    decoration: InputDecoration(
      filled: true,
      fillColor: enabled ? Color(0xFFEEBA33) : Color(0xFF707070),
      contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      // hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      errorStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: 'Kanit',
        fontSize: 10.0,
      ),
    ),
    validator: (model) {
      model = model ?? "";
      if (model.isEmpty) {
        return 'กรุณากรอก${validator}.';
      }
      if (isPhone) {
        String pattern = r'(^(?:[+0]9)?[0-9]{9,10}$)';
        RegExp regex = RegExp(pattern);
        if (!regex.hasMatch(model)) {
          return 'กรุณากรอกรูปแบบเบอร์ติดต่อให้ถูกต้อง.';
        }
      }
      return null;
    },
    controller: model,
    enabled: enabled,
  );
}

labelTextFormFieldPasswordOldNew(
  String label,
  bool showSubtitle, {
  bool mandatory = false,
}) {
  String title = mandatory ? '* ' : '';
  return Padding(
    padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
    child: Row(
      children: <Widget>[
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  text: title,
                  style: TextStyle(fontFamily: 'Kanit', color: Colors.red),
                  children: <TextSpan>[
                    TextSpan(
                      text: label,
                      style: TextStyle(
                        fontFamily: 'Kanit',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              if (showSubtitle)
                Text(
                  '(รหัสผ่านต้องเป็นตัวอักษร a-z, A-Z และ 0-9 ความยาวขั้นต่ำ 6 ตัวอักษร)',
                  style: TextStyle(
                    fontSize: 10.00,
                    fontFamily: 'Kanit',
                    // color: Color(0xFFFF0000),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

labelTextField(String label, Icon icon) {
  return Row(
    children: <Widget>[
      icon,
      Text(
        ' ${label}',
        style: TextStyle(fontSize: 15.000, fontFamily: 'Kanit'),
      ),
    ],
  );
}

textField(
  TextEditingController model,
  TextEditingController? modelMatch,
  String hintText,
  String validator,
  bool enabled,
  bool isPassword,
) {
  return SizedBox(
    height: 45.0,
    child: TextField(
      // keyboardType: TextInputType.number,
      obscureText: isPassword,
      controller: model,
      enabled: enabled,
      style: TextStyle(
        color: Color(0xFF6F0100),
        fontWeight: FontWeight.normal,
        fontFamily: 'Kanit',
        fontSize: 15.00,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFEEBA33),
        contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}

textFormFieldNoValidator(
  TextEditingController model,
  String hintText,
  bool enabled,
  bool isEmail,
) {
  return TextFormField(
    style: TextStyle(
      color: enabled ? Color(0xFFA9151D) : Color(0xFFFFFFFF),
      fontWeight: FontWeight.normal,
      fontFamily: 'Kanit',
      fontSize: 15.00,
    ),
    decoration: InputDecoration(
      filled: true,
      fillColor: enabled ? Color(0xFFEEBA33) : Color(0xFF707070),
      contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      // hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      errorStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: 'Kanit',
        fontSize: 10.0,
      ),
    ),

    validator: (model) {
      model = model ?? "";
      if (isEmail && model != "") {
        String pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(model)) {
          return 'กรุณากรอกรูปแบบอีเมลให้ถูกต้อง.';
        }
      }
      return null;
    },
    controller: model,
    // enabled: enabled,
  );
}

textFormIdCardField(
  TextEditingController model,
  String hintText,
  String validator,
  bool enabled,
  bool fix,
) {
  return TextFormField(
    keyboardType: TextInputType.number,
    style: TextStyle(
      color: enabled ? Color(0xFFA9151D) : Color(0xFFFFFFFF),
      fontWeight: FontWeight.normal,
      fontFamily: 'Kanit',
      fontSize: 15.00,
    ),
    decoration: InputDecoration(
      filled: true,
      fillColor: enabled ? Color(0xFFEEBA33) : Color(0xFF707070),
      contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      // hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      errorStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: 'Kanit',
        fontSize: 10.0,
      ),
    ),
    validator: (model) {
      model = model ?? "";
      if (fix) {
        if (model.isEmpty) {
          return 'กรุณากรอก${validator}.';
        }

        String pattern = r'(^[0-9]\d{12}$)';
        RegExp regex = new RegExp(pattern);

        if (regex.hasMatch(model)) {
          if (model.length != 13) {
            return 'กรุณากรอกรูปแบบเลขบัตรประชาชนให้ถูกต้อง';
          } else {
            var sum = 0.0;
            for (var i = 0; i < 12; i++) {
              sum += double.parse(model[i]) * (13 - i);
            }
            if ((11 - (sum % 11)) % 10 != double.parse(model[12])) {
              return 'กรุณากรอกเลขบัตรประชาชนให้ถูกต้อง';
            } else {
              return null;
            }
          }
        } else {
          return 'กรุณากรอกรูปแบบเลขบัตรประชาชนให้ถูกต้อง';
        }
      }

      return null;
    },
    controller: model,
    enabled: enabled,
  );
}

Container textHeader(
  BuildContext context, {
  String title = '',
  double fontSize = 15.0,
  FontWeight fontWeight = FontWeight.w500,
  Color color = Colors.black,
}) {
  return Container(
    child: Text(
      title,
      style: TextStyle(
        fontFamily: 'Kanit',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    ),
  );
}

Container textRow(
  BuildContext context, {
  String title = '',
  String value = '',
}) {
  return Container(
    padding: EdgeInsets.only(top: 5.0),
    child: Row(
      children: [
        Container(
          width: 145.0,
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 2,
          ),
        ),
        Expanded(
          child: Container(
            child: Text(
              value != '' ? value : '-',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
              maxLines: 2,
            ),
          ),
        ),
      ],
    ),
  );
}
