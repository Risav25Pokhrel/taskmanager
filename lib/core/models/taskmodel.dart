class Task {
  late int? createdAt;
  late String title;
  late String description;
  late int onDate;
  late bool? isImportant;
  late String? id;
  late bool? completed;

  Task(
      {this.createdAt,
      required this.title,
      required this.description,
      required this.onDate,
      required this.isImportant,
      required this.completed,
      this.id});

  Task.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    title = json['title'];
    description = json['description'];
    onDate = json['onDate'];
    isImportant = json['isImportant'];
    id = json['id'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['title'] = title;
    data['description'] = description;
    data['onDate'] = onDate;
    data['isImportant'] = isImportant;
    data['id'] = id ?? 2;
    data['completed'] = completed;
    return data;
  }
}
