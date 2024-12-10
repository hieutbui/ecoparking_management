import 'package:ecoparking_management/resources/asset_paths.dart';

class ImagePaths {
  static String get icPerson => _getIconPath('ic_person.svg');

  static String _getImagePath(String imageName) =>
      AssetPaths.images + imageName;
  static String _getIconPath(String iconName) => AssetPaths.icons + iconName;
}
