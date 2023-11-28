import 'dart:convert';
import 'dart:typed_data';

Uint8List fromBase64ToBytes(String base64String) {
  return base64Decode(base64String);
}
