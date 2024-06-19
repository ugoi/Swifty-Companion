class UserImage {
  final String url;
  final ImageVersions? versions;
  static const defaultImageUrl = "assets/defaultProfilePicture.png";

  const UserImage({String? url, this.versions}) : url = url ?? defaultImageUrl;
}

class ImageVersions {
  final String micro;
  final String small;
  final String medium;
  final String large;
  static const defaultImageUrl = "assets/defaultProfilePicture.png";

  const ImageVersions(
      {String? micro, String? small, String? medium, String? large})
      : micro = micro ?? defaultImageUrl,
        small = small ?? defaultImageUrl,
        medium = medium ?? defaultImageUrl,
        large = large ?? defaultImageUrl;
}
