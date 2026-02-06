// ignore_for_file: unused_local_variable, avoid_print, duplicate_ignore

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:io';


// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

// flutter build apk --build-name=4.0.0 --build-number=24
// flutter build appbundle --build-name=4.0.0 --build-number=24

const versionName = '4.1.8';
const versionNumber = 418;

// const server = 'http://122.155.223.63/td-lc-api/';
// const server = 'http://localhost:5600/';
const server = 'https://lc.we-builds.com/lc-api/';
const serverUpload = 'https://lc.we-builds.com/lc-document/upload';
const serverLineNoti = 'https://notify-api.line.me/api/notify';
const serverOTP = 'https://portal-otp.smsmkt.com/api/';
const serverElectionLc = 'http://122.155.223.63/td-election-lc-api/';
// const serverElectionLc = 'http://lawyerselection2565.com/election-api/';

const newsElectionLcApi = '${serverElectionLc}m/news/read';
const newsGalleryElectionLcApi = '${serverElectionLc}m/news/gallery/read';
const employeeElectionLcApi = '${serverElectionLc}m/employee/read';
const employeeDetailElectionLcApi = '${serverElectionLc}m/employee/detail/read';

const sharedApi = '${server}configulation/shared/';
const registerApi = '${server}m/register/';
const newsApi = '${server}m/news/';
const newsGalleryApi = '${server}m/news/gallery/read';
const applyExamApi = '${server}m/applyExam/';
const applyExamGalleryApi = '${server}m/applyExam/gallery/read';
const pollApi = '${server}m/poll/';
const poiApi = '${server}m/poi/';
const poiGalleryApi = '${server}m/poi/gallery/read';
const faqApi = '${server}m/faq/';
const knowledgeApi = '${server}m/knowledge/';
const cooperativeApi = '${server}m/cooperativeForm/';
const contactApi = '${server}m/contact/';
const bannerApi = '${server}banner/';
const bannerGalleryApi = '${server}m/banner/gallery/read';
const privilegeApi = "${server}m/privilege/";
const privilegeGalleryApi = '${server}m/privilege/gallery/read';
const privilegeSpecialReadApi =
    'http://122.155.223.63/td-we-mart-api/m/privilege/lc/read';
const privilegeSpecialCategoryReadApi =
    'http://122.155.223.63/td-we-mart-api/m/privilege/category/read';
const aboutUsApi = "${server}m/aboutus/";
const notificationApi = '${server}m/v2/notification/';
const welfareApi = '${server}m/welfare/';
const welfareGalleryApi = '${server}m/welfare/gallery/read';
const eventCalendarApi = '${server}m/eventCalendar/';
const eventCalendarCategoryApi = '${server}m/eventCalendar/category/';
const eventCalendarCommentApi = '${server}m/eventCalendar/comment/';
const eventCalendarGalleryApi = '${server}m/eventCalendar/gallery/read';
const trainingApi = '${server}m/training/';
const trainingCategoryApi = '${server}m/training/category/';
const trainingCommentApi = '${server}m/training/comment/';
const trainingGalleryApi = '${server}m/training/gallery/read';
const pollGalleryApi = '${server}m/poll/gallery/read';
const reporterApi = '${server}m/reporter/';
const reporterGalleryApi = '${server}m/Reporter/gallery/';
const fundApi = '${server}m/fund/';
// const menuApi = server + "m/menu/";
const menuApi = "${server}m/v2/menu/";
const comingSoonApi = '${server}m/comingsoon/read';
const comingSoonGalleryApi = '${server}m/comingsoon/gallery/read';

const fundGalleryApi = '${server}m/fund/gallery/read';
const questionApi = '${server}m/question/';
const answerApi = '${server}m/answer/';

//banner
const mainBannerApi = '${server}m/Banner/main/';
const contactBannerApi = '${server}m/Banner/contact/';
const reporterBannerApi = '${server}m/Banner/reporter/';

const teacherApi = '${server}m/teacher/';
const teacherCategoryApi = '${server}m/fund/category/';
const teacherCommentApi = '${server}m/fund/comment/';
const teacherGalleryApi = '${server}m/fund/gallery/read';

const lawyerApi = '${server}lawyer/';

