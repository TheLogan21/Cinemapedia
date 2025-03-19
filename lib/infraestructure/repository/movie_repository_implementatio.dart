import 'package:cinemapedia/domain/Datasource/movies_datasources.dart';
import 'package:cinemapedia/domain/Entities/movies.dart';
import 'package:cinemapedia/domain/repository/movies_repository.dart';

class MovieRepositoryImplementatio extends MoviesRepository {
  final MoviesDatasources datasource;

  MovieRepositoryImplementatio({required this.datasource});

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) {
    return datasource.getPopularMovies(page: page);
  }

  @override
  Future<List<Movie>> getUpCominMovies({int page = 1}) {
    return datasource.getUpCominMovies(page: page);
  }

  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1}) {
    return datasource.getTopRatedMovies(page: page);
  }
}
