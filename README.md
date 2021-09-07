# wikibase_sdk
A Dart-JS interop package for the [wikibase-sdk](https://github.com/maxlath/wikibase-sdk) JS package in Dart.

All functions have been reimplemented, however a significant majority have not been tested. Therefore, this is still a **work-in-process**.

Please see the JS package's documentation for how to use the library's functions. 

All arguments that take object literals have dedicated Dart classes to use input them. If an argument can take a string or list of strings for an argument in the JS documentation, it only takes a `List` of `Strings` in the Dart implementation of the function.

Please see the Flutter `/example/lib/main.dart` file to see how to use this package in your Dart or Flutter project. 

All of the `simplify` methods and some others require inputting JS Objects and also return JS Objects. Therefore, conversion functions between Dart and JS like what [`node_interop`](https://pub.dev/packages/node_interop) provides with [`jsify`](https://pub.dev/documentation/node_interop/latest/node_interop.util/jsify.html) and [`dartify`](https://pub.dev/documentation/node_interop/latest/node_interop.util/dartify.html),

In future development, all functions will be added and tested to the Flutter example project.