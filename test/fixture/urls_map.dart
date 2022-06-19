import 'package:cloud_photo_gallery/feature/gallery/data/model/urls_model.dart';

const urlsMap = {
  'raw':
      'https://images.unsplash.com/photo-1655146549102-fb711b021825?ixid=MnwzMzc2NDB8MHwxfGFsbHwyfHx8fHx8Mnx8MTY1NTE0OTcxOA&ixlib=rb-1.2.1',
  'full':
      'https://images.unsplash.com/photo-1655146549102-fb711b021825?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwzMzc2NDB8MHwxfGFsbHwyfHx8fHx8Mnx8MTY1NTE0OTcxOA&ixlib=rb-1.2.1&q=80',
  'regular':
      'https://images.unsplash.com/photo-1655146549102-fb711b021825?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMzc2NDB8MHwxfGFsbHwyfHx8fHx8Mnx8MTY1NTE0OTcxOA&ixlib=rb-1.2.1&q=80&w=1080',
  'small':
      'https://images.unsplash.com/photo-1655146549102-fb711b021825?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMzc2NDB8MHwxfGFsbHwyfHx8fHx8Mnx8MTY1NTE0OTcxOA&ixlib=rb-1.2.1&q=80&w=400',
  'thumb':
      'https://images.unsplash.com/photo-1655146549102-fb711b021825?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMzc2NDB8MHwxfGFsbHwyfHx8fHx8Mnx8MTY1NTE0OTcxOA&ixlib=rb-1.2.1&q=80&w=200',
  'small_s3':
      'https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1655146549102-fb711b021825'
};

final mappedUrlsModel = UrlsModel(
  raw: urlsMap['raw']!,
  full: urlsMap['full']!,
  regular: urlsMap['regular']!,
  small: urlsMap['small']!,
  thumb: urlsMap['thumb']!,
  smallS3: urlsMap['small_s3']!,
);
