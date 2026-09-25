import ComponentsKit
import SwiftUI

// MARK: - ViewModel

@Observable
class AuthorizationVM {
  var emailAuthVM: EmailAuthVM?
  
  func didTapContinueWithEmail() {
    emailAuthVM = EmailAuthVM()
  }
  func didTapGoogleAuth() {
    /* handle google auth button tap */
  }
  func didTapAppleAuth() {
    /* handle apple auth button tap */
  }
}

// MARK: - View

struct Authorization: View {
  @Bindable var model = AuthorizationVM()
  
  var body: some View {
    ZStack(alignment: .top) {
      Image("background-main")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .edgesIgnoringSafeArea(.top)
      
      VStack {
        HStack {
          Spacer()
          CloseButton(hasBackground: true)
        }
        
        Spacer()
        
        VStack(alignment: .leading, spacing: 0) {
          Text("Your Next Adventure Awaits")
            .foregroundStyle(UniversalColor.foreground.color)
            .font(UniversalFont.lgHeadline.withSize(40).font)
            .multilineTextAlignment(.leading)
          
          Text("Plan trips, track memories, and explore the world with ease.")
            .foregroundStyle(UniversalColor.secondaryForeground.color)
            .font(UniversalFont.mdBody.font)
            .multilineTextAlignment(.leading)
            .padding(.top, 16)
          
          SUButton(
            model: .init {
              $0.image = .init("letter")
              $0.title = "Continue with Email"
              $0.color = .accent
              $0.isFullWidth = true
              $0.size = .large
            },
            action: model.didTapContinueWithEmail
          )
          .padding(.top, 30)
          
          HStack(spacing: 8) {
            SUDivider()
            Text("OR")
              .foregroundStyle(UniversalColor.secondaryForeground.color)
              .font(UniversalFont.smHeadline.font)
            SUDivider()
          }
          .padding(.top, 20)
          
          HStack(spacing: 16) {
            SUButton(
              model: .init {
                $0.image = .init("google")
                $0.title = "Google"
                $0.style = .bordered(.medium)
                $0.size = .large
                $0.isFullWidth = true
              },
              action: model.didTapGoogleAuth
            )
            SUButton(
              model: .init {
                $0.image = .init("apple")
                $0.title = "Apple"
                $0.style = .bordered(.medium)
                $0.size = .large
                $0.isFullWidth = true
              },
              action: model.didTapAppleAuth
            )
          }
          .padding(.top, 20)
        }
      }
      .padding()
    }
    .frame(maxWidth: .infinity)
    .background(UniversalColor.background.color)
    .fullScreenCover(item: $model.emailAuthVM) { emailAuthVM in
      EmailAuth(model: emailAuthVM)
    }
  }
}
