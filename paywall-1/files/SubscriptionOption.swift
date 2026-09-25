import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct SubscriptionOptionVM {
  let title: String
  let price: String
  let pricePerMonth: String
  let isSelected: Bool
  
  var backgroundColor: UniversalColor {
    isSelected ? .accent : .secondaryBackground
  }
  var foregroundColor: UniversalColor {
    isSelected ? .accentContrast : .foreground
  }
  var checkboxColor: ComponentColor {
    .init(main: .accentContrast, contrast: .accent)
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
        $0.borderWidth = .none
        $0.isTappable = true
        $0.shadow = .none
      },
      content: {
        VStack(alignment: .leading, spacing: 0) {
          Text(model.title)
            .foregroundStyle(model.foregroundColor.color)
            .font(UniversalFont.mdHeadline.font)
          
          Text(model.price)
            .foregroundStyle(model.foregroundColor.color)
            .font(UniversalFont.lgHeadline.font)
            .padding(.top, 40)
          
          Text("\(model.pricePerMonth) per month")
            .foregroundStyle(model.foregroundColor.color)
            .font(UniversalFont.lgCaption.font)
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      },
      onTap: didTapOption
    )
    .overlay(alignment: .topTrailing) {
      if model.isSelected {
        SUCheckbox(isSelected: .constant(true), model: .init {
          $0.size = .large
          $0.color = model.checkboxColor
          $0.cornerRadius = .full
        })
        .padding(4)
      }
    }
  }
}
