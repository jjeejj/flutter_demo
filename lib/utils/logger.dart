import 'package:logger/logger.dart';

class LoggerHelper {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2,
        // Number of method calls to be displayed
        errorMethodCount: 8,
        // Number of method calls if stacktrace is provided
        lineLength: 120,
        // Width of the output
        colors: true,
        // Colorful log messages
        printEmojis: true,
        // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );

  static void d(
    String message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.d(message);
  }

  static void i(
    String message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.i(message);
  }

  static void w(
    String message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.w(message);
  }

  static void e(
    String message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.e(message, stackTrace: stackTrace, time: time, error: error);
  }

  static void log(
    Level level,
    String message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.log(level, message, time: time, error: error, stackTrace: stackTrace);
  }
}
