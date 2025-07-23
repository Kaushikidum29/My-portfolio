import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/data/controllers/portfolio_controller.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer.dart';
import '../widgets/header.dart';
import '../widgets/hero_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/skills_section.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  late List<_Section> _sections;
  String _activeSection = 'home';

  final PortfolioController portfolioController = Get.find();

  @override
  void initState() {
    super.initState();
    _sections = [
      _Section('home', _homeKey),
      _Section('skills', _skillsKey),
      _Section('projects', _projectsKey),
      _Section('contact', _contactKey),
    ];
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    double offset = _scrollController.offset;

    for (int i = _sections.length - 1; i >= 0; i--) {
      final sectionOffset = _getOffsetForKey(_sections[i].key);
      if (offset >= sectionOffset - 100) {
        final newActive = _sections[i].name;
        if (_activeSection != newActive) {
          setState(() {
            _activeSection = newActive;
          });
        }
        break;
      }
    }
  }

  double _getOffsetForKey(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return double.infinity;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return double.infinity;
    return box.localToGlobal(Offset.zero).dy - (kToolbarHeight + 20);
  }

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Obx(() {
        final portfolio = portfolioController.portfolio.value;

        if (portfolio == null) {
          // Show loading indicator while JSON loads
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            HeaderWidget(
              onSectionSelected: scrollToSection,
              homeKey: _homeKey,
              skillsKey: _skillsKey,
              projectsKey: _projectsKey,
              contactKey: _contactKey,
              activeSection: _activeSection,
              // pass portfolio data if needed
              name: portfolio.name,
            ),
            Divider(height: 0.5, color: theme.dividerColor),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: HeroSectionWidget(
                        key: _homeKey,
                        description: portfolio.description,
                        image: portfolio.image,
                        designation: portfolio.designation,
                      ),
                    ),
                    SizedBox(height: 35,),
                    SkillsSectionWidget(
                      key: _skillsKey,
                      skills: portfolio.skills,
                    ),
                    ProjectsSectionWidget(key: _projectsKey,projects:portfolio.projects),
                    ContactSectionWidget(key: _contactKey),
                    const FooterWidget(),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _Section {
  final String name;
  final GlobalKey key;
  const _Section(this.name, this.key);
}
