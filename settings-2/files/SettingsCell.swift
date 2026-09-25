import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct SettingsCellVM: Hashable {
  let title: String
  let icon: String
  let endIcon: String?
}

// MARK: - View

struct SettingsCell: View {
  let model: SettingsCellVM
  var onTap: () -> Void
  
  var body: some View {
    SUCard(
      model: .init {
        $0.animationScale = .small
        $0.backgroundColor = .clear
        $0.borderWidth = .none
        $0.contentPaddings = .init(horizontal: 0, vertical: 0)
        $0.shadow = .none
        $0.isTappable = true
      },
      content: {
        HStack(spacing: 12) {
          SUCard(model: .init {
            $0.contentPaddings = .init(padding: 12)
            $0.backgroundColor = .secondaryBackground
            $0.borderWidth = .none
            $0.cornerRadius = .large
            $0.shadow = .none
          }) {
            Image(model.icon)
              .renderingMode(.template)
              .foregroundColor(UniversalColor.accent.color)
              .frame(width: 24, height: 24)
          }
          
          Text(model.title)
            .foregroundStyle(UniversalColor.foreground.color)
            .font(UniversalFont.mdButton.font)
          
          Spacer()
          
          if let image = model.endIcon {
            Image(systemName: image)
              .renderingMode(.template)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 18, height: 18)
              .foregroundStyle(UniversalColor.foreground.color)
          }
        }
        .frame(height: 48)
      },
      onTap: onTap
    )
  }
}
