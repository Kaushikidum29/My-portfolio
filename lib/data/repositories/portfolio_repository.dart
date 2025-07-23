import '../models/skill_model.dart';
import '../models/project_model.dart';

class PortfolioRepository {
  static List<SkillModel> getSkills() {
    return [
      SkillModel(
        name: 'HTML5',
        icon: 'assets/icons/html5.png',
        description: 'Markup language for web development',
      ),
      SkillModel(
        name: 'CSS3',
        icon: 'assets/icons/css3.png',
        description: 'Styling language for web applications',
      ),
      SkillModel(
        name: 'JavaScript',
        icon: 'assets/icons/javascript.png',
        description: 'Programming language for web development',
      ),
      SkillModel(
        name: 'Bootstrap',
        icon: 'assets/icons/bootstrap.png',
        description: 'Frontend framework for responsive design',
      ),
    ];
  }

  static List<ProjectModel> getProjects() {
    return [
      ProjectModel(
        title: 'Social Media Manager',
        description: 'Built a social media manager template using HTML, CSS and JS',
        image: 'assets/images/project1.png',
        liveUrl: 'https://example.com',
        githubUrl: 'https://github.com/johndoe/project1',
        technologies: ['HTML', 'CSS', 'JavaScript'],
      ),
      ProjectModel(
        title: 'Email Template',
        description: 'Built a unique email template using HTML, CSS and JS',
        image: 'assets/images/project2.png',
        liveUrl: 'https://example.com',
        githubUrl: 'https://github.com/johndoe/project2',
        technologies: ['HTML', 'CSS', 'JavaScript'],
      ),
      ProjectModel(
        title: 'Location Tracking Website',
        description: 'Built a QR Scanner tracking website',
        image: 'assets/images/project3.png',
        liveUrl: 'https://example.com',
        githubUrl: 'https://github.com/johndoe/project3',
        technologies: ['React', 'Node.js', 'MongoDB'],
      ),
    ];
  }
}
