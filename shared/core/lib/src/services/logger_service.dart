import 'package:flutter/cupertino.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
  fatal;

  int get priority {
    switch (this) {
      case LogLevel.debug:
        return 0;
      case LogLevel.info:
        return 1;
      case LogLevel.warning:
        return 2;
      case LogLevel.error:
        return 3;
      case LogLevel.fatal:
        return 4;
    }
  }
}

abstract class LoggerService {
  void debug(String message, [dynamic error, StackTrace? stackTrace]);
  void info(String message, [dynamic error, StackTrace? stackTrace]);
  void warning(String message, [dynamic error, StackTrace? stackTrace]);
  void error(String message, [dynamic error, StackTrace? stackTrace]);
  void fatal(String message, [dynamic error, StackTrace? stackTrace]);
  void log(
    LogLevel level,
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]);
}

class ConsoleLogger implements LoggerService {
  final LogLevel _minLevel;
  final bool _showTimestamp;
  final bool _showLevel;

  const ConsoleLogger({
    LogLevel minLevel = LogLevel.debug,
    bool showTimestamp = true,
    bool showLevel = true,
  }) : _minLevel = minLevel,
       _showTimestamp = showTimestamp,
       _showLevel = showLevel;

  @override
  void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    log(LogLevel.debug, message, error, stackTrace);
  }

  @override
  void info(String message, [dynamic error, StackTrace? stackTrace]) {
    log(LogLevel.info, message, error, stackTrace);
  }

  @override
  void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    log(LogLevel.warning, message, error, stackTrace);
  }

  @override
  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    log(LogLevel.error, message, error, stackTrace);
  }

  @override
  void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    log(LogLevel.fatal, message, error, stackTrace);
  }

  @override
  void log(LogLevel level, String message, [error, StackTrace? stackTrace]) {
    if (level.priority < _minLevel.priority) return;
    final buffer = StringBuffer();

    if (_showTimestamp) {
      buffer.write('[${DateTime.now().toIso8601String()}] ');
    }
    if (_showLevel) {
      buffer.write('[${level.name.toUpperCase()}] ');
    }

    buffer.write(message);

    if (error != null) {
      buffer.write('\nError: $error');
    }

    if (stackTrace != null) {
      buffer.write('\nStackTrace: $stackTrace');
    }

    debugPrint(buffer.toString());
  }
}
