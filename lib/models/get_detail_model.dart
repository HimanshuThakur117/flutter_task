class Details {


  String fullName = '';
  String label = '';
  String imgUrl = '';

  Details ({

    this.fullName ="",
    this.label = '',
    this.imgUrl ="",
  });

  Details.fromJSON(dynamic json){
    try{
      fullName =  json["userId"]["fullName"]??"";
      label = json["firstLabel"]??"";
      imgUrl = json["firstImage"]??"";

      print("----------------------------------");
      print(fullName.toString());

    }catch(e){
      print(e.toString());
    }
  }



}