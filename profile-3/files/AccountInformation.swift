import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct AccountInformationVM {
  let title: String
  let info: String
  let icon: String
  let canCopy: Bool
}

// MARK: - View

struct AccountInformation: View {
  let model: AccountInformationVM
  let didTapCopy: (String) -> Void
  
  var body: some View {
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
      VStack(alignment: .leading, spacing: 8) {
        Text(model.title)
          .foregroundStyle(UniversalColor.secondaryForeground.color)
          .font(UniversalFont.smButton.font)
        
        Text(model.info)
          .foregroundStyle(UniversalColor.foreground.color)
          .font(UniversalFont.mdButton.font)
      }
      
      Spacer()
      
      if model.canCopy {
        SUButton(
          model: .init {
            $0.image = .init("copy")
            $0.color = .accent
            $0.style = .minimal
            $0.size = .small
            $0.cornerRadius = .none
          },
          action: { didTapCopy(model.info) }
        )
      }
    }
  }
}
