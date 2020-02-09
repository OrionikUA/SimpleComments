class Comment {
  int id;
  String name;
  DateTime dateTime;
  DateTime updateTime;
  String comment;
  bool isLike;
  List<Comment> innerComments;
  int parentId;

  Comment.createNew({this.parentId}) {
    name = '';
    comment = '';
  }

  Comment(this.id, this.name, this.dateTime, this.comment, this.isLike, {DateTime updateTime, this.innerComments, this.parentId}) {
    if (innerComments == null) {
      innerComments = [];
    }
  }

  Comment.create(this.name, this.comment, this.isLike, {this.parentId});

  Comment clone() {
    return new Comment(id, name, dateTime, comment, isLike, updateTime: updateTime, innerComments: innerComments, parentId: parentId);
  }

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['user'];
    dateTime = DateTime.parse(json['createDate']);
    comment = json['message'];
    isLike = json['isLike'];
    var jsonUpdateTime = json['updateDate'];
    parentId = json['parentId'];
    var jsonInnerComment = json['innerComment'];

    if (jsonUpdateTime != null) {
      updateTime = DateTime.parse(jsonUpdateTime);      
    }
    innerComments = [];
    if (jsonInnerComment != null) {
      for (Map<String, dynamic> obj in jsonInnerComment) {
        innerComments.add(Comment.fromJson(obj));
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'user': name,
      'createDate': null,
      'updateDate': null,
      'message': comment,
      'isLike': isLike,
      'innerComment': null,
      'parentId': parentId,
    };
  }

  void update(Comment newComment) {
    name = newComment.name;
    comment = newComment.comment;
    isLike = newComment.isLike;
    updateTime = newComment.updateTime;
  }
}