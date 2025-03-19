import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/Config/helpers/humans_formats.dart';
import 'package:cinemapedia/domain/Entities/movies.dart';
import 'package:flutter/material.dart';

class MoviesHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? tittle;
  final String? subtittle;
  final VoidCallback? loadNextpage;

  const MoviesHorizontalListview(
      {super.key,
      required this.movies,
      this.tittle,
      this.subtittle,
      this.loadNextpage});

  @override
  State<MoviesHorizontalListview> createState() =>
      _MoviesHorizontalListviewState();
}

class _MoviesHorizontalListviewState extends State<MoviesHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(
      () {
        if (widget.loadNextpage == null) return;

        if ((scrollController.position.pixels + 200) >=
            scrollController.position.maxScrollExtent) {
          widget.loadNextpage!();
        }
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          if (widget.tittle != null || widget.subtittle != null)
            _Titulo(
              subTitle: widget.subtittle,
              title: widget.tittle,
            ),
          Expanded(
              child: ListView.builder(
            controller: scrollController,
            itemBuilder: (context, index) =>
                FadeInRight(child: _Slide(moviesMostrar: widget.movies[index])),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.movies.length,
          ))
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie moviesMostrar;
  const _Slide({required this.moviesMostrar});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                moviesMostrar.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return Center(child: const CircularProgressIndicator());
                  }

                  return FadeIn(child: child);
                },
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          //* TITULO

          SizedBox(
            width: 150,
            child: Text(
              moviesMostrar.title,
              maxLines: 2,
              style: textStyle.titleSmall,
            ),
          ),

          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(
                  Icons.star_half_outlined,
                  color: Colors.amber,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  "${moviesMostrar.voteAverage}",
                  style: textStyle.bodyMedium?.copyWith(color: Colors.amber),
                ),
                Spacer(),
                const Icon(
                  Icons.verified_outlined,
                  color: Colors.green,
                ),
                const SizedBox(width: 5),
                Text(
                  HumansFormats.number(moviesMostrar.popularity),
                  style: textStyle.bodyMedium,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Titulo extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Titulo({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final tittleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: EdgeInsets.only(top: 20),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: tittleStyle,
            ),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
              style: ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(subTitle!),
            )
        ],
      ),
    );
  }
}
