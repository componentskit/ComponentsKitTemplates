import ComponentsKit
import SwiftUI

// MARK: - ViewModel

@Observable
class ProfileVM {
  struct Section: Hashable {
    enum Cell: Hashable {
      case info(title: String, value: String)
      case uid
      case language
      case notifications
      
      var title: String {
        switch self {
        case .info(let title, _):
          return title
        case .uid:
          return "UID"
        case .language:
          return "Language"
        case .notifications:
          return "App Notifications"
        }
      }
    }
    
    let title: String
    let cells: [Cell]
  }
  
  let uid = "5957989479231239417"
  var selectedLanguage: String = "English"
  var isNotificationsEnabled: Bool = false
  var hasRecentlyCopiedText: Bool = false
  
  let sections = [
    Section(
      title: "Details",
      cells: [
        .info(title: "USERNAME", value: "Esther Howard"),
        .info(title: "PHONE NUMBER", value: "(201) 555-0124"),
        .info(title: "EMAIL", value: "kenzi.lawson@example.com"),
        .info(title: "ADDRESS", value: "775 Rolling Green Rd"),
        .uid
      ]
    ),
    Section(
      title: "Preferences",
      cells: [
        .language,
        .notifications,
      ]
    ),
  ]
  
  let bottomGradientOverlayHeight: CGFloat = 60
  
  func didTapUidCell() {
    guard !hasRecentlyCopiedText else { return }
    
    UIPasteboard.general.string = uid
    hasRecentlyCopiedText = true
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
      self.hasRecentlyCopiedText = false
    }
  }
  
  func didTapInfoCell() {
    /* handle info cell tap */
  }
  
  func didTapLanguageCell() {
    /* handle language cell tap */
  }
  
  func didTapNotificationsCell() {
    isNotificationsEnabled.toggle()
  }
}

// MARK: - View

struct Profile: View {
  @Bindable var model = ProfileVM()
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack {
      ScrollView(showsIndicators: false) {
        LazyVStack(alignment: .leading, spacing: 32) {
          ForEach(model.sections, id: \.self) { section in
            VStack(alignment: .leading, spacing: 8) {
              sectionHeader(section.title)
              
              ForEach(section.cells, id: \.self) { cell in
                cellView(for: cell)
              }
            }
          }
        }
        .padding(.bottom, model.bottomGradientOverlayHeight)
      }
      .overlay(alignment: .bottom, content: { bottomGradientOverlay })
      .frame(maxWidth: .infinity)
      .padding()
      .background(UniversalColor.background.color)
      .toolbar {
        ToolbarItem(placement: .principal) {
          Text("Profile")
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
  
  // MARK: CellView
  
  @ViewBuilder
  func cellView(for cell: ProfileVM.Section.Cell) -> some View {
    switch cell {
    case let .info(title, value):
      DetailsCell(
        model: .init(title: title, value: value, action: .edit),
        onTap: model.didTapInfoCell
      )
      
    case .uid:
      DetailsCell(
        model: .init(
          title: cell.title,
          value: model.uid,
          action: .copy(isCopied: model.hasRecentlyCopiedText)
        ),
        onTap: model.didTapUidCell
      )
      
    case .language:
      PreferencesCell(
        title: cell.title,
        content: {
          Text(model.selectedLanguage)
            .foregroundStyle(UniversalColor.secondaryForeground.color)
            .font(UniversalFont.mdBody.font)
          
          Image(systemName: "chevron.right")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 15, height: 15)
            .foregroundStyle(UniversalColor.secondaryForeground.color)
        },
        onTap: model.didTapLanguageCell
      )
      
    case .notifications:
      PreferencesCell(
        title: cell.title,
        content: {
          Toggle("", isOn: .constant(model.isNotificationsEnabled))
            .tint(UniversalColor.accent.color)
        },
        onTap: model.didTapNotificationsCell
      )
    }
  }
  
  // MARK: SectionHeader
  
  func sectionHeader(_ text: String) -> some View {
    Text(text)
      .foregroundStyle(UniversalColor.foreground.color)
      .font(UniversalFont.lgHeadline.font)
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
