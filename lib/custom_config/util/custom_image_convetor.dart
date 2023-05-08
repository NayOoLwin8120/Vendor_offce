import 'dart:convert';
import 'dart:typed_data';

String unit8ToBase64(Uint8List unit8list,String  dataType){
  String Base64String=base64Encode(unit8list);
  // print(Base64String);
  String header= "data:$dataType;base64";
  // print(header);
  return header+Base64String;
}