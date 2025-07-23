class ProjectModel {
  final String title;
  final String description;
  final String image;
  final String liveUrl;
  final String githubUrl;
  final List<String> technologies;

  ProjectModel({
    required this.title,
    required this.description,
    required this.image,
    required this.liveUrl,
    required this.githubUrl,
    required this.technologies,
  });
}