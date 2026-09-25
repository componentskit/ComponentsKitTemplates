import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct SubscriptionOptionVM {
  let duration: String
  let price: String
  let pricePerMonth: String
  let isSelected: Bool
  
  var backgroundColor: UniversalColor {
    isSelected ? .accentBackground : .secondaryBackground
  }
  var borderColor: UniversalColor {
    isSelected ? .accent : .divider
  }
  var checkboxBackgroundColor: UniversalColor {
    isSelected ? .accent : .background
  }
  var checkboxBorderColor: UniversalColor {
    isSelected ? .accent : .divider
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
        $0.cornerRadius = .small
        $0.isTappable = true
        $0.shadow = .none
      },
      content: {
        VStack(alignment: .leading, spacing: 0) {
          Text(model.duration)
            .foregroundStyle(UniversalColor.foreground.color)
            .font(UniversalFont.mdHeadline.font)
            .padding(.top, 12)
          
          Text(model.price)
            .foregroundStyle(UniversalColor.foreground.color)
            .font(UniversalFont.lgHeadline.font)
            .padding(.top, 6)
          
          Text(model.pricePerMonth)
            .foregroundStyle(UniversalColor.secondaryForeground.color)
            .font(UniversalFont.lgCaption.font)
            .padding(.top, 6)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
      },
      onTap: didTapOption
    )
    .overlay(
      SUCard(
        model: .init {
          $0.backgroundColor = model.checkboxBackgroundColor
          $0.borderColor = model.checkboxBorderColor
          $0.contentPaddings = .init(padding: 10)
          $0.cornerRadius = .custom(20)
          $0.shadow = .none
        },
        content: {
          Group {
            if model.isSelected {
              Image("tick")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(UniversalColor.accentContrast.color)
            } else {
              Color.clear
            }
          }
          .frame(width: 20, height: 20)
        }
      )
      .offset(y: -20),
      alignment: .top
    )
  }
}
