import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct SettingsCellVM {
  let title: String
  let value: String?
}

// MARK: - View

struct SettingsCell: View {
  let model: SettingsCellVM
  let onTap: () -> Void
  
  var body: some View {
    SUCard(
      model: .init {
        $0.animationScale = .small
        $0.backgroundColor = .secondaryBackground
        $0.borderWidth = .none
        $0.cornerRadius = .small
        $0.contentPaddings = .init(horizontal: 16, vertical: 0)
        $0.shadow = .none
        $0.isTappable = true
      },
      content: {
        HStack(spacing: 12) {
          Text(model.title)
            .foregroundStyle(UniversalColor.foreground.color)
            .font(UniversalFont.mdButton.font)
          
          Spacer()
          
          if let value = model.value {
            Text(value)
              .foregroundStyle(UniversalColor.secondaryForeground.color)
              .font(UniversalFont.mdBody.font)
              .lineLimit(1)
          }
          
          Image(systemName: "chevron.right")
            .foregroundStyle(UniversalColor.secondaryForeground.color)
        }
        .frame(height: 52)
      },
      onTap: onTap
    )
  }
}
