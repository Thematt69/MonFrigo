abstract class AppBreakpoint {
  static const smallBreakpoint = 768.0;
  static const mediumBreakpoint = 1024.0;

  static bool isSmall(double width) => width < smallBreakpoint;
  static bool isMedium(double width) => width < mediumBreakpoint;
  static bool isLarge(double width) => !isSmall(width) && !isMedium(width);
}
