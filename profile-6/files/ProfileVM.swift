import SwiftUI

@Observable
class ProfileVM {
  enum Cell: Hashable {
    enum ProgressBanner {
      case identityVerification
      case securityLevel
    }
    enum Destination {
      case nickname
      case country
      case connectedAccounts
      case switchAccounts
      case logout
      case email
      case phoneNumber
      case passkeys
      case authenticatorApp
      case loginPassword
      case deviceManagement
      case language
      case currency
      case appearance
      case chatPreferences
    }
    enum Copy {
      case uid
    }
    enum Toggle {
      case hapticFeedback
    }
    enum Notification {
      case everything
      case essentials
      case basics
    }
    
    case progressBanner(ProgressBanner)
    case destination(Destination)
    case copy(Copy)
    case toggle(Toggle)
    case notification(Notification)
  }
  
  struct Section: Hashable {
    let title: String?
    let cells: [Cell]
    let spacing: CGFloat
  }
  
  enum Page: CaseIterable {
    case profile
    case security
    case preferences
    case notifications
    
    var title: String {
      switch self {
      case .profile:
        return "Profile"
      case .security:
        return "Security"
      case .preferences:
        return "Preferences"
      case .notifications:
        return "Notifications"
      }
    }
  }
  
  var selectedPage: Page = .profile
  var selectedNotificationType: Cell.Notification = .essentials
  var hasRecentlyCopiedText: Bool = false
  var isHapticFeedbackEnabled: Bool = false
  let uid: String = "5957989479231239417"
  let bottomGradientOverlayHeight: CGFloat = 60
  
  var currentSections: [Section] {
    switch selectedPage {
    case .profile:
      return [
        .init(
          title: nil,
          cells: [.progressBanner(.identityVerification)],
          spacing: 8
        ),
        .init(
          title: nil,
          cells: [
            .destination(.nickname),
            .destination(.country),
            .copy(.uid),
            .destination(.connectedAccounts),
            .destination(.switchAccounts),
            .destination(.logout)
          ],
          spacing: 8
        )
      ]
    case .security:
      return [
        .init(
          title: nil,
          cells: [.progressBanner(.securityLevel)],
          spacing: 8
        ),
        .init(
          title: "Authentication",
          cells: [
            .destination(.email),
            .destination(.phoneNumber),
            .destination(.passkeys),
            .destination(.authenticatorApp),
            .destination(.loginPassword)
          ],
          spacing: 8
        ),
        .init(
          title: "Advanced security",
          cells: [
            .destination(.deviceManagement)
          ],
          spacing: 8
        )
      ]
    case .preferences:
      return [
        .init(
          title: nil,
          cells: [
            .destination(.language),
            .destination(.currency),
            .destination(.appearance),
            .destination(.chatPreferences),
            .toggle(.hapticFeedback)
          ],
          spacing: 8
        )
      ]
    case .notifications:
      return [
        .init(
          title: nil,
          cells: [
            .notification(.everything),
            .notification(.essentials),
            .notification(.basics)
          ],
          spacing: 12
        )
      ]
    }
  }
  
  func notificationsVM(for cell: Cell.Notification) -> NotificationCellVM {
    switch cell {
    case .everything:
      return .init(
        title: "Everything",
        subtitle: "Stay updated with every change, message, and system activity.",
        isSelected: selectedNotificationType == .everything
      )
    case .essentials:
      return .init(
        title: "Essentials",
        subtitle: "Receive key financial, administrative, and security alerts.",
        isSelected: selectedNotificationType == .essentials
      )
    case .basics:
      return .init(
        title: "Basics",
        subtitle: "Just the critical updates to keep you informed.",
        isSelected: selectedNotificationType == .basics
      )
    }
  }
  
  func progressBannerVM(for cell: Cell.ProgressBanner) -> ProgressBannerVM {
    switch cell {
    case .identityVerification:
      return .init(
        title: "Identity verification",
        value: "Verified",
        progressState: .completed
      )
    case .securityLevel:
      return .init(
        title: "Security Level",
        value: "Moderate",
        progressState: .incomplete(current: 3, total: 5)
      )
    }
  }
  
  func copyCellVM(for cell: Cell.Copy) -> CopyCellVM {
    switch cell {
    case .uid:
      return .init(
        title: "UID",
        value: uid,
        isCopied: hasRecentlyCopiedText
      )
    }
  }
  
  func toggleCellVM(for cell: Cell.Toggle) -> ToggleCellVM {
    switch cell {
    case .hapticFeedback:
      return .init(
        title: "Haptic Feedback",
        isOn: isHapticFeedbackEnabled
      )
    }
  }
  
  func destinationCellVM(for cell: Cell.Destination) -> DestinationCellVM {
    switch cell {
    case .nickname:
      return .init(title: "Nickname", value: "@eshoward")
    case .country:
      return .init(title: "Country/Region", value: "Russia")
    case .connectedAccounts:
      return .init(title: "Connected accounts", value: nil)
    case .switchAccounts:
      return .init(title: "Switch accounts", value: nil)
    case .logout:
      return .init(title: "Log Out", value: nil, style: .destructive)
    case .email:
      return .init(title: "Email", value: nil)
    case .phoneNumber:
      return .init(title: "Phone Number", value: "(201) 555-0124")
    case .passkeys:
      return .init(title: "Passkeys", value: nil)
    case .authenticatorApp:
      return .init(title: "Authenticator app", value: "Not set up")
    case .loginPassword:
      return .init(title: "Login password", value: nil)
    case .deviceManagement:
      return .init(title: "Device management", value: nil)
    case .language:
      return .init(title: "Language", value: "English")
    case .currency:
      return .init(title: "Currency", value: "USD")
    case .appearance:
      return .init(title: "Appearance", value: "System")
    case .chatPreferences:
      return .init(title: "Chat Preferences", value: nil)
    }
  }
  
  func didTapCopyCell(_ kind: Cell.Copy) {
    switch kind {
    case .uid:
      guard !hasRecentlyCopiedText else { return }
      UIPasteboard.general.string = uid
      hasRecentlyCopiedText = true
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
        self.hasRecentlyCopiedText = false
      }
    }
  }
  
  func didTapProgressBannerCell(_ kind: Cell.ProgressBanner) {
    /* handle progress banner tap */
  }
  
  func didTapDestinationCell(_ kind: Cell.Destination) {
    /* handle destination cell tap */
  }
  
  func didTapToggleCell(_ kind: Cell.Toggle) {
    switch kind {
    case .hapticFeedback:
      isHapticFeedbackEnabled.toggle()
    }
  }
  
  func didTapEditProfile() {
    /* handle edit profile button tap */
  }
}
