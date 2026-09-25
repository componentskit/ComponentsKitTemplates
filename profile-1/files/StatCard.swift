import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct StatCardVM {
  enum Style {
    case plain
    case filled
  }
  
  let title: String
  let value: String
  let iconName: String
  let style: Style
  
  var cardBackground: UniversalColor {
    switch style {
    case .plain:
      return .secondaryBackground
    case .filled:
      return .accent
    }
  }
  var foregroundColor: UniversalColor {
    switch style {
    case .plain:
      return .foreground
    case .filled:
      return .accentContrast
    }
  }
}

// MARK: - View

struct StatCard: View {
  let model: StatCardVM
  
  var body: some View {
    SUCard(model: .init {
      $0.backgroundColor = model.cardBackground
      $0.borderWidth  = .none
      $0.cornerRadius = .medium
      $0.shadow = .none
    }) {
      HStack {
        VStack(alignment: .leading, spacing: 10) {
          Text(model.title)
            .foregroundStyle(model.foregroundColor.color)
            .font(UniversalFont.smButton.font)
          
          Text(model.value)
            .foregroundStyle(model.foregroundColor.color)
            .font(UniversalFont.lgHeadline.font)
        }
        Spacer()
        Image(model.iconName)
          .renderingMode(.template)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 32, height: 32)
          .foregroundColor(UniversalColor.accent.color)
          .frame(width: 60, height: 60)
          .background(UniversalColor.accentBackground.color)
          .clipShape(RoundedRectangle(cornerRadius: ComponentRadius.medium.value()))
      }
      .frame(maxWidth: .infinity, maxHeight: 180)
    }
  }
}
