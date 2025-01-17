// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:ht_sales/constants/rest_api_urls.dart';
// class GetUrlClass{
//   Future<void> check() async {
//     await Firebase.initializeApp();
//     DocumentReference documentReference=FirebaseFirestore.instance.collection('MyBaseUrl').doc('Omar Store');
//     Map<String,dynamic> data={};
//     documentReference.get().then((value) {
//       // if(value.get('baseUrl')!=null){
//       //   var newString = value.get('baseUrl').substring(value.get('baseUrl').length - 1);
//       //   print('newString>>'+newString.toString());
//       // }
//       // Constants.ENDPOINT_23=value.get('baseUrl');
//       RestApiUrls.baseUrl=value.get('baseUrl')+"/api/";
//       print("valueFir>>"+RestApiUrls.baseUrl);
//     });
//   }
// }