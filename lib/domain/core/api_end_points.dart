import 'package:netflix_clone/core/string.dart';
import 'package:netflix_clone/infrastructure/api_key.dart';

class ApiEndPoints {
  static const downloads = "$kBaseUrl/trending/all/week?api_key=$apiKey";
  static const search = "$kBaseUrl/search/movie?api_key=$apiKey";
  static const hotAndNewMovie = "$kBaseUrl/discover/movie?api_key=$apiKey";
  static const hotAndNewTv = "$kBaseUrl/discover/tv?api_key=$apiKey";
}
