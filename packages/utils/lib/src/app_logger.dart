import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class SimpleLogPrinter extends LogPrinter {
  SimpleLogPrinter(
    this.className, {
    this.printCallStack = false,
    this.excludeLogsFromClasses = const [],
    this.showOnlyClass,
  });
  final String className;
  final bool printCallStack;
  final List<String> excludeLogsFromClasses;
  final String? showOnlyClass;

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.defaultLevelColors[event.level];
    final emoji = PrettyPrinter.defaultLevelEmojis[event.level];
    final methodName = _getMethodName();

    final methodNameSection = methodName != null || methodName?.trim() != '| Error' ? ' | $methodName' : '';

    final methodNameValue = methodNameSection.contains('ror') ? '' : methodNameSection;
    final stackLog = event.stackTrace.toString();
    final output =
        '''$emoji $className$methodNameValue - ${event.message}${event.error != null ? '\nERROR: ${event.error}\n' : ''}${printCallStack ? '\nSTACKTRACE:\n$stackLog' : ''}''';

    if (excludeLogsFromClasses.any((excludeClass) => className == excludeClass) ||
        (showOnlyClass != null && className != showOnlyClass)) {
      return [];
    }

    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    final result = <String>[];

    for (final line in output.split('\n')) {
      result.addAll(
        pattern.allMatches(line).map((match) {
          if (kReleaseMode) {
            return match.group(0)!;
          } else {
            return color!(match.group(0)!);
          }
        }),
      );
    }

    return result;
  }

  String? _getMethodName() {
    try {
      final currentStack = StackTrace.current;
      final formattedStacktrace = _formatStackTrace(currentStack, 3);
      if (kIsWeb) {
        final classNameParts = _splitClassNameWords(className);
        if (formattedStacktrace == null) return null;
        return _findMostMatchedTrace(formattedStacktrace, classNameParts).split(' ').last;
      } else {
        final realFirstLine = formattedStacktrace?.firstWhere((line) => line.contains(className), orElse: () => '');

        final methodName = realFirstLine?.replaceAll('$className.', '');
        return methodName;
      }
    } catch (e) {
      // There's no deliberate function call from our code so we return null;
      return null;
    }
  }

  List<String> _splitClassNameWords(String className) {
    return className.split(RegExp('(?=[A-Z])')).map((e) => e.toLowerCase()).toList();
  }

  /// Note: If the faulty word exists at the beginning,
  /// this method may not be very useful.
  String _findMostMatchedTrace(List<String> stackTraces, List<String> keyWords) {
    var match = stackTraces.firstWhere((trace) => _doesTraceContainsAllKeywords(trace, keyWords), orElse: () => '');
    if (match.isEmpty) {
      match = _findMostMatchedTrace(stackTraces, keyWords.sublist(0, keyWords.length - 1));
    }
    return match;
  }

  bool _doesTraceContainsAllKeywords(String stackTrace, List<String> keywords) {
    final formattedKeywordsAsRegex = RegExp(keywords.join('.*'));
    return stackTrace.contains(formattedKeywordsAsRegex);
  }
}

final stackTraceRegex = RegExp(r'#[0-9]+[\s]+(.+) \(([^\s]+)\)');

List<String>? _formatStackTrace(StackTrace stackTrace, int methodCount) {
  final lines = stackTrace.toString().split('\n');

  final formatted = <String>[];
  var count = 0;
  for (final line in lines) {
    final match = stackTraceRegex.matchAsPrefix(line);
    if (match != null) {
      if (match.group(2)!.startsWith('package:logger')) {
        continue;
      }
      final newLine = '${match.group(1)}';
      formatted.add(newLine.replaceAll('<anonymous closure>', '()'));
      if (++count == methodCount) {
        break;
      }
    } else {
      formatted.add(line);
    }
  }

  if (formatted.isEmpty) {
    return null;
  } else {
    return formatted;
  }
}

class CustomDevelopmentFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}

LogOutput? output;

void setupLogOutputs(List<LogOutput> additionalOutputs) {
  const showLogsInRelease = kReleaseMode;
  // Show only console logs in debug mode and all logs in release mode
  output = MultiOutput([if (!showLogsInRelease) ConsoleOutput(), if (showLogsInRelease) ...additionalOutputs]);
}

Logger getLogger(String className, {List<String> excludeLogsFromClasses = const [], String? showOnlyClass}) {
  return Logger(
    filter: CustomDevelopmentFilter(),
    printer: SimpleLogPrinter(className, showOnlyClass: showOnlyClass, excludeLogsFromClasses: excludeLogsFromClasses),
    output: output,
  );
}
