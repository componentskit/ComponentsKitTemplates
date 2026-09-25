import ComponentsKit
import SwiftUI

// MARK: - ViewModel

class ProfileVM {
  let accountInfo: [AccountInformationVM] = [
    .init(
      title: "Username",
      info: "@eshoward",
      icon: "user"
    ),
    .init(
      title: "Phone Number",
      info: "(201) 555-0124",
      icon: "phone"
    ),
    .init(
      title: "Email",
      info: "kenzi.lawson@example.com",
      icon: "letter"
    ),
    .init(
      title: "Location",
      info: "USA",
      icon: "map-point"
    ),
  ]
  
  let tags = [
    "👤 32 y.o",
    "🇺🇸 USA",
    "👨‍💻 Agency Founder"
  ]
  
  let bottomGradientOverlayHeight: CGFloat = 60
  
  func didTapSettings() {
    /* handle settings button tap */
  }
  func didTapEditProfile() {
    /* handle edit profile button tap */
  }
  func didTapLogOut() {
    /* handle log out button tap */
  }
}

// MARK: - View

struct Profile: View {
  let model = ProfileVM()
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack {
      ScrollView(showsIndicators: false) {
        LazyVStack(alignment: .leading, spacing: 0) {
          userInfoSection
          tagsSection
            .padding(.top, 24)
          descriptionSection
            .padding(.top, 16)
          accountInfoSection
            .padding(.top, 32)
        }
        .padding(.bottom, model.bottomGradientOverlayHeight)
      }
      .overlay(alignment: .bottom, content: { bottomGradientOverlay })
      .frame(maxWidth: .infinity)
      .padding()
      .background(UniversalColor.background.color)
      .toolbar {
        ToolbarItem(placement: .principal) {
          Text("Profile")
            .foregroundStyle(UniversalColor.foreground.color)
            .font(UniversalFont.mdHeadline.font)
        }
        ToolbarItem(placement: .navigationBarLeading) {
          navIconButton(
            icon: .init(systemName: "chevron.left"),
            action: { dismiss() }
          )
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          navIconButton(
            icon: .init("settings"),
            action: model.didTapSettings
          )
        }
      }
      .navigationBarTitleDisplayMode(.inline)
    }
  }
  
  // MARK: UserInfo
  
  var userInfoSection: some View {
    HStack(alignment: .top, spacing: 16) {
      SUAvatar(model: .init {
        $0.imageSrc = .local(.init("avatar"))
        $0.size = .large
      })
      
      VStack(alignment: .leading, spacing: 12) {
        Text("@eshoward")
          .foregroundStyle(UniversalColor.secondaryForeground.color)
          .font(UniversalFont.mdButton.font)
        
        Text("Esther Howard")
          .foregroundStyle(UniversalColor.foreground.color)
          .font(UniversalFont.lgHeadline.font)
      }
      Spacer()
    }
  }
  
  // MARK: Tags
  
  var tagsSection: some View {
    HStack(spacing: 8) {
      ForEach(model.tags, id: \.self) { tag in
        SUBadge(model: .init {
          $0.title = tag
          $0.cornerRadius = .large
          $0.style = .light
        })
      }
    }
  }
  
  // MARK: Description
  
  var descriptionSection: some View {
    Text("I believe good ideas come from clear thinking and a bit of empathy. Always up for meaningful work and new connections.")
      .foregroundStyle(UniversalColor.secondaryForeground.color)
      .font(UniversalFont.lgCaption.font)
      .multilineTextAlignment(.leading)
  }
  
  // MARK: AccountInfo
  
  var accountInfoSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        Text("Account Information")
          .foregroundStyle(UniversalColor.foreground.color)
          .font(UniversalFont.mdHeadline.font)
        
        Spacer()
        
        SUButton(
          model: .init {
            $0.title = "Edit"
            $0.color = .accent
            $0.size = .medium
            $0.style = .minimal
          },
          action: model.didTapEditProfile
        )
      }
      
      ForEach(model.accountInfo, id: \.title) { accountInfoVM in
        AccountInformation(model: accountInfoVM)
      }
      
      LogOutButton()
        .contentShape(.rect)
        .onTapGesture(perform: model.didTapLogOut)
    }
  }
  
  // MARK: BottomGradientOverlay
  
  var bottomGradientOverlay: some View {
    LinearGradient(
      gradient: Gradient(colors: [
        Color.clear,
        UniversalColor.background.color,
      ]),
      startPoint: .top,
      endPoint: .bottom
    )
    .frame(height: model.bottomGradientOverlayHeight)
  }
  
  // MARK: NavIconButton
  
  func navIconButton(
    icon: UniversalImage,
    action: @escaping () -> Void
  ) -> some View {
    SUButton(
      model: .init {
        $0.image = icon
        $0.color = .accent
        $0.style = .minimal
        $0.size = .large
      },
      action: action
    )
  }
}
