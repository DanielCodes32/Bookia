// {
//     "governorate_id":4,
//     "name" : "Daniel",
//     "phone" : "01117282877",
//     "address":"cairo",
//     "email" : "Daniel22@gmail.com"
// }
class PlaceOrderModel {
  PlaceOrderModel({
    required this.governorateId,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
  });
  final int governorateId;
  final String name;
  final String phone;
  final String address;
  final String email;

  Map<String, dynamic> toJson() {
    return {
      'governorate_id': governorateId,
      'name': name,
      'phone': phone,
      'address': address,
      'email': email,
    };
  }
}
