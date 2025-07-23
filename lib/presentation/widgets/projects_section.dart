import 'package:flutter/material.dart';
import 'package:my_portfolio/data/models/portfolio_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../data/repositories/portfolio_repository.dart';

class ProjectsSectionWidget extends StatelessWidget {
  List<Project>? projects;
  ProjectsSectionWidget({Key? key, required this.projects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 24),
      width: double.infinity,
      child: Column(
        children: [
          const Text(
            'Projects',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            'Some of my Recent Projects',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              // Dynamically set number of columns
              int crossAxisCount = 1;
              int maxLine = 4;
              double width = constraints.maxWidth;
              if (width > 1100) {
                crossAxisCount = 4;
                maxLine = 4;
              } else if (width > 700) {
                crossAxisCount = 3;
                maxLine = 3;
              } else {
                crossAxisCount = 2;
                maxLine = 2;
              }

              return GridView.builder(
                itemCount: projects?.length ?? 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final project = projects![index];
                  return _buildProjectCard(project,maxLine,context);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Project? project,maxLine,context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00FFFF), Color(0xFF5B86E5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                child: Image.asset(
                  project?.image ?? "",
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                color: const Color(0xff262c4d),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(8),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    project?.description ?? "",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: maxLine,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      _launch(project?.url ?? "");
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 6
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Know More',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launch(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }
}
