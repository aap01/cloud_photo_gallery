import 'package:cloud_photo_gallery/feature/gallery/data/model/links_model.dart';

const linksMap = {
  'self': 'https://api.unsplash.com/photos/nhieADPfznQ',
  'html': 'https://unsplash.com/photos/nhieADPfznQ',
  'download':
      'https://unsplash.com/photos/nhieADPfznQ/download?ixid=MnwzMzc2NDB8MHwxfGFsbHwyfHx8fHx8Mnx8MTY1NTE0OTcxOA',
  'download_location':
      'https://api.unsplash.com/photos/nhieADPfznQ/download?ixid=MnwzMzc2NDB8MHwxfGFsbHwyfHx8fHx8Mnx8MTY1NTE0OTcxOA'
};

final linksModel = LinksModel(
  self: linksMap['self']!,
  html: linksMap['html']!,
  download: linksMap['download']!,
  downloadLocation: linksMap['download_location']!,
);
