import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplashdemo/bloc/actions.dart';
import 'package:unsplashdemo/bloc/bloc.dart';
import 'package:unsplashdemo/bloc/states.dart';
import 'package:unsplashdemo/models/image.dart';

class TabView extends StatefulWidget {
  final int collectionId;
  TabView(this.collectionId);
  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  FetchBloc bloc;
  List<UnsplashImage> imageList;
  ScrollController _controller;

  @override
  void initState() {
    imageList = [];
    bloc = FetchBloc(widget.collectionId);
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        bloc.add(FetchAction());
      }
    });
    bloc.add(FetchAction());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<FetchBloc, FetchState>(
          bloc: bloc,
          listener: (BuildContext context, FetchState state) {
            if (state is LoadingFetchState)
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                'Fetching images from server',
              )));
            if (state is FailedFetchState)
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                'Error fetching images from server',
              )));
            if (state is LoadedFetchState) {
              Scaffold.of(context).removeCurrentSnackBar();
              setState(() {
                imageList.addAll(state.imagesList);
              });
            }
          },
          child: GridView.builder(
              controller: _controller,
              itemCount: imageList.length + 1,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.7),
              itemBuilder: (context, index) {
                if (index == imageList.length)
                  return CupertinoActivityIndicator();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.network(
                          imageList[index].url,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 10.0),
                      child: Text(imageList[index].description),
                    )
                  ],
                );
              })),
    );
  }
}
