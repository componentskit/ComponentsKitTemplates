import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct SubscriptionBenefitVM: Hashable {
  let subtitle: String
  let icon: String
}

// MARK: - View

struct SubscriptionBenefit: View {
  let model: SubscriptionBenefitVM
  
  var body: some View {
    HStack(spacing: 16) {
      SUCard(model: .init {
        $0.contentPaddings = .init(padding: 14)
        $0.backgroundColor = .secondaryBackground
        $0.borderWidth = .none
        $0.cornerRadius = .small
        $0.shadow = .none
      }) {
        Image(model.icon)
          .renderingMode(.template)
          .foregroundColor(UniversalColor.accent.color)
          .frame(width: 28, height: 28)
      }
      Text(model.subtitle)
        .foregroundStyle(UniversalColor.foreground.color)
        .font(UniversalFont.mdBody.font)
    }
  }
}
