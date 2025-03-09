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
  reviewDetail,
  bookmarkedReviews;

  String get path => '/$name';
}