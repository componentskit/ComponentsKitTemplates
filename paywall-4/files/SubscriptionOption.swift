import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct SubscriptionOptionVM {
  let title: String
  let price: String
  let pricePerWeek: String
  let isSelected: Bool
  
  var backgroundColor: UniversalColor {
    isSelected ? .background : .secondaryBackground
  }
  var borderColor: UniversalColor {
    isSelected ? .accent : .clear
  }
}

// MARK: - View

struct SubscriptionOption: View {
  let model: SubscriptionOptionVM
  let didTapOption: () -> Void
  
  var body: some View {
    SUCard(
      model: .init {
        $0.animationScale = .none
        $0.backgroundColor = model.backgroundColor
        $0.borderColor = model.borderColor
        $0.isTappable = true
        $0.shadow = .none
      },
      content: {
        ZStack(alignment: .topTrailing) {
          VStack(alignment: .leading, spacing: 0) {
            Text(model.title)
              .foregroundStyle(UniversalColor.foreground.color)
              .font(UniversalFont.smHeadline.font)
            
            Text(model.price)
              .foregroundStyle(UniversalColor.foreground.color)
              .font(UniversalFont.mdHeadline.font)
              .padding(.top, 8)
            
            Text(model.pricePerWeek)
              .foregroundStyle(UniversalColor.secondaryForeground.color)
              .font(UniversalFont.lgCaption.font)
              .padding(.top, 6)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
      },
      onTap: didTapOption
    )
    .overlay(alignment: .topTrailing) {
      if model.isSelected {
        SUCheckbox(isSelected: .constant(true), model: .init {
          $0.size = .large
          $0.color = .accent
          $0.cornerRadius = .full
        })
        .padding(4)
      }
    }
  }
}
