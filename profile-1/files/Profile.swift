import ComponentsKit
import SwiftUI

// MARK: - ViewModel

@Observable
class ProfileVM {
  let viewsVM = StatCardVM(
    title: "Views",
    value: "64.5k",
    iconName: "eye",
    style: .plain
  )
  
  let likesVM = StatCardVM(
    title: "Likes",
    value: "6.2k",
    iconName: "heart",
    style: .filled
  )
  
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
        LazyVStack(alignment: .leading, spacing: 20) {
          userInfoSection
          statsSection
          verificationSection
          accountInfoSection
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
    SUCard(model: .sectionCard) {
      HStack(alignment: .center, spacing: 16) {
        SUAvatar(model: .init {
          $0.imageSrc = .local(.init("avatar"))
          $0.size = .large
        })
        
        VStack(alignment: .leading, spacing: 0) {
          SUBadge(model: .init {
            $0.title = "@eshoward"
            $0.color = .accent
            $0.cornerRadius = .full
            $0.style = .light
          })
          
          Text("Esther Howard")
            .foregroundStyle(UniversalColor.foreground.color)
            .font(UniversalFont.lgHeadline.font)
            .padding(.top, 8)
        }
        Spacer()
      }
    }
  }
  
  // MARK: Stats
  
  var statsSection: some View {
    HStack(spacing: 8) {
      StatCard(model: model.viewsVM)
      StatCard(model: model.likesVM)
    }
  }
  
  // MARK: Verification
  
  var verificationSection: some View {
    SUCard(model: .sectionCard) {
      VStack(alignment: .leading, spacing: 15) {
        HStack {
          sectionHeader("Complete verification")
          
          Spacer()
          
          SUButton(model: .init {
            $0.title = "Continue"
            $0.color = .accent
            $0.size = .small
            $0.cornerRadius = .full
          })
        }
        SUProgressBar(model: .init {
          $0.currentValue = 48
          $0.cornerRadius = .large
          $0.style = .striped
          $0.color = .accent
        })
      }
    }
  }
  
  // MARK: AccountInfo
  
  var accountInfoSection: some View {
    SUCard(model: .sectionCard) {
      VStack(alignment: .leading, spacing: 16) {
        HStack {
          sectionHeader("Account Information")
          
          Spacer()
          
          SUButton(
            model: .init {
              $0.title = "Edit"
              $0.color = .accent
              $0.size = .small
              $0.cornerRadius = .full
            },
            action: model.didTapEditProfile
          )
        }
        .frame(height: 36)
        
        ForEach(model.accountInfo, id: \.title) { accountInfoVM in
          AccountInformation(model: accountInfoVM)
        }
        
        LogOutButton(onTap: model.didTapLogOut)
      }
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
  
  // MARK: SectionHeader
  
  func sectionHeader(_ text: String) -> some View {
    Text(text)
      .foregroundStyle(UniversalColor.foreground.color)
      .font(UniversalFont.mdHeadline.font)
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
