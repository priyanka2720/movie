import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/model/movie.dart';
import 'package:movie/movie_ui/movie_ui.dart';
import 'package:movie/util/hexcolor.dart';

class MovieListView extends StatelessWidget {
  final List<Movie> movieList = Movie.getMovies();
  final List movies = [
    "The Vampire diaries",
    "Sacred Games",
    "Twilight",
    "3 idiots",
    "The Originals"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Movies")),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
        itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
          return Stack(
              children: <Widget>[
                movieCard(movieList[index], context),
                Positioned(
                  top: 10.0,
                    child: movieImage(movieList[index].images[0])),
              ]);
    //     return Card(
    //       elevation: 4.5,
    //       color: Colors.white,
    //         child: ListTile(
    //           leading: CircleAvatar(
    //             child: Container(
    //               width: 200,
    //               height: 200,
    //               decoration: BoxDecoration(
    //                 image: DecorationImage(
    //                   image: NetworkImage(movieList[index].poster),
    //                   fit: BoxFit.cover
    //                 ),
    //                 color: Colors.amberAccent,
    //                 borderRadius: BorderRadius.circular(13.9)
    //               ),
    //               child: null,
    //             ),
    //           ),
    //           trailing: Text("...."),
    //           title: Text(movieList[index].title),
    //             subtitle: Text("${movieList[index].title }"),
    //             onTap: () {
    //             //invoke the navigator -it knows how to navigate all through the routes
    //             Navigator.push(context, MaterialPageRoute(
    //                 builder: (context) => MovieListViewDetails(movieName: movieList.elementAt(index).title,
    //                 movie: movieList[index]
    //                 )));
    //              },
    //           //onTap: () => debugPrint("Movie name: ${movies.elementAt(index)}"),
    //         ),
    //     );
    }),
    );
  }
  Widget movieCard(Movie movie, BuildContext context){
    return  InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60),
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0,
            bottom: 8.0,
            left: 54.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(movie.title, style:
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            color: Colors.white
                          ),),
                      ),
                      Flexible(
                        child: Text("Rating: ${movie.imdbRating} / 10",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.greenAccent
                          ),
                        ),
                      ),
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Released: ${movie.released}",
                        style: mainTextStyle()),
                      Text(movie.runtime,
                        style: mainTextStyle()),
                      Text(movie.rated,
                        style: mainTextStyle()),
                    ],
                  )
                ],
              ),
            ),
          )
        )
      ),
      onTap: () => {
      Navigator.push(context, MaterialPageRoute(
      builder: (context) => MovieListViewDetails(movieName: movie.title,
    movie: movie)))
      },
    );
  }
  TextStyle mainTextStyle() {
    return TextStyle(
        fontSize: 15.0,
        color: Colors.greenAccent
        );
  }

  Widget movieImage(String imageUrl){
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: NetworkImage( imageUrl ?? "https://picsum.photos/id/237/200/300" ),
          fit: BoxFit.cover
        )
      ),
    );
  }
}

//new route (screen or page)
class MovieListViewDetails extends StatelessWidget {
  final String movieName;
  final Movie movie;
  const MovieListViewDetails({Key? key,  required this.movieName, required this.movie})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.cyan.shade900,
      ),
      body: ListView(
        children: <Widget>[
          MovieDetailsThumbnail(thumbnail: movie.images[0]),
          MovieDetailsHeaderWithPoster(movie: movie),
          HorizontalLIne(),
          MovieDetailsCast(movie: movie),
          HorizontalLIne(),
          MovieDetailsExtraPosters(posters: movie.images),
        ],
      )
    );
  }
}

