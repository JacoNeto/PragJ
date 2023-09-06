import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class VisionConnect extends GetConnect {
  @override
  void onInit() async {
    Get.log('Base Connect Inicializado');

    //URL base
    httpClient.baseUrl = 'https://vision.astica.ai';

    httpClient.addResponseModifier((request, response) {
      if (Get.isLogEnable) {
        debugPrint(request.method);
        debugPrint('${request.url}');
      }
      debugPrint('${response.body}');
      return response;
    });

    // Json Content Type
    httpClient.defaultContentType = 'application/json; charset=utf-8';

    //Tempo de duração das requisições
    httpClient.timeout = const Duration(seconds: 15);

    //Em caso de falha, número de tentativas
    httpClient.maxAuthRetries = 2;
  }

  // Describe
  Future<Response> describe(String image) async {
    final response = await post(
      '/describe',
      <String, dynamic>{
        "tkn":
            "D995840B-12C2-4F05-BED6-7CD6E81E9D3505D3D2C9-E72E-4A1D-87C1-8B83D7DFA02A",
        "modelVersion": "2.1_full",
        "input": image,
        "visionParams": "gpt, describe, describe_all, tags, objects",
        "gpt_prompt": "",
        "gpt_length": "90" //FIXME: update address id
      },
    );
    return response;
  }
}
