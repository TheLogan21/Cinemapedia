import 'package:cinemapedia/domain/Entities/movies.dart';
import 'package:cinemapedia/infraestructure/models/MovieDB/movie_moviedb.dart';

class MovieMapper {
  static Movie muviedbToEntity(MovieMovieDB movieDB) => Movie(
      adult: movieDB.adult,
      backdropPath: (movieDB.backdropPath != "")
          ? "https://image.tmdb.org/t/p/w500/${movieDB.backdropPath}"
          : "https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F6c50072a-fccd-4c19-a87a-679d7debdb67_608x608.webp",
      genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
      id: movieDB.id,
      originalLanguage: movieDB.originalLanguage,
      originalTitle: movieDB.originalTitle,
      overview: movieDB.overview,
      popularity: movieDB.popularity,
      posterPath: (movieDB.posterPath != "")
          ? "https://image.tmdb.org/t/p/w500/${movieDB.posterPath}"
          : "no-poster",
      releaseDate: movieDB.releaseDate,
      title: movieDB.title,
      video: movieDB.video,
      voteAverage: movieDB.voteAverage,
      voteCount: movieDB.voteCount); 
}
