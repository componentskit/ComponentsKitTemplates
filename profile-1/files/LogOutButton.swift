import ComponentsKit
import SwiftUI

struct LogOutButton: View {
  var onTap: () -> Void
  
  var body: some View {
    SUCard(
      model: .init {
        $0.animationScale = .small
        $0.backgroundColor = .clear
        $0.borderWidth = .none
        $0.cornerRadius = .small
        $0.contentPaddings = .init(horizontal: 0, vertical: 0)
        $0.shadow = .none
        $0.isTappable = true
      },
      content: {
        HStack(spacing: 12) {
          SUCard(model: .init {
            $0.contentPaddings = .init(padding: 8)
            $0.backgroundColor = .danger
            $0.borderWidth = .none
            $0.cornerRadius = .large
            $0.shadow = .none
          }) {
            Image("log-out")
              .renderingMode(.template)
              .foregroundColor(UniversalColor.background.color)
              .frame(width: 24, height: 24)
          }
          Text("Log Out")
            .foregroundStyle(UniversalColor.foreground.color)
            .font(UniversalFont.mdButton.font)
          Spacer()
          Image(systemName: "chevron.right")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 15, height: 15)
            .foregroundStyle(UniversalColor.danger.color)
        }
        .contentShape(.rect)
      },
      onTap: onTap
    )
  }
}
