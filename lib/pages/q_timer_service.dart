import 'package:shared_preferences/shared_preferences.dart';

// This is a global function to continue the lives cooldown timer even if LivesTimerPage is exited
class LivesTimerService {
  static const int maxLives = 5;
  static const int refillDuration = 300000; // 5 minutes

  // Get current hearts
  static Future<int> getHearts() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('currentHearts') ?? maxLives;
  }

  // Update hearts
  static Future<void> setHearts(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentHearts', value);
  }

  // Start cooldown when hearts reach 0
  static Future<void> startCooldown() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
      'heartsResetTime',
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  // Get remaining time
  static Future<int> getRemainingTime() async {
    final prefs = await SharedPreferences.getInstance();

    int? resetTime = prefs.getInt('heartsResetTime');
    if (resetTime == null) return 0;

    int now = DateTime.now().millisecondsSinceEpoch;
    int elapsed = now - resetTime;

    int remaining = refillDuration - elapsed;

    if (remaining <= 0) {
      await refillHearts();
      return 0;
    }

    return remaining;
  }

  // Reset lives after timer
  static Future<void> refillHearts() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('currentHearts', 5);
    await prefs.remove('heartsResetTime');
  }

  // Add hearts when purchased from shop
  static Future<void> addHearts(int amount) async {
    final prefs = await SharedPreferences.getInstance();

    int current = prefs.getInt('currentHearts') ?? maxLives;
    int purchased = prefs.getInt('totalPurchasedHearts') ?? 0;

    int newHearts = (current + amount).clamp(0, 99);

    await prefs.setInt('currentHearts', newHearts);
    await prefs.setInt('totalPurchasedHearts', purchased + amount);

    // 🔥 IMPORTANT: cancel timer if user buys hearts
    await prefs.remove('heartsResetTime');
  }
}