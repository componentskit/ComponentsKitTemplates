import ComponentsKit
import SwiftUI

struct LogOutButton: View {
  var body: some View {
    HStack(spacing: 12) {
      SUCard(model: .init {
        $0.contentPaddings = .init(padding: 8)
        $0.backgroundColor = .danger
        $0.borderWidth = .none
        $0.cornerRadius = .small
        $0.shadow = .none
      }) {
        Image("log-out")
          .renderingMode(.template)
          .foregroundColor(UniversalColor.background.color)
          .frame(width: 20, height: 20)
      }
      HStack {
        Text("Log Out")
          .foregroundStyle(UniversalColor.secondaryForeground.color)
          .font(UniversalFont.mdButton.font)
        
        Spacer()
        
        Image(systemName: "chevron.right")
          .renderingMode(.template)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 15, height: 15)
          .foregroundStyle(UniversalColor.danger.color)
      }
    }
  }
}
