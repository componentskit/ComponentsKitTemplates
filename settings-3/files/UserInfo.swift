import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct UserInfoVM {
  let email: String
  let avatarSrc: AvatarVM.ImageSource
}

// MARK: - View

struct UserInfo: View {
  let model: UserInfoVM
  
  var body: some View {
    HStack(alignment: .center, spacing: 12) {
      SUAvatar(model: .init {
        $0.imageSrc = model.avatarSrc
        $0.size = .medium
      })
      Text(verbatim: model.email)
        .foregroundStyle(UniversalColor.foreground.color)
        .font(UniversalFont.mdButton.font)
        .lineLimit(1)
        .minimumScaleFactor(0.8)
      
      Spacer()
      
      Image(systemName: "chevron.right")
        .renderingMode(.template)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 15, height: 15)
        .foregroundStyle(UniversalColor.accent.color)
    }
  }
}
