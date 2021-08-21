import 'dart:convert';
import 'dart:typed_data';

class ImageHelper {
  static Uint8List convertBase64ToImage(String base64String) {
    return base64.decode(base64String);
  }
}
