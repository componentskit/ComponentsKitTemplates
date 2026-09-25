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
        $0.backgroundColor = .accent
        $0.borderWidth = .none
        $0.cornerRadius = .small
        $0.shadow = .none
      }) {
        Image(model.icon)
          .renderingMode(.template)
          .foregroundColor(UniversalColor.background.color)
          .frame(width: 20, height: 20)
      }
      HStack {
        Text(model.title)
          .foregroundStyle(UniversalColor.secondaryForeground.color)
          .font(UniversalFont.mdButton.font)
        
        Spacer()
        
        Text(model.info)
          .foregroundStyle(UniversalColor.foreground.color)
          .font(UniversalFont.mdButton.font)
      }
    }
  }
}
