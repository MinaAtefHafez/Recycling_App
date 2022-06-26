

class MessageModel {
  
     String? text ;
     String? senderId;
     String?  dateTime  ;

    MessageModel({
      required this.text ,
      required this.senderId ,
      required this.dateTime
    });  

    MessageModel.fromJson ( Map <String,dynamic> json ) {
      text = json['text'] ;
      senderId = json['senderId'] ;
      dateTime = json['dateTime'] ;

    }

    Map <String,dynamic> toMap () {
      return {
           'text' : text ,
           'senderId' : senderId ,
           'dateTime' : dateTime
      } ;
    }
  

}