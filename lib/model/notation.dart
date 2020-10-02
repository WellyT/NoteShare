class NotationItem {
  String id;
  String anotation;

  NotationItem({
    this.id,
    this.anotation,
  });

  NotationItem.fromJson(Map<String, dynamic> json){
    id = json['id'];
    anotation = json['anotation'];
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['anotation'] = this.anotation;
    return data;
  }
/*  @override
  String toString() {
    return 'Notation{notation: $notation}';
  }*/
}
