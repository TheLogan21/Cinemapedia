import 'package:cinemapedia/domain/Entities/movies.dart';





abstract class MoviesDatasources {
  Future<List<Movie>> getNowPlaying({int page = 1});
  

}
