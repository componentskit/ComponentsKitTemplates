import ComponentsKit
import SwiftUI

// MARK: - ViewModel

@Observable
class SettingsVM {
  enum Cell: Hashable {
    case preferences
    case notifications
    case writeReview
    case restoreSubscriptions
    case contactSupport
    case privacyPolicy
    case termsOfService
    case privacyPreferences
    
    var title: String {
      switch self {
      case .preferences:
        return "Preferences"
      case .notifications:
        return "Notifications"
      case .writeReview:
        return "Write a Review"
      case .restoreSubscriptions:
        return "Restore Subscriptions"
      case .contactSupport:
        return "Contact Support"
      case .privacyPolicy:
        return "Privacy Policy"
      case .termsOfService:
        return "Terms of Service"
      case .privacyPreferences:
        return "Privacy Preferences"
      }
    }
    
    var icon: String {
      switch self {
      case .preferences:
        return "settings/second/settings"
      case .notifications:
        return "settings/second/notifications"
      case .writeReview:
        return "settings/second/notes"
      case .restoreSubscriptions:
        return "settings/second/money"
      case .contactSupport:
        return "settings/second/messages"
      case .privacyPolicy:
        return "settings/second/shield-user"
      case .termsOfService:
        return "settings/second/document-text"
      case .privacyPreferences:
        return "settings/second/lock-keyhole"
      }
    }
    
    var endIcon: String? {
      switch self {
      case .preferences, .notifications, .privacyPreferences:
        return "chevron.right"
      case .writeReview, .privacyPolicy, .termsOfService:
        return "arrowshape.turn.up.forward"
      case .restoreSubscriptions, .contactSupport:
        return nil
      }
    }
  }
  
  struct Section: Hashable {
    let title: String
    let cells: [Cell]
  }
  
  let sections: [Section] = [
    Section(
      title: "GENERAL",
      cells: [
        .preferences,
        .notifications,
        .writeReview,
        .restoreSubscriptions,
        .contactSupport
      ]
    ),
    Section(
      title: "LEGAL",
      cells: [
        .privacyPolicy,
        .termsOfService,
        .privacyPreferences
      ]
    )
  ]
  
  let bottomGradientOverlayHeight: CGFloat = 60
  
  var userInfoVM: UserInfoVM {
    return .init(
      name: "Esther Howard",
      email: "kenzi.lawson@example.com",
      avatarSrc: .local(.init("settings/second/avatar"))
    )
  }
  
  func cellVM(for cell: Cell) -> SettingsCellVM {
    SettingsCellVM(
      title: cell.title,
      icon: cell.icon,
      endIcon: cell.endIcon
    )
  }
  
  func didTapProfile() {
    /* handle edit profile button tap */
  }
  
  func didTapCell(_ cell: Cell) {
    switch cell {
    case .preferences:
      /* handle preferences cell tap */
      break
    case .notifications:
      /* handle notifications cell tap */
      break
    case .writeReview:
      /* handle writeReview cell tap */
      break
    case .privacyPolicy:
      /* handle privacyPolicy cell tap */
      break
    case .termsOfService:
      /* handle termsOfService cell tap */
      break
    default:
      break
    }
  }
}

// MARK: - View

struct Settings: View {
  let model = SettingsVM()
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack {
      ScrollView(showsIndicators: false) {
        LazyVStack(alignment: .leading, spacing: 40) {
          UserInfoSection(
            model: model.userInfoVM,
            onTap: model.didTapProfile
          )
          mainSections
        }
        .padding(.top, 16)
        .padding(.bottom, model.bottomGradientOverlayHeight)
      }
      .overlay(alignment: .bottom, content: { bottomGradientOverlay })
      .frame(maxWidth: .infinity)
      .padding()
      .background(UniversalColor.background.color)
      .toolbar {
        ToolbarItem(placement: .principal) {
          Text("Settings")
            .foregroundStyle(UniversalColor.foreground.color)
            .font(UniversalFont.mdHeadline.font)
        }
        ToolbarItem(placement: .navigationBarLeading) {
          SUButton(
            model: .init {
              $0.image = .init(systemName: "chevron.left")
              $0.color = .accent
              $0.style = .minimal
              $0.size = .large
            },
            action: { dismiss() }
          )
        }
      }
      .navigationBarTitleDisplayMode(.inline)
    }
  }
  
  // MARK: MainSections
  
  @ViewBuilder
  var mainSections: some View {
    ForEach(model.sections, id: \.self) { section in
      VStack(alignment: .leading, spacing: 16) {
        Text(section.title)
          .foregroundStyle(UniversalColor.secondaryForeground.color)
          .font(UniversalFont.smHeadline.font)
        
        ForEach(section.cells, id: \.self) { cell in
          SettingsCell(
            model: model.cellVM(for: cell),
            onTap: { model.didTapCell(cell) }
          )
        }
      }
    }
  }
  
  // MARK: BottomGradientOverlay
  
  var bottomGradientOverlay: some View {
    LinearGradient(
      gradient: Gradient(colors: [
        Color.clear,
        UniversalColor.background.color,
      ]),
      startPoint: .top,
      endPoint: .bottom
    )
    .frame(height: model.bottomGradientOverlayHeight)
  }
}
