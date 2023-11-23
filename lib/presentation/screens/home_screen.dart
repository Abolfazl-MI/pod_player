import 'package:flutter/material.dart';
import 'package:pod_player/presentation/widgets/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: drawerKey,
        drawer: DrawerWidget(drawerKey: drawerKey),
        appBar: AppBar(
          title: const Text('PodPlayer'),
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          width: size.width,
          height: size.height,
          child: CustomScrollView(
            slivers: [
              SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      'https://media.khabaronline.ir/d/2023/03/08/3/5821498.jpg?ts=1678254396000',
                                    ),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('Test-test$index'),
                                Text('Test-test$index'),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }, childCount: 30),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (size.width / 150).floor(),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10))
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.podcasts,
                size: 30,
              ),
              // SizedBox(
              //   width: 5,
              // ),
              Text('Wellcome to PODPlayer!',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold)),
              Text(
                'No subscription found! add one from subscriptions page ',
                maxLines: 12,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ));
  }
}
