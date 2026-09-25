import ComponentsKit
import SwiftUI

struct ProfileCell<Content: View>: View {
  let title: String
  @ViewBuilder var content: () -> Content
  var onTap: () -> Void
  
  var body: some View {
    SUCard(
      model: .init {
        $0.animationScale = .small
        $0.backgroundColor = .secondaryBackground
        $0.borderWidth = .none
        $0.cornerRadius = .small
        $0.contentPaddings = .init(horizontal: 16, vertical: 0)
        $0.shadow = .none
        $0.isTappable = true
      },
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
