import 'package:geocode/geocode.dart';

class AddressCalculator{
  double latitude,longitude;
  AddressCalculator(this.latitude,this.longitude);
  Future<String> getLocation() async {
    var addresses =
        await GeoCode().reverseGeocoding(latitude: latitude, longitude: longitude) ;
    var first = addresses.streetAddress! + " " + addresses.city!;
    return first.toString();
    //print("${first.featureName} : ${first.addressLine} :${first.adminArea}");
  }
}