import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as HTTP;
import 'package:unsplashdemo/bloc/actions.dart';
import 'package:unsplashdemo/bloc/states.dart';
import 'package:unsplashdemo/models/image.dart';

class FetchBloc extends Bloc<FetchAction, FetchState> {
  int page;
  int collectionId;
  FetchBloc(this.collectionId) : page = 0;

  @override
  FetchState get initialState => LoadingFetchState();

  @override
  Stream<FetchState> mapEventToState(FetchAction event) async* {
    if (event is FetchAction) yield* _mapFetchActionToState();
    // if (event is MoreFetchAction) return _mapMoreFetchActionToState();
  }

  Stream<FetchState> _mapFetchActionToState() async* {
    yield LoadingFetchState();
    try {
      List<UnsplashImage> imagesList = await _fetchImageList();
      yield LoadedFetchState(imagesList);
    } catch (_) {
      yield FailedFetchState();
    }
  }

  Future<List<UnsplashImage>> _fetchImageList() async {
    String url =
        'https://api.unsplash.com/collections/$collectionId/photos?client_id=pYg0mMiEz_va8LQJ6_-NXWm0CcJwROHWX5tyFXdfcWA&page=${++page}';
    try {
      HTTP.Response response = await HTTP.get(url);
      if (response.statusCode == 200) {
        List result = jsonDecode(response.body);
        return result.map((json) => UnsplashImage.fromJSON(json)).toList();
      } else {
        throw Exception();
      }
    } catch (e) {
      throw e;
    }
  }

  // Stream<FetchState> _mapMoreFetchActionToState() {}
}
