class TopSites {
  static final List<TopSiteDataEntity> topSites = [
    TopSiteDataEntity(
        title: "You Tube",
        url: "https://www.youtube.com/",
        iconUrl: "assets/icons/youtube.svg"),
    TopSiteDataEntity(
        title: "FaceBook",
        url: "https://www.facebook.com/",
        iconUrl: "assets/icons/facebook.svg"),
    TopSiteDataEntity(
        title: "Reddit",
        url: "https://www.reddit.com/",
        iconUrl: "assets/icons/reddit.svg"),
  ];
}

class TopSiteDataEntity {
  final String title;
  final String url;
  final String iconUrl;
  TopSiteDataEntity({
    required this.title,
    required this.url,
    required this.iconUrl,
  });
}
