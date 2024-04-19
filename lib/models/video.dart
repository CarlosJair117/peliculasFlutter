//
//     final creditsResponse = creditsResponseFromMap(jsonString
import 'dart:convert';

class VideoResponse {
    VideoResponse({
        required this.id,
        required this.results,
    });

    int id;
    List<Results> results;

    factory VideoResponse.fromJson(String str) => VideoResponse.fromMap(json.decode(str));


    factory VideoResponse.fromMap(Map<String, dynamic> json) => VideoResponse(
        id: json["id"],
        results: List<Results>.from(json["results"].map((x) => Results.fromMap(x))),
    );

}

class Results {
    Results({
        required this.iso_639_1,
        required this.iso_3166_1,
        required this.name,
        required this.key,
        required this.site,
        required this.size,
        required this.type,
        required this.official,
        required this.published_at,
        required this.id,
    });

      String iso_639_1;
      String iso_3166_1;
      String name;
      String key;
      String site;
      int size;
      String type;
      bool official;
      String published_at;
      String id;


    factory Results.fromJson(String str) => Results.fromMap(json.decode(str));

    factory Results.fromMap(Map<String, dynamic> json) => Results(
        iso_639_1: json["iso_639_1"],
        iso_3166_1: json["iso_3166_1"],
        name: json["name"],
        key: json["key"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        published_at: json["published_at"],
        id: json["id"] == null ? null : json["id"]
    );
}