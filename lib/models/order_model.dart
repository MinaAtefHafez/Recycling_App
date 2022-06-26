class OrderModel {
  String? name;
  String? plastic;
  String? steel;
  String? paper;
  String? address;
  String? phone ;
  String? dateTime;
  String? day;
  String? dateSeconds ; 
  String? governorate ;
  String? neighborhood ;

  OrderModel({
    required this.name,
    required this.plastic,
    required this.steel,
    required this.paper,
    required this.address,
    required this.day,
    required this.dateTime,
    required this.phone ,
    required this.dateSeconds ,
    required this.governorate ,
    required this.neighborhood ,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    plastic = json['plastic'];
    steel = json['steel'];
    paper = json['paper'];
    address = json['address'];
    phone = json ['phone'] ;
    dateTime = json['dateTime'];
    day = json ['day'] ;
    dateSeconds = json ['dateSeconds'] ;
    governorate = json ['governorate'] ;
    neighborhood = json ['neighborhood'] ;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'plastic': plastic,
      'steel': steel,
      'paper': paper,
      'address': address,
      'phone' : phone ,
      'dateTime': dateTime,
      'day': day ,
      'dateSeconds' : dateSeconds ,
      'neighborhood' : neighborhood ,
      'governorate' : governorate
    };
  }
}
