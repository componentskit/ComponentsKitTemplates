import ComponentsKit
import SwiftUI

// MARK: - ViewModel

class ProfileVM {
  let accountInfo: [AccountInformationVM] = [
    .init(
      title: "Your Name",
      info: "Esther Howard",
      icon: "user",
      canCopy: false
    ),
    .init(
      title: "Nickname",
      info: "@eshoward",
      icon: "shield-user",
      canCopy: false
    ),
    .init(
      title: "Phone Number",
      info: "(201) 555-0124",
      icon: "phone",
      canCopy: false
    ),
    .init(
      title: "UID",
      info: "5957989479231239417",
      icon: "user-id",
      canCopy: true
    ),
    .init(
      title: "Email",
      info: "kenzi.lawson@example.com",
      icon: "letter",
      canCopy: false
    ),
    .init(
      title: "Address",
      info: "775 Rolling Green Rd.",
      icon: "map-point",
      canCopy: false
    )
  ]
  
  let bottomGradientOverlayHeight: CGFloat = 60
  
  func didTapCopy(_ text: String) {
    UIPasteboard.general.string = text
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
        LazyVStack(alignment: .leading, spacing: 24) {
          ForEach(model.accountInfo, id: \.title) { accountInfoVM in
            AccountInformation(
              model: accountInfoVM,
              didTapCopy: model.didTapCopy
            )
          }
          
          LogOutButton()
            .contentShape(.rect)
            .onTapGesture(perform: model.didTapLogOut)
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
          SUButton(
            model: .init {
              $0.image = .init(systemName: "chevron.left")
              $0.color = .accent
              $0.style = .minimal
              $0.size = .large
            },
            action: { dismiss() }
          )
        }
      }
      .navigationBarTitleDisplayMode(.inline)
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
}
