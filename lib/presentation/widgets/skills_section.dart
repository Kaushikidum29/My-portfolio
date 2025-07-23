import 'package:flutter/material.dart';
import 'package:my_portfolio/data/models/portfolio_model.dart';

class SkillsSectionWidget extends StatelessWidget {
  final List<Skill>? skills;
  const SkillsSectionWidget({Key? key, required this.skills}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration:  BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(color: Colors.grey.shade300,thickness: 0.3,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0,vertical: 35.0),
            child: Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.spaceBetween,
              children: (skills ?? []).map((s) => _buildSkillIcon(s,context)).toList(),
            ),
          ),
          Divider(color: Colors.grey.shade300,thickness:0.3),
        ],
      ),
    );
  }
  Widget _buildSkillIcon(Skill skill,context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF5E72E4).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Image.network(skill.image ?? "", fit: BoxFit.fill,),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            skill.title ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF525F7F),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsIllustration() {
    return Container(
      height: 320,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/img.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
