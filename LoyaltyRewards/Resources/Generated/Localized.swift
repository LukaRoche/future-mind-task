// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localized {
  /// Share invite code
  internal static let dashboardBottomBannerButtonTitle = Localized.tr("Localizable", "dashboard-bottom-banner-button-title")
  /// Share our app with others and get extra points!
  internal static let dashboardBottomBannerMessage = Localized.tr("Localizable", "dashboard-bottom-banner-message")
  /// Need more points?
  internal static let dashboardBottomBannerTitle = Localized.tr("Localizable", "dashboard-bottom-banner-title")
  /// points
  internal static let dashboardPointsSuffix = Localized.tr("Localizable", "dashboard-points-suffix")
  /// Redeem points for exclusive rewards
  internal static let dashboardReedemPointsMessage = Localized.tr("Localizable", "dashboard-reedem-points-message")
  /// Rewards
  internal static let dashboardTitle = Localized.tr("Localizable", "dashboard-title")
  /// Welcome to the Club!
  internal static let dashboardWelcomeSubtitle = Localized.tr("Localizable", "dashboard-welcome-subtitle")
  /// Hi, %@
  internal static func dashboardWelcomeTitle(_ p1: Any) -> String {
    return Localized.tr("Localizable", "dashboard-welcome-title", String(describing: p1))
  }
  /// Ok
  internal static let errorAlertCloseButtonTitle = Localized.tr("Localizable", "error-alert-close-button-title")
  /// Something went wrong
  internal static let errorAlertTitle = Localized.tr("Localizable", "error-alert-title")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localized {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
