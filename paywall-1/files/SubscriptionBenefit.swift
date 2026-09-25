import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct SubscriptionBenefitVM: Hashable {
  let title: String
  let subtitle: String
  let icon: String
}

// MARK: - View

struct SubscriptionBenefit: View {
  let model: SubscriptionBenefitVM
  
  var body: some View {
    HStack(spacing: 16) {
      SUCard(model: .init {
        $0.backgroundColor = .secondaryBackground
        $0.borderWidth = .none
        $0.contentPaddings = .init(padding: 0)
        $0.shadow = .none
      }) {
        ZStack {
          Image(model.icon)
            .renderingMode(.template)
            .foregroundColor(UniversalColor.accent.color)
            .frame(width: 32, height: 32)
        }
        .frame(width: 65, height: 65)
      }
      
      VStack(alignment: .leading, spacing: 8) {
        Text(model.title)
          .foregroundStyle(UniversalColor.foreground.color)
          .font(UniversalFont.mdHeadline.font)
        
        Text(model.subtitle)
          .foregroundStyle(UniversalColor.secondaryForeground.color)
          .font(UniversalFont.mdBody.font)
      }
    }
  }
}