const schoolApi = '${server}m/school/';
const schoolCategoryApi = '${server}m/fund/category/';
const schoolCommentApi = '${server}m/fund/comment/';
const schoolGalleryApi = '${server}m/fund/gallery/read';

//rotation
const rotationApi = '${server}rotation/';
const mainRotationApi = '${server}m/Rotation/main/';
const rotationGalleryApi = '${server}m/rotation/gallery/read';
const rotationWarningApi = '${server}m/rotation/warning/read';
const rotationWelfareApi = '${server}m/rotation/welfare/read';
const rotationNewsApi = '${server}m/rotation/news/read';
const rotationApplyExamApi = '${server}m/rotation/applyExam/read';
const rotationPoiApi = '${server}m/rotation/poi/read';
const rotationPrivilegeApi = '${server}m/rotation/privilege/read';
const rotationNotificationApi = '${server}m/rotation/notification/read';
const rotationEvantCalendarApi = '${server}m/rotation/event/read';
const rotationReporterApi = '${server}m/rotation/reporter/read';

//mainPopup
const mainPopupHomeApi = '${server}m/MainPopup/';
const forceAdsApi = '${server}m/ForceAds/';

// comment
const newsCommentApi = '${server}m/news/comment/';
const applyExamCommentApi = '${server}m/applyExam/comment/';
const welfareCommentApi = '${server}m/welfare/comment/';
const poiCommentApi = '${server}m/poi/comment/';
const fundCommentApi = '${server}m/fund/comment/';

//category
const knowledgeCategoryApi = '${server}m/knowledge/category/';
const cooperativeCategoryApi = '${server}m/cooperativeForm/category/';
const newsCategoryApi = '${server}m/news/category/';
const applyExamCategoryApi = '${server}m/applyExam/category/';
const privilegeCategoryApi = '${server}m/privilege/category/';
const contactCategoryApi = '${server}m/contact/category/';
const welfareCategoryApi = '${server}m/welfare/category/';
const fundCategoryApi = '${server}m/fund/category/';
const pollCategoryApi = '${server}m/poll/category/';
const poiCategoryApi = '${server}m/poi/category/';
const reporterCategoryApi = '${server}m/reporter/category/';

const splashApi = '${server}m/splash/read';
const versionReadApi = '${server}m/v2/version/read';
const reporterT02ReadApi = '${server}m/v2/ReporterT02/read';
const reporterInformationReadApi = '${server}m/v2/ReporterInformation/read';

const reporterT01ReadApi = '${server}m/v2/ReporterT01/read';
const reporterRegisterReadApi = '${server}m/v2/ReporterRegister/read';
const reporter03ReadApi = '${server}reporter/tr03/read';
const reporter04ReadApi = '${server}reporter/tr04/read';
const registerSignReadApi = '${server}m/v2/registerSign/read';
const reporterCertifyReadApi = '${server}m/v2/ReporterCertify/read';

const trackingReadApi = '${server}m/v2/ReporterT01/tracking/read';
const tracking2ReadApi = '${server}m/v2/ReporterT02/tracking/read';
const tracking3ReadApi = '${server}reporter/tr03/tracking/read';
const tracking4ReadApi = '${server}reporter/tr04/tracking/read';

const reporterMemberConfigReadApi = '${server}configulation/read';

Future<dynamic> postCategory(String url, dynamic criteria) async {
  var body = json.encode({
    "permission": "all",
    "skip": criteria['skip'] ?? 0,
    "limit": criteria['limit'] ?? 1,
    "code": criteria['code'] ?? '',
    "reference": criteria['reference'] ?? '',
    "description":
        criteria['description'] ?? '',
    "category": criteria['category'] ?? '',
    "keySearch": criteria['keySearch'] ?? '',
    "username": criteria['username'] ?? '',
    "isHighlight":
        criteria['isHighlight'] ?? false,
    "isCategory":
        criteria['isCategory'] ?? false,
  });

  var response = await http.post(Uri.parse(url), body: body, headers: {
    "Accept": "application/json",
    "Content-Type": "application/json"
  });

  var data = json.decode(response.body);

  List<dynamic> list = [
    {'code': "", 'title': 'ทั้งหมด'}
  ];
  list = [...list, ...data['objectData']];

  return Future.value(list);
}

