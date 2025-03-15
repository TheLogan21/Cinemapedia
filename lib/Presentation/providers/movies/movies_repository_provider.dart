import 'package:cinemapedia/infraestructure/dataSource/moviedb_datasource.dart';
import 'package:cinemapedia/infraestructure/repository/movie_repository_implementatio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//repositorio inmutable
final movieRepositoryProvier = Provider((ref) {
  return MovieRepositoryImplementatio(datasource: MoviedbDatasource());
});
