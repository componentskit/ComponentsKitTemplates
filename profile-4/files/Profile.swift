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
      title: "DETAILS",
      cells: [
        .info(title: "Username", value: "Esther Howard"),
        .info(title: "Phone Number", value: "(201) 555-0124"),
        .info(title: "Email", value: "kenzi.lawson@example.com"),
        .info(title: "Address", value: "775 Rolling Green Rd"),
        .uid
      ]
    ),
    Section(
      title: "PREFERENCES",
      cells: [
        .language,
        .notifications,
      ]
    ),
  ]
  
  let bottomGradientOverlayHeight: CGFloat = 60
  
  func didTapCell(_ cell: Section.Cell) {
    switch cell {
    case .uid:
      guard !hasRecentlyCopiedText else { return }
      
      UIPasteboard.general.string = uid
      hasRecentlyCopiedText = true
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
        self.hasRecentlyCopiedText = false
      }
      
    case .notifications:
      isNotificationsEnabled.toggle()
      
    case .info:
      /* handle info cell tap */
      break
      
    case .language:
      /* handle language cell tap */
      break
    }
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
                ProfileCell(
                  title: cell.title,
                  content: { cellContent(for: cell) },
                  onTap: { model.didTapCell(cell) }
                )
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
  
  // MARK: CellContent
  
  @ViewBuilder
  private func cellContent(for cell: ProfileVM.Section.Cell) -> some View {
    switch cell {
    case let .info(_, value):
      infoCellContent(value)
    case .uid:
      uidCellContent
    case .language:
      languageCellContent
    case .notifications:
      notificationsCellContent
    }
  }
  
  // MARK: InfoCellContent
  
  private func infoCellContent(_ value: String) -> some View {
    Text(value)
      .foregroundStyle(UniversalColor.secondaryForeground.color)
      .font(UniversalFont.mdBody.font)
  }
  
  // MARK: UIDCellContent
  
  @ViewBuilder
  var uidCellContent: some View {
    Text(model.uid)
      .foregroundStyle(UniversalColor.secondaryForeground.color)
      .font(UniversalFont.mdBody.font)
    
    Image(
      model.hasRecentlyCopiedText
      ? "done"
      : "copy"
    )
    .resizable()
    .aspectRatio(contentMode: .fit)
    .frame(width: 20, height: 20)
    .foregroundStyle(UniversalColor.secondaryForeground.color)
  }
  
  // MARK: LanguageCellContent
  
  @ViewBuilder
  var languageCellContent: some View {
    Text(model.selectedLanguage)
      .foregroundStyle(UniversalColor.secondaryForeground.color)
      .font(UniversalFont.mdBody.font)
    
    Image(systemName: "chevron.right")
      .renderingMode(.template)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: 15, height: 15)
      .foregroundStyle(UniversalColor.secondaryForeground.color)
  }
  
  // MARK: NotificationsCellContent
  
  var notificationsCellContent: some View {
    Toggle("", isOn: .constant(model.isNotificationsEnabled))
      .tint(UniversalColor.accent.color)
  }
  
  // MARK: SectionHeader
  
  func sectionHeader(_ text: String) -> some View {
    Text(text)
      .foregroundStyle(UniversalColor.secondaryForeground.color)
      .font(UniversalFont.smHeadline.font)
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
