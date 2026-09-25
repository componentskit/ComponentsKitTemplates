import ComponentsKit
import SwiftUI

struct Review: View {
  var body: some View {
    SUCard(model: .init {
      $0.contentPaddings = .init(horizontal: 20, vertical: 16)
      $0.backgroundColor = .secondaryBackground
      $0.borderWidth = .none
      $0.cornerRadius = .small
      $0.shadow = .medium
    }) {
      VStack(alignment: .leading, spacing: 24) {
        Text("This app completely changed the way I work. The smart suggestions and speed are incredible — I can't imagine going back!")
          .foregroundStyle(UniversalColor.foreground.color)
          .font(UniversalFont.mdBody.font)
        
        HStack(spacing: 8) {
          SUAvatar(model: .init {
            $0.size = .medium
            $0.imageSrc = .local(.init("avatar"))
          })
          VStack(alignment: .leading, spacing: 6) {
            Text("Esther Howard")
              .foregroundStyle(UniversalColor.foreground.color)
              .font(UniversalFont.mdButton.font)
            HStack(spacing: 2) {
              ForEach(0..<5, id: \.self) { _ in
                Image("star")
                  .renderingMode(.template)
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 16, height: 16)
                  .foregroundColor(UniversalColor.accent.color)
              }
            }
          }
        }
      }
    }
    .frame(maxWidth: 340)
    .background(
      Rectangle()
        .fill(UniversalColor.secondaryBackground.color)
        .cornerRadius(ContainerRadius.small.value)
        .padding(.horizontal, 25)
        .padding(.top, -16)
    )
  }
}
