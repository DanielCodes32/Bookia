import 'dart:io';

import 'package:dio/dio.dart';


class EditProfileParams {
 final String? name;
final  String? phone;
 final String? address;
final File? image;
  EditProfileParams({ this.name, this.phone, this.address,  this.image});

  Map<String, dynamic> tojson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
    };
  }
  FormData toFormData() {
    return FormData.fromMap(
      {
        if (name != null) 'name': name,
        if (phone != null) 'phone': phone,
        if (address != null) 'address': address,
        if (image != null)
          'image': MultipartFile.fromFileSync(
            image!.path,
            filename: image!.path.split(Platform.pathSeparator).last,
          ),
      },
    );
  }

}