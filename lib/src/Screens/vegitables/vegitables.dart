// ignore_for_file: dead_code
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freeman/src/Screens/const/const.dart';
import 'package:freeman/src/Screens/vegitables/chart.dart';
import 'package:freeman/src/router_helper.dart';

class GrowingDetailsScreen extends ConsumerStatefulWidget {
  const GrowingDetailsScreen({super.key});

  @override
  ConsumerState<GrowingDetailsScreen> createState() =>
      _GrowingDetailsScreenState();
}

class _GrowingDetailsScreenState extends ConsumerState<GrowingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final vegetableDetails = ref.read(selectedVegetableProvider);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: true, // Set floating to true
            pinned: true,
            snap: true,
            backgroundColor: Colors.red,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Routes.pushNamedAndRemoveUntil(Routes.vegList),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title:  Text(
                vegetableDetails!.name,
                style: TextStyle(fontSize: 25),
              ),
              background: Image.asset(
                vegetableDetails.appBarImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 16, bottom: 5),
                  child: Text(
                    'Quick Info',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text(
                    '(Tap on Cards for more details)',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Adjust the count based on your preference
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _showDetailPopup(context, vegetableDetails.info[index]);
                    },
                    child: Card(
                      elevation: 4.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            vegetableDetails.info[index].title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SvgPicture.asset(
                            vegetableDetails.info[index].iconPath,
                            height: 40,
                            width: 40,
                          ),
                          Text(
                            vegetableDetails.info[index].shortSpec,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: vegetableDetails.info.length,
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(top: 20),
          ),
          SliverList(
            delegate: SliverChildListDelegate([const GanttChart()]),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(top: 50),
          ),
        ],
      ),
    );
  }
}

void _showDetailPopup(BuildContext context, VegetableDetail detail) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(detail.title),
        content: Text(detail.description),
      );
    },
  );
}
