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
}
