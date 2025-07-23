class Portfolio {
  final String name;
  final String designation;
  final String description;
  final String image;
  final List<Skill> skills;
  final List<Project> projects;
  final Contact contact;

  Portfolio({
    required this.name,
    required this.designation,
    required this.skills,
    required this.projects,
    required this.contact,
    required this.description,
    required this.image,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) {
    return Portfolio(
      name: json['name'],
      designation: json['designation'],
      description: json['description'],
      image:json['image'],
      skills: (json['skills'] as List).map((s) => Skill.fromJson(s)).toList(),
      projects: (json['projects'] as List).map((p) => Project.fromJson(p)).toList(),
      contact: Contact.fromJson(json['contact']),
    );
  }
}

class Skill {
  final String title;
  final String image;

  Skill({required this.title, required this.image});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      title: json['title'],
      image: json['image'],
    );
  }
}

class Project {
  final String name;
  final String description;
  final String image;
  final String url;

  Project({required this.name, required this.description, required this.image,required this.url});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'],
      description: json['description'],
      image: json['image'],
      url:json['url'],
    );
  }
}

class Contact {
  final String email;
  final String phone;

  Contact({required this.email, required this.phone});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      email: json['email'],
      phone: json['phone'],
    );
  }
}
