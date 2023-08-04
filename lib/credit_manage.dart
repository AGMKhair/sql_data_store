class CreditManage {

 late int id;
 late  String? type;
 late String? category;
 late String? details;
 late double? amount;
 late String? date;
 late String? time;
 late String? createdAt;


  CreditManage({this.type, this.category, this.details, this.amount, this.date, this.time});


  CreditManage.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        type = result["type"],
        category = result["category"],
        details = result["details"],
        amount = result["amount"],
        date = result["date"],
        time = result["time"],
        createdAt = result["createdAt"];

  Map<String, Object> toMap() {
    return {'id': id, 'type': type!, 'category': category!, 'details': details!, 'amount': amount!, 'date': date!, 'time': amount!, 'createdAt': createdAt!};
  }

}
