import ComponentsKit
import SwiftUI

struct PreferencesCell<Content: View>: View {
  let title: String
  @ViewBuilder let content: () -> Content
  let onTap: () -> Void
  
  var body: some View {
    SUCard(
      model: .profileCell,
      content: {
        HStack(spacing: 12) {
          Text(title)
            .foregroundStyle(UniversalColor.foreground.color)
            .font(UniversalFont.mdButton.font)
          
          Spacer()
          
          content()
        }
        .frame(height: 52)
      },
      onTap: onTap
    )
  }
}
