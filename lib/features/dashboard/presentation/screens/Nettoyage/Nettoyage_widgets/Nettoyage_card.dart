import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NettoyageCard extends StatelessWidget {
  final String title;
  final List<String> plan;
  final String date;

  const NettoyageCard({super.key, required this.title, required this.plan, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xffF4F4F4), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(title, style: Theme.of(context).textTheme.labelMedium),
              ),
              Row(
                children: const [
                  FaIcon(
                    FontAwesomeIcons.ellipsis,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10, // space between items
            runSpacing: 10, // space between rows
            children: plan.map((item) => NettoyageCardContainer(plan: item)).toList(),
          ),
          const SizedBox(height: 10),
          Text(date, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class NettoyageCardContainer extends StatelessWidget {
  final String plan;

  const NettoyageCardContainer({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(plan),
    );
  }
}


class NettoyageCard_Container extends StatelessWidget {
  final String plan;
  const NettoyageCard_Container({super.key , required this.plan});

  @override
  Widget build(BuildContext context) {
    // Calculate width for each container
    final double containerWidth = (MediaQuery.of(context).size.width - 40 - 50) / 2;

    return Container(
      width: containerWidth,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Color(0xffF4F4F4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        plan,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
