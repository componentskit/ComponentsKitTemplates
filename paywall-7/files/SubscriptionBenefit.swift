import ComponentsKit
import SwiftUI

struct SubscriptionBenefit: View {
  let title: String
  
  var body: some View {
    HStack(spacing: 8) {
      SUCheckbox(
        isSelected: .constant(true),
        model: .init { $0.cornerRadius = .full }
      )
      Text(title)
        .foregroundStyle(UniversalColor.foreground.color)
        .font(UniversalFont.mdButton.font)
    }
  }
}
