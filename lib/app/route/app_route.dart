enum AppRoute {
  signIn,
  home,
  profile,
  seatmap,
  helpList,
  help,
  writingVenues,
  writingSeatInfo,
  writingPerformance,
  writingReview,
  writingRating,
  reviewDetail;

  String get path => '/$name';
}