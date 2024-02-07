import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freeman/src/Screens/const/const.dart';
import 'package:freeman/src/router_helper.dart';




class Vegetable {
  final String name;
  final String imageUrl;

  Vegetable({required this.name, required this.imageUrl});
}


class VegetableScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final selectedVegetable = ref.watch(selectedVegetableProvider);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
    return Scaffold(
      appBar: AppBar(
        title: Text('Vegetables'),
         leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Routes.pushNamedAndRemoveUntil(Routes.home),
            ),
            
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: vegetables.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4.0,
              child: InkWell(
                onTap: () {
                  // Adding a null check before accessing state
                  ref.read(selectedVegetableProvider.notifier).state = vegetables[index];
                   Routes.pushReplacementNamed(Routes.vegDetails);

                },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        vegetables[index]!.image,
                        height: 150.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          vegetables[index]!.name,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
