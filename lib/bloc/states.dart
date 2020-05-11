import 'package:unsplashdemo/models/image.dart';

abstract class FetchState {}

class LoadingFetchState extends FetchState {}

class LoadedFetchState extends FetchState {
  List<UnsplashImage> imagesList;
  LoadedFetchState(this.imagesList);
}

class FailedFetchState extends FetchState {}
