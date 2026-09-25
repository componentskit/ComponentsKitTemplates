import ComponentsKit
import SwiftUI

// MARK: - ViewModel

@Observable
class SettingsVM {
  enum Cell {
    case email
    case phoneNumber
    case language
    case notifications
    case securityAndPrivacy
    case manageSubscriptions
    case support
    case resources
  }
  
  struct Section: Hashable {
    let title: String
    let cells: [Cell]
  }
  
  let setupProgress: CGFloat = 75
  let sections = [
    Section(
      title: "details",
      cells: [
        .email,
        .phoneNumber,
        .language,
      ]
    ),
    Section(
      title: "general",
      cells: [
        .notifications,
        .securityAndPrivacy,
        .manageSubscriptions,
        .support,
        .resources,
      ]
    )
  ]
  
  var isProgressBannerVisible: Bool {
    return setupProgress < 100
  }
  
  func cellVM(for cell: Cell) -> SettingsCellVM {
    switch cell {
    case .email:
      return .init(title: "Email", value: "kenzi.lawson@example.com")
    case .phoneNumber:
      return .init(title: "Phone Number", value: "(201) 555-0124")
    case .language:
      return .init(title: "Language", value: "English")
    case .notifications:
      return .init(title: "Notifications", value: nil)
    case .securityAndPrivacy:
      return .init(title: "Security & Privacy", value: nil)
    case .manageSubscriptions:
      return .init(title: "Manage Subscriptions", value: nil)
    case .support:
      return .init(title: "Support", value: nil)
    case .resources:
      return .init(title: "Resources", value: nil)
    }
  }
  
  func didTapProgressBannerCell() {
    /* handle progress banner tap */
  }
  
  func didTapCell(_ cell: Cell) {
    switch cell {
    case .email:
      /* handle email cell tap */
      break
    case .phoneNumber:
      /* handle phoneNumber cell tap */
      break
    case .language:
      /* handle language cell tap */
      break
    case .notifications:
      /* handle notifications cell tap */
      break
    case .securityAndPrivacy:
      /* handle securityPrivacy cell tap */
      break
    case .manageSubscriptions:
      /* handle manageSubscriptions cell tap */
      break
    case .support:
      /* handle support cell tap */
      break
    case .resources:
      /* handle resources cell tap */
      break
    }
  }
}

// MARK: - View

struct Settings: View {
  let model = SettingsVM()
  let bottomGradientOverlayHeight: CGFloat = 60
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack {
      ScrollView(showsIndicators: false) {
        LazyVStack(alignment: .leading, spacing: 32) {
          if model.isProgressBannerVisible {
            ProgressBanner(
              progress: model.setupProgress,
              onTap: model.didTapProgressBannerCell
            )
          }
          
          ForEach(model.sections, id: \.self) { section in
            VStack(alignment: .leading, spacing: 8) {
              Text(section.title.uppercased())
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
        .padding(.bottom, bottomGradientOverlayHeight)
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
            },
            action: { dismiss() }
          )
        }
      }
      .navigationBarTitleDisplayMode(.inline)
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
    .frame(height: bottomGradientOverlayHeight)
  }
}
