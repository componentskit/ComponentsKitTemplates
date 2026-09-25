import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct SubscriptionOptionVM {
  let title: String
  let price: String
  let badge: BadgeVM?
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
        $0.backgroundColor = .secondaryBackground
        $0.borderColor = model.borderColor
        $0.cornerRadius = .small
        $0.isTappable = true
        $0.shadow = .none
      },
      content: {
        HStack(spacing: 12) {
          SUCheckbox(isSelected: .constant(model.isSelected), model: .init {
            $0.size = .large
            $0.color = .accent
            $0.cornerRadius = .full
          })
          
          Text(model.title)
            .foregroundStyle(UniversalColor.foreground.color)
            .font(UniversalFont.mdButton.font)
          
          if let badgeVM = model.badge {
            SUBadge(model: badgeVM)
          }
          
          Spacer()
          
          Text(model.price)
            .foregroundStyle(UniversalColor.foreground.color)
            .font(UniversalFont.mdButton.font)
        }
        .frame(maxWidth: .infinity)
      },
      onTap: didTapOption
    )
  }
}
