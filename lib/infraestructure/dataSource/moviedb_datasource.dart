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
  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);

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

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get("/movie/now_playing", queryParameters: {"page": page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    final response =
        await dio.get("/movie/popular", queryParameters: {"page": page});
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getUpCominMovies({int page = 1})async {
    final response =
        await dio.get("/movie/upcoming", queryParameters: {"page": page});
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1}) async {
    final response =
        await dio.get("/movie/top_rated", queryParameters: {"page": page});
    return _jsonToMovies(response.data);
  }
}
