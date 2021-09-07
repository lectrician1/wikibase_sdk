@JS()
library wikibase_sdk;

import 'package:js/js.dart';

@JS()
class WBK {
  external WBK(Config config);

  external String searchEntities(SearchEntitiesOptions options);

  external String cirrusSearchPages(CirrusSearchPagesOptions options);

  /// Get up to 50 entities
  external String getEntities(Entities entities);

  /// Fulfill requests more than 50 entities.
  external String getManyEntities(Entities entities);

  /// Get the revision history for the spcified entities.
  external String getRevisions(List<String> entities,
      [RevisionOptions options]);

  /// Get a entity's state at a specific revision.
  ///
  /// The revision id can be obtained using [getRevisions]. Use `revid` returned.
  external String getEntityRevision(String id, int revision);

  /// Use the names of Wikipedia articles to get their entities.
  external String getEntitiesFromSitelinks(Sitelinks sitelinks);

  /// Returns the [Simplify] object and access to simplification properties
  external Simplify get simplify;

  external String sparqlQuery(String sparql);

  external String getReverseClaims(List<String> properties, List<String> values,
      [GetReverseClaimsOptions options]);

  external bool isEntityId(String entity);

  external bool isItemId(String item);

  external bool isPropertyId(String property);

  external bool isLexemeId(String lexeme);

  external bool isFormId(String form);

  external bool isSenseId(String sense);

  external bool isGuid(String claim);

  external bool isHash(String hash);

  external bool isPropertyClaimsId(String id);

  external bool isEntitySchemaId(String id);

  external bool isRevisionId(String id);

  external bool isNumericId(String id);

  external bool getNumericId(String id);

  external dynamic truthyClaims(dynamic claims);

  external dynamic truthyPropertyClaims(dynamic property);

  external String getSitelinkUrl(String site, String title);

  external dynamic getSitelinkData(String url);

  external bool isSitelinkKey(String key);

  external dynamic wikibaseTimeToDateObject(String time);

  external String wikibaseTimeToEpochTime(String time);

  external String wikibaseTimeToISOString(String time);

  /// Pass string value or entire object
  external String wikibaseTimeToSimpleDay(dynamic time);

  external String getImageUrl(String file, [int width]);

  external String getEntityIdFromGuid(String guid);
}

/// Class representing the simplify property returned by [WBK] and its properties
@JS()
class Simplify {
  external factory Simplify();

  external dynamic claims(dynamic claims, [SimplifyClaimsOptions options]);

  external dynamic propertyClaims(dynamic property,
      [SimplifyClaimsOptions options]);

  external dynamic claim(dynamic claim, [SimplifyClaimsOptions options]);

  external dynamic qualifiers(dynamic qualifiers);

  external dynamic propertyQualifiers(dynamic qualifierArray);

  external dynamic qualifier(dynamic qualifier);

  external dynamic references(dynamic references);

  external dynamic snaks(dynamic entity);

  external dynamic propertySnaks(dynamic entity);

  external dynamic snak(dynamic entity);

  /// Apply all simplifiers at once.
  external dynamic entities(Object entity,
      [SimplificationOptions simplificationOptions]);

  external dynamic labels(dynamic labels);

  external dynamic aliases(dynamic aliases);

  external dynamic sitelinks(dynamic sitelinks,
      [SimplifySitelinksOptions options]);

  external dynamic lemmas(dynamic lemmas);

  external dynamic forms(dynamic forms);

  external dynamic senses(dynamic senses);

  external dynamic sparqlResults(dynamic results,
      [SparqlResultsOptions options]);
}

/// The configuration class for [WBK].
@JS()
@anonymous
class Config {
  external factory Config({String instance, String sparqlEndpoint});
}

// TODO: Add continue argument
/// continue argument is not yet supported
@JS()
@anonymous
class SearchEntitiesOptions {
  external factory SearchEntitiesOptions(
      {required String search,
      String type,
      String format,
      String language,
      String uselang,
      int limit});
}

@JS()
@anonymous
class CirrusSearchPagesOptions {
  external factory CirrusSearchPagesOptions(
      {String search,
      String haswbstatement,
      List<int> namespace,
      String profile,
      String sort,
      int limit,
      int offset,
      int format});
}

/// Configuration class for entities retreived by [getEntities] and [getManyEntities].
///
/// format defaults to json.
///
/// redirections defaults to true.
@JS()
@anonymous
class Entities {
  external factory Entities(
      {required List<String> ids,
      List<String> languages,
      List<String> props,
      String format,
      bool redirections});
}

/// Options configuration class for [WBK.getRevisions]
@JS()
@anonymous
class RevisionOptions {
  external factory RevisionOptions(
      {int limit,
      String start,
      String end,
      String prop,
      String user,
      String excludeuser,
      String tag});
}

/// Configuration class for entities retreived by [WBK.getEntitiesFromSitelinks].
///
/// format defaults to json.
///
/// redirections defaults to true.
@JS()
@anonymous
class Sitelinks {
  external factory Sitelinks(
      {required List<String> titles,
      List<String> sites,
      List<String> languages,
      List<String> props,
      String format,
      bool redirections});
}

/// Options for [Simplify.entities]
@JS()
@anonymous
class SimplificationOptions {
  external factory SimplificationOptions(
      {String entityPrefix,
      String propertyPrefix,
      bool keepRichValues,
      bool keepQualifiers,
      bool keepReferences,
      bool keepIds,
      bool keepHashes,
      bool keepNonTruthy,
      bool addUrl});
}

/// Configuration class for [Simplify.sitelinks]
@JS()
@anonymous
class SimplifySitelinksOptions {
  external factory SimplifySitelinksOptions({bool addurl});
}

@JS()
@anonymous
class SimplifyClaimsOptions {
  external factory SimplifyClaimsOptions({
    String entityPrefix,
    String propertyPrefix,
    bool keepRichValues,
    bool keepTypes,
    bool keepQualifiers,
    bool keepReferences,
    bool keepIds,
    bool keepHashes,
    bool keepNonTruthy,
    bool keepRanks,
    String novalueValue,
    String somevalueValue,
    bool keepSnaktypes,
    bool keepAll,
    String timeConverter,
  });
}

@JS()
@anonymous
class SparqlResultsOptions {
  external factory SparqlResultsOptions({bool minimize});
}

@JS()
@anonymous
class GetReverseClaimsOptions {
  external factory GetReverseClaimsOptions(
      {int limit, bool keepProperties, bool caseInsensitive});
}
