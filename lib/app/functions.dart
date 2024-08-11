
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:formation_app/domain/model.dart';
import 'package:device_info/device_info.dart';

Future<DeviceInfo> getDeviceDetails()async{
  String name = "Unknown";
  String identifier = "Unknown";
  String version = "Unknown";
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      //return android device info

      var  build = await deviceInfoPlugin.androidInfo;
      name = build.brand+" "+build.androidId;
      identifier = build.androidId;
      version = build.version.codename;
    } 
    else if (Platform.isIOS) {
      var build = await deviceInfoPlugin.iosInfo;
      name = build.name+" "+ build.model;
      identifier = build.identifierForVendor;
      version = build.systemVersion;
    }
    
  }
  on PlatformException {
    //return default date here
         return DeviceInfo(name, identifier, version);

  }
  return DeviceInfo(name, identifier, version);
}