Future<dynamic> post(String url, dynamic criteria) async {
  // print(url);
  // print(criteria);
  var body = json.encode({
    "permission": "all",
    "skip": criteria['skip'] ?? 0,
    "limit": criteria['limit'] ?? 1,
    "code": criteria['code'] ?? '',
    "reference": criteria['reference'] ?? '',
    "description":
        criteria['description'] ?? '',
    "category": criteria['category'] ?? '',
    "keySearch": criteria['keySearch'] ?? '',
    "username": criteria['username'] ?? '',
    "password": criteria['password'] ?? '',
    "email": criteria['email'] ?? '',
    "firstName": criteria['firstName'] ?? '',
    "lastName": criteria['lastName'] ?? '',
    "title": criteria['title'] ?? '',
    "answer": criteria['answer'] ?? '',
    "isHighlight":
        criteria['isHighlight'] ?? false,
    "createBy": criteria['createBy'] ?? '',
    "isPublic": criteria['isPublic'] ?? false,
    "imageList": criteria['imageList'] ?? [],
    "profileCode":
        criteria['profileCode'] ?? '',
    "isCategory":
        criteria['isCategory'] ?? false,
    "idcard": criteria['idcard'] ?? false,
  });

  var response = await http.post(Uri.parse(url), body: body, headers: {
    "Accept": "application/json",
    "Content-Type": "application/json"
  });

  var data = json.decode(response.body);
  return Future.value(data['objectData']);
}

Future<dynamic> postAny(String url, dynamic criteria) async {
  var body = json.encode({
    "permission": "all",
    "skip": criteria['skip'] ?? 0,
    "limit": criteria['limit'] ?? 1,
    "code": criteria['code'] ?? '',
    "category": criteria['category'] ?? '',
    "username": criteria['username'] ?? '',
    "password": criteria['password'] ?? '',
    "createBy": criteria['createBy'] ?? '',
    "imageUrlCreateBy": criteria['imageUrlCreateBy'] ?? '',
    "reference": criteria['reference'] ?? '',
    "description":
        criteria['description'] ?? '',
  });

  var response = await http.post(Uri.parse(url), body: body, headers: {
    "Accept": "application/json",
    "Content-Type": "application/json"
  });

  var data = json.decode(response.body);

  return Future.value(data['status']);
}

Future<dynamic> postAnyObj(String url, dynamic criteria) async {
  var body = json.encode({
    "permission": "all",
    "skip": criteria['skip'] ?? 0,
    "limit": criteria['limit'] ?? 1,
    "code": criteria['code'] ?? '',
    "createBy": criteria['createBy'] ?? '',
    "imageUrlCreateBy": criteria['imageUrlCreateBy'] ?? '',
    "reference": criteria['reference'] ?? '',
    "description":
        criteria['description'] ?? '',
  });

  var response = await http.post(Uri.parse(url), body: body, headers: {
    "Accept": "application/json",
    "Content-Type": "application/json"
  });

  var data = json.decode(response.body);

  return Future.value(data);
}

Future<dynamic> postLogin(String url, dynamic criteria) async {
  var body = json.encode({
    "category": criteria['category'] ?? '',
    "password": criteria['password'] ?? '',
    "username": criteria['username'] ?? '',
    "email": criteria['email'] ?? '',
  });

  var response = await http.post(Uri.parse(url), body: body, headers: {
    "Accept": "application/json",
    "Content-Type": "application/json"
  });

  var data = json.decode(response.body);

  return Future.value(data['objectData']);
}

Future<dynamic> postObjectData(String url, dynamic criteria) async {
  var body = json.encode(criteria);

  var response = await http.post(Uri.parse(server + url), body: body, headers: {
    "Accept": "application/json",
    "Content-Type": "application/json"
  });
  // ignore: avoid_print
  print('_+_+_+_+__+ ${response.statusCode}');

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return {
      "status": data['status'],
      "message": data['message'],
      "objectData": data['objectData']
    };
    // Future.value(data['objectData']);
  } else {
    return {"status": "F"};
  }
}

