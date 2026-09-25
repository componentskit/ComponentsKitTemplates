import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct UserInfoVM {
  let name: String
  let email: String
  let avatarSrc: AvatarVM.ImageSource
}

// MARK: - View

struct UserInfoSection: View {
  let model: UserInfoVM
  let onTap: () -> Void
  
  var body: some View {
    SUCard(
      model: .init {
        $0.animationScale = .small
        $0.backgroundColor = .clear
        $0.borderWidth = .none
        $0.shadow = .none
        $0.contentPaddings = .init(padding: 0)
        $0.isTappable = true
      },
      content: {
        HStack(alignment: .center, spacing: 16) {
          SUAvatar(model: .init {
            $0.imageSrc = model.avatarSrc
            $0.size = .large
          })
          
          VStack(alignment: .leading, spacing: 10) {
            Text(model.name)
              .foregroundStyle(UniversalColor.foreground.color)
              .font(UniversalFont.mdHeadline.font)
            
            Text(verbatim: model.email)
              .foregroundStyle(UniversalColor.secondaryForeground.color)
              .font(UniversalFont.mdButton.font)
              .lineLimit(1)
              .minimumScaleFactor(0.8)
          }
          Spacer()
          Image(systemName: "chevron.right")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 18, height: 18)
            .foregroundStyle(UniversalColor.secondaryForeground.color)
        }
      },
      onTap: onTap
    )
  }
}
