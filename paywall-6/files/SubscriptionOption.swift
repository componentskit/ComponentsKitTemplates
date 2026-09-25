import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct SubscriptionOptionVM {
  let title: String
  let period: String
  let price: String
  let pricePerMonth: String
  let isSelected: Bool
  
  var borderColor: UniversalColor {
    isSelected ? .accent : .clear
  }
  var backgroundColor: UniversalColor {
    isSelected ? .accentBackground : .secondaryBackground
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
        $0.contentPaddings = .init(padding: 12)
        $0.cornerRadius = .small
        $0.isTappable = true
        $0.shadow = .none
      },
      content: {
        VStack {
          HStack {
            Text(model.title)
              .foregroundStyle(UniversalColor.foreground.color)
              .font(UniversalFont.smHeadline.font)
            
            Spacer()
            
            SUCheckbox(isSelected: .constant(model.isSelected), model: .init {
              $0.size = .large
              $0.color = .accent
              $0.cornerRadius = .full
            })
          }
          
          Spacer()
          
          HStack(spacing: 10) {
            Text(model.period)
              .foregroundStyle(UniversalColor.foreground.color)
              .font(UniversalFont.mdHeadline.font)
            
            Text("·")
              .foregroundStyle(UniversalColor.foreground.color)
              .font(UniversalFont.lgHeadline.font)
            
            Text(model.price)
              .foregroundStyle(UniversalColor.foreground.color)
              .font(UniversalFont.mdHeadline.font)
            
            Spacer()
            
            Text(model.pricePerMonth)
              .foregroundStyle(UniversalColor.secondaryForeground.color)
              .font(UniversalFont.mdButton.font)
          }
        }
      },
      onTap: didTapOption
    )
    .frame(height: 100)
  }
}
