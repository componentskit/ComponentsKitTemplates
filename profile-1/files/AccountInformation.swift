import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct AccountInformationVM {
  let title: String
  let info: String
  let icon: String
}

// MARK: - View

struct AccountInformation: View {
  let model: AccountInformationVM
  
  var body: some View {
    HStack(spacing: 12) {
      SUCard(model: .init {
        $0.contentPaddings = .init(padding: 8)
        $0.backgroundColor = .accentBackground
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
      Text(model.info)
        .foregroundStyle(UniversalColor.secondaryForeground.color)
        .font(UniversalFont.mdButton.font)
    }
  }
}
