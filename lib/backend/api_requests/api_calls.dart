import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_commons/api_requests/api_manager.dart';


export 'package:ff_commons/api_requests/api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start PDFCOLLAB ApiFlow API Group Code

class PDFCOLLABApiFlowAPIGroup {
  static String getBaseUrl() =>
      'https://gw.apixflow.com/api/92ff717a8ac14ca59ac118110ee06820';
  static Map<String, String> headers = {
    'Authorization':
        'Bearer NTRmYzBiYzJkZjc4ZTBhYjllNDkzYTVkZmIzMmJjNjc6OTc5NTZhMDUwNDcyNTgxNGM0ZDNkYTIwNjFjN2QzYmQ=',
  };
  static GeneratePDFCall generatePDFCall = GeneratePDFCall();
}

class GeneratePDFCall {
  Future<ApiCallResponse> call({
    String? name = '',
    String? address = '',
    String? phone = '',
    String? partnershipType = '',
    String? partnershipDate = '',
    String? status = '',
    String? startDate = '',
    String? notes = '',
    String? contractId = '',
  }) async {
    final baseUrl = PDFCOLLABApiFlowAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "name": "${escapeStringForJson(name)}",
  "address": "${escapeStringForJson(address)}",
  "phone": "${escapeStringForJson(phone)}",
  "partnership_type": "${escapeStringForJson(partnershipType)}",
  "partnership_date": "${escapeStringForJson(partnershipDate)}",
  "status": "${escapeStringForJson(status)}",
  "start_date": "${escapeStringForJson(startDate)}",
  "notes": "${escapeStringForJson(notes)}",
  "contract_id": "${escapeStringForJson(contractId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Generate PDF',
      apiUrl:
          '${baseUrl}/generate?name=${name}&address=${address}&phone=${phone}&partnership_type=${partnershipType}&partnership_date=${partnershipDate}&status=${status}&start_date=${startDate}&notes=${notes}&contract_id=${contractId}',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Bearer NTRmYzBiYzJkZjc4ZTBhYjllNDkzYTVkZmIzMmJjNjc6OTc5NTZhMDUwNDcyNTgxNGM0ZDNkYTIwNjFjN2QzYmQ=',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End PDFCOLLAB ApiFlow API Group Code

/// Start GoogleSheet API Group Code

class GoogleSheetAPIGroup {
  static String getBaseUrl() =>
      'https://gw.apixflow.com/api/e4b8f0ebc66048d58e5e5e7883c118e9';
  static Map<String, String> headers = {
    'Authorization':
        'Bearer NTRmYzBiYzJkZjc4ZTBhYjllNDkzYTVkZmIzMmJjNjc6MjY2OGZhYWQ0NGE1NGYyZWE2ZmNmNTY2ODYzNzFhZTk=',
  };
  static ListSheet1RowsCall listSheet1RowsCall = ListSheet1RowsCall();
  static InsertNewRowInSheet1Call insertNewRowInSheet1Call =
      InsertNewRowInSheet1Call();
  static GetSheet1RowByIndexCall getSheet1RowByIndexCall =
      GetSheet1RowByIndexCall();
  static UpdateSheet1RowCall updateSheet1RowCall = UpdateSheet1RowCall();
  static RemoveSheet1RowByIndexCall removeSheet1RowByIndexCall =
      RemoveSheet1RowByIndexCall();
  static ListSheetRowsCall listSheetRowsCall = ListSheetRowsCall();
  static InsertNewRowCall insertNewRowCall = InsertNewRowCall();
  static GetSheetRowByIndexCall getSheetRowByIndexCall =
      GetSheetRowByIndexCall();
  static UpdateRowCall updateRowCall = UpdateRowCall();
  static ListAllSheetsCall listAllSheetsCall = ListAllSheetsCall();
  static FindSheetCall findSheetCall = FindSheetCall();
  static CreateNewSheetCall createNewSheetCall = CreateNewSheetCall();
}

class ListSheet1RowsCall {
  Future<ApiCallResponse> call({
    int? start,
    int? limit,
    String? search = '',
    String? columns = '',
    String? name = '',
    String? email = '',
    String? phone = '',
    String? address = '',
  }) async {
    final baseUrl = GoogleSheetAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'List Sheet1 rows',
      apiUrl: '${baseUrl}/sheets/0/rows',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer NTRmYzBiYzJkZjc4ZTBhYjllNDkzYTVkZmIzMmJjNjc6MjY2OGZhYWQ0NGE1NGYyZWE2ZmNmNTY2ODYzNzFhZTk=',
      },
      params: {
        'start': start,
        'limit': limit,
        'search': search,
        'columns': columns,
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class InsertNewRowInSheet1Call {
  Future<ApiCallResponse> call({
    String? sheet = 'sheet1',
    String? name = '',
    String? email = '',
    String? phone = '',
    String? address = '',
  }) async {
    final baseUrl = GoogleSheetAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "name": "${escapeStringForJson(name)}",
  "email": "${escapeStringForJson(email)}",
  "phone": "${escapeStringForJson(phone)}",
  "address": "${escapeStringForJson(address)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Insert new row in Sheet1',
      apiUrl: '${baseUrl}/sheets/sheet1/rows',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Bearer NTRmYzBiYzJkZjc4ZTBhYjllNDkzYTVkZmIzMmJjNjc6MjY2OGZhYWQ0NGE1NGYyZWE2ZmNmNTY2ODYzNzFhZTk=',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetSheet1RowByIndexCall {
  Future<ApiCallResponse> call({
    int? index,
  }) async {
    final baseUrl = GoogleSheetAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Get Sheet1 row by index',
      apiUrl: '${baseUrl}/sheets/0/rows/${index}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer NTRmYzBiYzJkZjc4ZTBhYjllNDkzYTVkZmIzMmJjNjc6MjY2OGZhYWQ0NGE1NGYyZWE2ZmNmNTY2ODYzNzFhZTk=',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateSheet1RowCall {
  Future<ApiCallResponse> call({
    int? index,
  }) async {
    final baseUrl = GoogleSheetAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "a": "test",
  "b": "test@mail.com",
  "c": "879519865",
  "d": "egazgrzah"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Update Sheet1 row',
      apiUrl: '${baseUrl}/sheets/0/rows/${index}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization':
            'Bearer NTRmYzBiYzJkZjc4ZTBhYjllNDkzYTVkZmIzMmJjNjc6MjY2OGZhYWQ0NGE1NGYyZWE2ZmNmNTY2ODYzNzFhZTk=',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class RemoveSheet1RowByIndexCall {
  Future<ApiCallResponse> call({
    int? index,
  }) async {
    final baseUrl = GoogleSheetAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Remove Sheet1 row by index',
      apiUrl: '${baseUrl}/sheets/0/rows/${index}',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization':
            'Bearer NTRmYzBiYzJkZjc4ZTBhYjllNDkzYTVkZmIzMmJjNjc6MjY2OGZhYWQ0NGE1NGYyZWE2ZmNmNTY2ODYzNzFhZTk=',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ListSheetRowsCall {
  Future<ApiCallResponse> call({
    String? sheet = '',
    int? start,
    int? limit,
    String? search = '',
  }) async {
    final baseUrl = GoogleSheetAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'List sheet rows',
      apiUrl: '${baseUrl}/sheets/${sheet}/rows',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer NTRmYzBiYzJkZjc4ZTBhYjllNDkzYTVkZmIzMmJjNjc6MjY2OGZhYWQ0NGE1NGYyZWE2ZmNmNTY2ODYzNzFhZTk=',
      },
      params: {
        'start': start,
        'limit': limit,
        'search': search,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class InsertNewRowCall {
  Future<ApiCallResponse> call({
    String? sheet = '',
  }) async {
    final baseUrl = GoogleSheetAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "a": "value",
  "b": "value",
  "c": "value",
  "d": "value",
  "e": "value",
  "f": "value",
  "g": "value"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Insert new row',
      apiUrl: '${baseUrl}/sheets/${sheet}/rows',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Bearer NTRmYzBiYzJkZjc4ZTBhYjllNDkzYTVkZmIzMmJjNjc6MjY2OGZhYWQ0NGE1NGYyZWE2ZmNmNTY2ODYzNzFhZTk=',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetSheetRowByIndexCall {
  Future<ApiCallResponse> call({
    String? sheet = '',
    int? index,
  }) async {
    final baseUrl = GoogleSheetAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Get sheet row by index',
      apiUrl: '${baseUrl}/sheets/${sheet}/rows/${index}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer NTRmYzBiYzJkZjc4ZTBhYjllNDkzYTVkZmIzMmJjNjc6MjY2OGZhYWQ0NGE1NGYyZWE2ZmNmNTY2ODYzNzFhZTk=',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateRowCall {
  Future<ApiCallResponse> call({
    String? sheet = '',
    int? index,
  }) async {
    final baseUrl = GoogleSheetAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "a": "value",
  "b": "value",
  "c": "value",
  "d": "value",
  "e": "value",
  "f": "value",
  "g": "value"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Update row',
      apiUrl: '${baseUrl}/sheets/${sheet}/rows/${index}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization':
            'Bearer NTRmYzBiYzJkZjc4ZTBhYjllNDkzYTVkZmIzMmJjNjc6MjY2OGZhYWQ0NGE1NGYyZWE2ZmNmNTY2ODYzNzFhZTk=',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ListAllSheetsCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = GoogleSheetAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'List all sheets',
      apiUrl: '${baseUrl}/sheets/list',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer NTRmYzBiYzJkZjc4ZTBhYjllNDkzYTVkZmIzMmJjNjc6MjY2OGZhYWQ0NGE1NGYyZWE2ZmNmNTY2ODYzNzFhZTk=',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FindSheetCall {
  Future<ApiCallResponse> call({
    String? title = '',
  }) async {
    final baseUrl = GoogleSheetAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Find sheet',
      apiUrl: '${baseUrl}/sheets/find',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer NTRmYzBiYzJkZjc4ZTBhYjllNDkzYTVkZmIzMmJjNjc6MjY2OGZhYWQ0NGE1NGYyZWE2ZmNmNTY2ODYzNzFhZTk=',
      },
      params: {
        'title': title,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateNewSheetCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = GoogleSheetAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "title": "Sheet title",
  "headers": [
    ""
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Create new sheet',
      apiUrl: '${baseUrl}/sheets/create',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Bearer NTRmYzBiYzJkZjc4ZTBhYjllNDkzYTVkZmIzMmJjNjc6MjY2OGZhYWQ0NGE1NGYyZWE2ZmNmNTY2ODYzNzFhZTk=',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End GoogleSheet API Group Code

class ChatbotCall {
  static Future<ApiCallResponse> call({
    String? apiKey = 'AIzaSyDDIsEao_5f7X7q7SRR0U5c777cwqhk3oc',
    String? prompt = '',
  }) async {
    final ffApiRequestBody = '''
{
  "contents": [
    {
      "parts": [
        {
          "text": "${escapeStringForJson(prompt)}"
        }
      ]
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Chatbot',
      apiUrl:
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=${apiKey}',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? apiReponse(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.candidates[:].content.parts[:].text''',
      ));
}

class AskOpenAICall {
  static Future<ApiCallResponse> call({
    String? prompt = '',
  }) async {
    final ffApiRequestBody = '''
{
  "model": "gpt-3.5-turbo",
  "messages": [
    {
      "role": "user",
      "content": "${escapeStringForJson(prompt)}"
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'AskOpenAI',
      apiUrl: 'https://api.openai.com/v1/chat/completions',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer  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',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic airesponse(dynamic response) => getJsonField(
        response,
        r'''$.choices[0].message.content''',
      );
}

class MedicamentCall {
  static Future<ApiCallResponse> call({
    String? medicine = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'medicament',
      apiUrl:
          'https://api.fda.gov/drug/label.json?search=openfda.brand_name:${medicine}&limit=1',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PdfCall {
  static Future<ApiCallResponse> call({
    String? patient = '',
    String? doctor = '',
    String? date = '',
    String? medicine = '',
    String? dosage = '',
    String? frequency = '',
    String? duration = '',
  }) async {
    final ffApiRequestBody = '''
{
  "document": {
    "document_template_id": "F8EDA830-BD27-456F-8BA5-F16520D4C363",
    "payload": {
      "patient": "${escapeStringForJson(patient)}",
      "doctor": "${escapeStringForJson(doctor)}",
      "date": "${escapeStringForJson(date)}",
      "medicine": "${escapeStringForJson(medicine)}",
      "dosage": "${escapeStringForJson(dosage)}",
      "frequency": "${escapeStringForJson(frequency)}",
      "duration": "${escapeStringForJson(duration)}"
    }
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'pdf',
      apiUrl: 'https://api.pdfmonkey.io/api/v1/documents',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ZsZC51dPwZDzfQg8saF31yt7fqsvyquW',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class StripPaymentCall {
  static Future<ApiCallResponse> call({
    String? amount = '',
    String? currency = '',
    String? description = '',
    List<String>? paymentMethodTypesList,
  }) async {
    final paymentMethodTypes = _serializeList(paymentMethodTypesList);

    return ApiManager.instance.makeApiCall(
      callName: 'StripPayment',
      apiUrl: 'https://api.stripe.com/v1/payment_intents',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Bearer sk_test_51SeOuHFUrlRetoI0FoRz6rhcmiuOVm7d78iGy0i0T6gAU2pUEOHdgt6GtZsr7bk7Ogcv2njpdHABiKHoEVf5kD2a007uCVvcwc',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      params: {
        'amount': amount,
        'currency': currency,
        'description': description,
        'payment_method_types[]': "card",
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UploadToImgbbCall {
  static Future<ApiCallResponse> call({
    FFUploadedFile? image,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Upload to Imgbb',
      apiUrl:
          'https://api.imgbb.com/1/upload?key=ce4dd110ef3187eb3ad9023fac5a5126',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'image': image,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic imageURL(dynamic response) => getJsonField(
        response,
        r'''$.data.url''',
      );
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
