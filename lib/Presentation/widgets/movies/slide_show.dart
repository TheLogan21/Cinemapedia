import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/Entities/movies.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class MoviesSlideShow extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSlideShow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    //final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SizedBox(
      width: double.infinity,
      height: 210,
      child: Swiper(
        pagination: SwiperPagination(
            margin: EdgeInsets.only(top: 0),
            builder: DotSwiperPaginationBuilder(
                activeColor: colors.primary, color: colors.secondaryFixed)),
        viewportFraction: 0.8,
        scale: 0.85,
        autoplay: true,
        autoplayDelay: 2000,
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slide(movie: movies[index]),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black45, blurRadius: 10, offset: Offset(0, 12))
        ]);

    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
          decoration: decoration,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                errorBuilder: (context, error, stackTrace) => Image.network(
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Text("Error al cargar la imagen")),
                  movie.backdropPath.replaceAll('w500', 'original'),
                  fit: BoxFit.cover,
                ),
                movie.backdropPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const DecoratedBox(
                        decoration: BoxDecoration(color: Colors.black12));
                  }

                  return FadeIn(
                    delay: Duration(milliseconds: 50),
                    child: child,
                  );
                },
              ))),
    );
  }
}