Future<dynamic> postConfigShare() async {
  var body = json.encode({});

  var response = await http.post(
      Uri.parse('${server}configulation/shared/read'),
      body: body,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      });

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return {
      // Future.value(data['objectData']);
      "status": data['status'],
      "message": data['message'],
      "objectData": data['objectData']
    };
  } else {
    return {"status": "F"};
  }
}

Future<File> convertimageTofile(imgUrl) async {
  var response = await http.get(imgUrl);
  Directory documentDirectory = await getApplicationDocumentsDirectory();
  File file = File(join(documentDirectory.path, 'imagetest.png'));
  file.writeAsBytesSync(response.bodyBytes);
  return file;
}

//upload with dio
Future<String> uploadImage(File file) async {
  Dio dio = Dio();
  String fileName = file.path.split('/').last;
  FormData formData = FormData.fromMap({
    "ImageCaption": "flutter",
    "Image": await MultipartFile.fromFile(file.path, filename: fileName),
  });

  var response = await dio.post(serverUpload, data: formData);

  return response.data['imageUrl'];
}

Future<String> uploadImageX(XFile file) async {
  Dio dio = Dio();
  String fileName = file.path.split('/').last;
  FormData formData = FormData.fromMap({
    "ImageCaption": "flutter",
    "Image": await MultipartFile.fromFile(file.path, filename: fileName),
  });

  var response = await dio.post(serverUpload, data: formData);

  return response.data['imageUrl'];
}

//upload with http
upload(File file) async {
  var uri = Uri.parse(serverUpload);
  var request = http.MultipartRequest('POST', uri)
    ..fields['ImageCaption'] = 'flutter2'
    ..files.add(await http.MultipartFile.fromPath('Image', file.path,
        contentType: MediaType('application', 'x-tar')));
  var response = await request.send();
  if (response.statusCode == 200) {
    return response;
  }
}

createStorageApp({dynamic model, String? category}) {
  const storage = FlutterSecureStorage();

  storage.write(key: 'profileCategory', value: category);

  storage.write(
    key: 'profileCode18',
    value: model['code'],
  );

  storage.write(
    key: 'profileImageUrl',
    value: model['imageUrl'],
  );

  storage.write(
    key: 'profileFirstName',
    value: model['firstName'],
  );

  storage.write(
    key: 'profileLastName',
    value: model['lastName'],
  );

  storage.write(
    key: 'profileLastName',
    value: model['lastName'],
  );

  storage.write(
    key: 'dataUserLoginLC',
    value: jsonEncode(model),
  );
}

Future<dynamic> postDio(String url, dynamic criteria) async {
  const storage = FlutterSecureStorage();
  final profileCode = await storage.read(key: 'profileCode18');
  if (profileCode != '' && profileCode != null) {
    criteria = {'profileCode': profileCode, ...criteria};
  }
  Dio dio = Dio();
  try {
    var response = await dio.post(url, data: criteria);
    // print(response.data['objectData'].toString());
    // if (response.statusCode == 200) {
    //   response.data['objectData']['status2'] = 'S';
    // }
    return Future.value(response.data['objectData']);
  // ignore: unused_catch_clause
  } on DioError catch (e) {
    return null;
    // throw Exception();
  }
}

Future<dynamic> postDioCategory(String url, dynamic criteria) async {
  // ignore: avoid_print
  print(url);
  print(criteria);
  const storage = FlutterSecureStorage();
  var platform = Platform.operatingSystem.toString();
  final profileCode = await storage.read(key: 'profileCode18');

  if (profileCode != '' && profileCode != null) {
    criteria = {'profileCode': profileCode, ...criteria};
  }

  Dio dio = Dio();
  var response = await dio.post(url, data: criteria);

  List<dynamic> list = [
    {'code': "", 'title': 'ทั้งหมด'}
  ];
  list = [...list, ...response.data['objectData']];

  return Future.value(list);
}

Future<dynamic> postDioMessage(String url, dynamic criteria) async {
  const storage = FlutterSecureStorage();
  final profileCode = await storage.read(key: 'profileCode18');
  if (profileCode != '' && profileCode != null) {
    criteria = {'profileCode': profileCode, ...criteria};
  }
  Dio dio = Dio();
  // print('-----dio criteria-----' + criteria.toString());
  var response = await dio.post(url, data: criteria);
  // print('-----dio message-----' + response.data['objectData'].toString());
  return Future.value(response.data['objectData']);
}

