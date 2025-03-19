import 'package:cinemapedia/domain/Entities/movies.dart';

abstract class MoviesDatasources {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopularMovies({int page = 1});
  Future<List<Movie>> getUpCominMovies({int page = 1});
  Future<List<Movie>> getTopRatedMovies({int page = 1});
}
