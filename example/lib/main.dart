import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wikibase_sdk/wikibase_sdk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:node_interop/util.dart';

void main() => runApp(MyApp());

class Entity {
  List<String> id = [];
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();
  final _entity = Entity();

  var result = '';

  @override
  Widget build(BuildContext context) {
    var wbk = WBK(Config(
        instance: 'https://www.wikidata.org',
        sparqlEndpoint: 'https://query.wikidata.org/sparql'));

    return MaterialApp(
        home: Scaffold(
            body: SingleChildScrollView(
                child: Column(children: [
      Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Item ID'),
              onSaved: (input) {
                setState(() => _entity.id = input!.split('|'));
              },
            ),
            Row(children: [
              ElevatedButton(
                onPressed: () async {
                  final form = _formKey.currentState;

                  // Validate returns true if the form is valid, or false otherwise.
                  if (form!.validate()) {
                    form.save();

                    var entities = Entities(
                      ids: _entity.id,
                      languages: ['en'],
                    );

                    var url = wbk.getEntities(entities);

                    result = (await http.get(Uri.parse(url))).body;

                    setState(() {});
                  }
                },
                child: const Text('getEntities'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final form = _formKey.currentState;

                  // Validate returns true if the form is valid, or false otherwise.
                  if (form!.validate()) {
                    form.save();

                    var entities = Entities(
                        ids: _entity.id,
                        languages: [
                          'en'
                        ], // returns all languages if not specified
                        props: [
                          'info',
                          'claims'
                        ], // returns all data if not specified

                        format: 'json',
                        redirections: false);

                    var url = wbk.getManyEntities(entities);

                    result = (await http.get(Uri.parse(url))).body;

                    setState(() {});
                  }
                },
                child: const Text('getManyEntities'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final form = _formKey.currentState;

                  // Validate returns true if the form is valid, or false otherwise.
                  if (form!.validate()) {
                    form.save();

                    var sitelinks = Sitelinks(
                        titles: _entity.id,
                        sites: ['enwikivoyage'],
                        languages: ['en', 'fr', 'de'],
                        props: ['info', 'claims'],
                        format: 'json', // defaults to json
                        redirections: false // defaults to true
                        );

                    var url = wbk.getEntitiesFromSitelinks(sitelinks);

                    result = (await http.get(Uri.parse(url))).body;

                    setState(() {});
                  }
                },
                child: const Text('getEntitiesFromSitelinks'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final form = _formKey.currentState;

                  // Validate returns true if the form is valid, or false otherwise.
                  if (form!.validate()) {
                    form.save();

                    var entities = Entities(ids: _entity.id);

                    var url = wbk.getEntities(entities);

                    var entity =
                        jsonDecode((await http.get(Uri.parse(url))).body);

                    var result1 = wbk.simplify.labels(jsify(
                        entity['entities'][_entity.id[0]]['labels']));

                    result = jsonEncode(dartify(result1));

                    setState(() {});
                  }
                },
                child: const Text('simplify.labels'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final form = _formKey.currentState;

                  // Validate returns true if the form is valid, or false otherwise.
                  if (form!.validate()) {
                    form.save();

                    var entities = Entities(ids: _entity.id);

                    var url = wbk.getEntities(entities);

                    var entity =
                        jsonDecode((await http.get(Uri.parse(url))).body);

                    print(entity['entities'][_entity.id[0]]['claims']);

                    var result1 = wbk.simplify.claims(
                        jsify(
                            entity['entities'][_entity.id[0]]['claims']),
                        SimplifyClaimsOptions(keepIds: true));

                    result = jsonEncode(dartify(result1));

                    setState(() {});
                  }
                },
                child: const Text('simplify.claims'),
              ),
            ]),
          ],
        ),
      ),
      SelectableText(result),
    ]))));
  }
}
