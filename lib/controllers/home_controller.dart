import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  final ImagePicker picker = ImagePicker();
  final FlutterTts flutterTts = FlutterTts();

  // ignore: unnecessary_cast
  Rx<XFile?> imageFile = (null as XFile?).obs;
  Rx<String> text = "".obs;
  var isReproducing = false.obs;

  @override
  void onInit() {
    flutterTts.awaitSpeakCompletion(false);
    flutterTts.setQueueMode(1);
    flutterTts.setLanguage("pt");
    flutterTts.setSpeechRate(1);
    flutterTts.setVoice({"name": "Karen", "locale": "pt-BR"});
    flutterTts.setCompletionHandler(() {
      isReproducing.value = false;
    });
    super.onInit();
  }

  bool hasImageFile() {
    return imageFile.value != null;
  }

  Future<void> pickImageFromGallery() async {
    imageFile.value = await picker.pickImage(source: ImageSource.gallery);
  }

  Future<void> pickImageFromCamera() async {
    imageFile.value = await picker.pickImage(source: ImageSource.camera);
  }

  void speak(String text) async {
    isReproducing.value = true;
    await flutterTts.speak(text);
  }

  void stop() async {
    isReproducing.value = false;
    await flutterTts.stop();
  }
}
