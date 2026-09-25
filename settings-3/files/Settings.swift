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
        return "settings"
      case .notifications:
        return "notifications"
      case .writeReview:
        return "notes"
      case .restoreSubscriptions:
        return "money"
      case .contactSupport:
        return "messages"
      case .privacyPolicy:
        return "shield-user"
      case .termsOfService:
        return "document-text"
      case .privacyPreferences:
        return "lock-keyhole"
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
      title: "General",
      cells: [
        .preferences,
        .notifications,
        .writeReview,
        .restoreSubscriptions,
        .contactSupport
      ]
    ),
    Section(
      title: "Legal",
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
      email: "kenzi.lawson@example.com",
      avatarSrc: .local(.init("avatar"))
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
  
  func didTapStartTrial() {
    /* handle start trial button tap */
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
        LazyVStack(alignment: .leading, spacing: 0) {
          userInfoSection
          bannerSection
            .padding(.top, 16)
            .padding(.bottom, 24)
          mainSections
        }
        .padding(.top, 8)
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
  
  // MARK: UserInfo
  
  var userInfoSection: some View {
    SUCard(
      model: .sectionCard.updating {
        $0.animationScale = .small
        $0.isTappable = true
        $0.contentPaddings = .init(top: 8, leading: 8, bottom: 8, trailing: 16)
      },
      content: {
        UserInfo(model: model.userInfoVM)
      },
      onTap: model.didTapProfile
    )
  }
  
  // MARK: MainSections
  
  var mainSections: some View {
    ForEach(model.sections, id: \.self) { section in
      Text(section.title)
        .foregroundStyle(UniversalColor.foreground.color)
        .font(UniversalFont.lgHeadline.font)
        .padding(.bottom, 12)
      
      SUCard(model: .sectionCard) {
        VStack(spacing: 16) {
          ForEach(section.cells, id: \.self) { cell in
            SettingsCell(
              model: model.cellVM(for: cell),
              onTap: { model.didTapCell(cell) }
            )
          }
        }
      }
      .padding(.bottom, 24)
    }
  }
  
  // MARK: BannerSection
  
  var bannerSection: some View {
    SUCard(model: .sectionCard.updating {
      $0.contentPaddings = .init(top: 4, leading: 20, bottom: 4, trailing: 4)
    }) {
      HStack {
        VStack(alignment: .leading, spacing: 16) {
          Text("Get access to Pro features")
            .foregroundStyle(UniversalColor.foreground.color)
            .font(UniversalFont.lgHeadline.font)
          
          SUButton(
            model: .init {
              $0.title = "Try Pro Now"
              $0.color = .accent
              $0.size = .small
            },
            action: model.didTapStartTrial
          )
        }
        Spacer()
        ZStack(alignment: .bottomTrailing) {
          Image("banner-img-bg")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(UniversalColor.accentBackground.color)
            .frame(height: 132)
            .cornerRadius(ContainerRadius.medium.value)
          
          Image("banner-img-icon")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(UniversalColor.accent.color)
            .frame(height: 80)
            .padding(24)
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
