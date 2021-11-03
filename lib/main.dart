import 'package:boredapi/api/activities.dart';
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
      title: 'Get a random activity',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Load a random acivity'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Here is a random activity:',
            ),
            FutureBuilder<SingleActivity>(
              future: _singleActivity,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final String activity = snapshot.data!.activity;
                  final String type = snapshot.data!.type;
                  final String price = snapshot.data!.price.toString();
                  final String participants =
                      snapshot.data!.participants.toString();
                  return Column(
                    children: [
                      Text(
                        activity,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '🔖 $type',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '💰 $price USD',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '👨‍🦱 $participants person(s)',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text(
                    'Loading...',
                    style: Theme.of(context).textTheme.headline4,
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