// logout(BuildContext context) async {
//   const storage = FlutterSecureStorage();
//   var profileCategory = await storage.read(key: 'profileCategory');
//   if (profileCategory != '' && profileCategory != null) {
//     switch (profileCategory) {
//       case 'facebook':
//         // logoutFacebook();
//         break;
//       case 'google':
//         logoutGoogle();
//         break;
//       case 'line':
//         logoutLine();
//         break;
//       default:
//     }
//   }
//   storage.deleteAll();
// }

Future<dynamic> postLineNoti() async {
  Dio dio = Dio();
  dio.options.contentType = Headers.formUrlEncodedContentType;
  dio.options.headers["Authorization"] =
      "Bearer " "1RwnPOBFU0sN0LNBNWxkNpSOmpNjjKeVaFzwmg1c5zl";
  var formData = FormData.fromMap({'message': "LC ระบบขัดข้อง"});
  var response = await dio.post(serverLineNoti, data: formData);
  return Future.value(response.data['message']);
}

Future<dynamic> postDioCategoryWeMart(String url, dynamic criteria) async {
  // print(url);
  // print(criteria);
  const storage = FlutterSecureStorage();
  // var platform = Platform.operatingSystem.toString();
  final profileCode = await storage.read(key: 'profileCode18');

  if (profileCode != '' && profileCode != null) {
    criteria = {'profileCode': profileCode, ...criteria};
  }

  Dio dio = Dio();
  var response = await dio.post(url, data: criteria);
  var data = response.data['objectData'];

  List<dynamic> list = [
    {'code': "", 'title': 'ทั้งหมด'}
  ];

  list = [...data, ...list];
  return Future.value(list);
}

Future<dynamic> postDioCategoryWeMartNoAll(String url, dynamic criteria) async {
  // print(url);
  // print(criteria);
  const storage = FlutterSecureStorage();
  // var platform = Platform.operatingSystem.toString();
  final profileCode = await storage.read(key: 'profileCode18');

  if (profileCode != '' && profileCode != null) {
    criteria = {'profileCode': profileCode, ...criteria};
  }

  Dio dio = Dio();
  var response = await dio.post(url, data: criteria);
  var data = response.data['objectData'];

  List<dynamic> list = [
    // {'code': "", 'title': 'ทั้งหมด'}
  ];

  list = [...data];
  return Future.value(list);
}

Future<dynamic> postOTPSend(String url, dynamic criteria) async {
  //https://portal-otp.smsmkt.com/api/otp-send
  //https://portal-otp.smsmkt.com/api/otp-validate
  Dio dio = Dio();
  dio.options.contentType = Headers.formUrlEncodedContentType;
  dio.options.headers["api_key"] = "db88c29e14b65c9db353c9385f6e5f28";
  dio.options.headers["secret_key"] = "XpM2EfFk7DKcyJzt";
  var response = await dio.post(serverOTP + url, data: criteria);
  // print('----------- -----------  ${response.data['result']}');
  return Future.value(response.data['result']);
}

Future<void> postTrackClick(String button) async {
  const storage = FlutterSecureStorage();
  var value = await storage.read(key: 'dataUserLoginLC');
  var data = json.decode(value!);

  dynamic criteria = {
    'button': button,
    'username': data['username'] != '' ? data['username'] ?? '' : '',
    'firstname': data['firstname'] != '' ? data['firstname'] ?? '' : '',
    'lastname': data['lastname'] != '' ? data['lastname'] ?? '' : '',
    'profileCode': data['code'] != '' ? data['code'] ?? '' : '',
    'createBy': data['username'] != '' ? data['username'] ?? '' : '',
  };
// print('-----dio uri-----' + server + "trackClick/create");
// print('-----dio criteria-----' + criteria.toString());
  Dio dio = Dio();
  dio.post("${server}trackClick/create", data: criteria);
}

const splashReadApi = '${server}m/splash/read';
const profileReadApi = '${server}m/v2/register/read';
const organizationImageReadApi = '${server}m/v2/organization/image/read';
