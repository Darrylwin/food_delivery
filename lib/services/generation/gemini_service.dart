import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static const String _apiKey = 'AIzaSyCmL57_FlOlX2TQzD_ub8TE01J0S6ou5R8';
  final model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: _apiKey,
  );
  DateTime? _lastRequestTime;
  static const int _minDelayMs = 3000; // Augmenté à 3 secondes

  Future<DeliveryMessages> generateAllMessages({
    required String restaurant,
    required List<String> items,
  }) async {
    try {
      //on verifie le délai de chaque requete
      if (_lastRequestTime != null) {
        final difference = DateTime.now().difference(_lastRequestTime!);
        if (difference.inMilliseconds < _minDelayMs) {
          await Future.delayed(
              Duration(milliseconds: _minDelayMs - difference.inMilliseconds));
        }
      }

      _lastRequestTime = DateTime.now();

      // Créer une description concise des items
      final itemSummary = items.length == 1
          ? items.first
          : "${items.first} and ${items.length - 1} other item${items.length > 2 ? 's' : ''}";

      final prompt = """
        Generate 4 short messages for a food delivery app:
        1. System notification title (max 20 chars)
        2. System notification body (max 30 chars)
        3. Notification tile title (max 20 chars)
        4. Notification tile description (max 30 chars)

        Context:
        - Restaurant: $restaurant
        - Ordered items: $itemSummary

        Format response exactly as:
        SYSTITLE: [your text]
        SYSBODY: [your text]
        TILETITLE: [your text]
        TILEDESC: [your text]
      """;

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      final text = response.text ?? "";

      return _parseMessages(text, restaurant);
    } catch (e) {
      print("Error generating message: $e");
      if (e.toString().contains('Quota exceeded')) {
        // Attendre plus longtemps en cas d'erreur de quota
        await Future.delayed(const Duration(seconds: 5));
        // Réessayer une fois
        return generateAllMessages(restaurant: restaurant, items: items);
      }
      return _getDefaultMessages(restaurant);
    }
  }

  DeliveryMessages _parseMessages(String text, String restaurant) {
    final lines = text.split('\n');
    var messages = _getDefaultMessages(restaurant);

    for (var line in lines) {
      if (line.startsWith('SYSTITLE:')) {
        messages.systemTitle = line.replaceFirst('SYSTITLE:', '').trim();
      } else if (line.startsWith('SYSBODY:')) {
        messages.systemBody = line.replaceFirst('SYSBODY:', '').trim();
      } else if (line.startsWith('TILETITLE:')) {
        messages.tileTitle = line.replaceFirst('TILETITLE:', '').trim();
      } else if (line.startsWith('TILEDESC:')) {
        messages.tileDescription = line.replaceFirst('TILEDESC:', '').trim();
      }
    }

    return messages;
  }

  DeliveryMessages _getDefaultMessages(String restaurant) {
    return DeliveryMessages(
        systemTitle: 'Order Confirmed',
        systemBody: 'Your order is on the way',
        tileTitle: 'New Order',
        tileDescription: 'From $restaurant');
  }
}

class DeliveryMessages {
  String systemTitle;
  String systemBody;
  String tileTitle;
  String tileDescription;

  DeliveryMessages({
    required this.systemTitle,
    required this.systemBody,
    required this.tileTitle,
    required this.tileDescription,
  });
}
