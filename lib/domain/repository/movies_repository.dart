import 'package:cinemapedia/domain/Entities/movies.dart';





abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
  

}