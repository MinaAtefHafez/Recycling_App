
class UserModel {
     String? name;
     String? email ;
     String? password ;
     String? phone ;
     String? governorate ;
     String? neighborhood ;
     String? address ;
     String? type ;
     String? uId ;
     String? profileImage ;

     UserModel ( {
       this.name ,
       this.email ,
       this.password ,
       this.phone ,
       this.governorate,
       this.neighborhood,
       this.address ,
       this.type ,
       this.uId,
       this.profileImage
     } ) ;

     UserModel.fromJson ( Map <String,dynamic> json ) {
       name = json['name'] ;
       email = json['email'] ;
       password = json['password'] ;
       phone = json['phone'] ;
       address = json['address'] ;
       governorate = json['governorate'] ;
       neighborhood = json ['neighborhood'] ;
       type = json['type'] ;
       uId = json['uId'] ;
       profileImage = json ['profileImage'] ; 

     }


     Map <String,dynamic> toMap () {
       return {
         'name' : name ,
         'email' : email ,
          'password' : password ,
          'phone' : phone ,
          'address' : address ,
          'governorate' : governorate ,
          'neighborhood' : neighborhood ,
         'type' : type ,
         'uId' :uId ,
         'profileImage' : profileImage
       };
     }


}