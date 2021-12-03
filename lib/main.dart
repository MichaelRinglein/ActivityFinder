import 'package:boredapi/api/activities.dart';
import 'package:boredapi/global/styles.dart';
import 'package:boredapi/single_activity.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity Finder',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home:
          const MyHomePage(title: 'Activity Finder - find an activity to do!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _activityServices = ActivitiesServices();
  late Future<SingleActivity> _singleActivity;

  @override
  void initState() {
    super.initState();
    _singleActivity = _activityServices.getSingleActivity();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Here is a activity you could do:',
              ),
              FutureBuilder<SingleActivity>(
                future: _singleActivity,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final String activity = snapshot.data!.activity;
                    final String type = snapshot.data!.type;
                    //final String price = snapshot.data!.price.toString();
                    final String participants =
                        snapshot.data!.participants.toString();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          activity,
                          style: const TextStyle(
                            fontSize: activityFontSize,
                            color: activityFontColor,
                            fontWeight: activityFontWeight,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '🔖 $type',
                              style: const TextStyle(
                                fontSize: categoryFontSize,
                                color: categoryFontColor,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            /*
                            Text(
                              '💰 $price USD',
                              style: const TextStyle(
                                fontSize: categoryFontSize,
                                color: categoryFontColor,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            */
                            Text(
                              '👨‍🦱 $participants person(s)',
                              style: const TextStyle(
                                fontSize: categoryFontSize,
                                color: categoryFontColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text(
                      'Loading...',
                      style: TextStyle(
                        fontSize: activityFontSize,
                        color: activityFontColor,
                        fontWeight: activityFontWeight,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _singleActivity = _activityServices.getSingleActivity();
          });
        },
        tooltip: 'Load another activity',
        label: const Text('Load another activity'),
      ),
    );
  }
}
