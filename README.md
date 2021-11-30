# Activity Finder build with Flutter and Bored API for Android and Web

This project integrates the Bored API in Flutter.



## Packages Used (all with Null safety)

- http

## Live Demos

- [Web](https://flutterwebapps.com/portfolio/activity-finder/#/)
- [Android (Play Store)](https://play.google.com/store/apps/details?id=com.strawanzer.boredapi)


## Documentation

The steps of the article of http from the [Flutter cookbook](https://flutter.dev/docs/cookbook/networking/fetch-data) is followed.

### main.dart
A `FutureBuilder` is used to display the data.

On click on the `FloatingActionButton` the state is set to re-render the `FutureBuilder` again (since setting state runs the build function again).

### api/activities.dart
A `Future` is used for the API call. The response is parsed into the `SingleActivity` class.

### single_activity.dart
A `SingleActivity` custom class takes the response from the Bored API and sorts the data from the received JSON.