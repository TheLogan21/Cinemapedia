import 'package:cinemapedia/Config/constants/environment.dart';
import 'package:cinemapedia/domain/Datasource/movies_datasources.dart';
import 'package:cinemapedia/domain/Entities/movies.dart';
import 'package:cinemapedia/infraestructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infraestructure/models/MovieDB/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasources {
  final dio = Dio(BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      queryParameters: {
        "api_key": Environment.movieDbKey,
        "language": "es-MX"
      }));
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get("/movie/now_playing", queryParameters: {"page": page});

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
        .where(
          (moviedb) => moviedb.posterPath != "no-poster",
        )
        .map(
          (moviedb) => MovieMapper.muviedbToEntity(moviedb),
        )
        .toList();

    return movies;
  }
}
