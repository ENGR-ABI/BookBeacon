import '../../utils/utills.dart';

class Country {
  String name;
  String code;
  String dialCode;
  String flag;
  Country({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flag,
  });

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      name: map['country_name'],
      code: map['country_short_name'],
      dialCode: '+${map['country_phone_code']}',
      flag: Utils.countryCodeToEmoji(map['country_short_name']),
    );
  }
}
