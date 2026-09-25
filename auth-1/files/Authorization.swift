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
      Image("background")
        .resizable()
        .aspectRatio(contentMode: .fit)
      
      VStack {
        HStack {
          Spacer()
          CloseButton(hasBackground: true)
        }
        
        Spacer()
        
        SUCard(model: .init {
          $0.backgroundColor = .background
          $0.borderWidth = .none
          $0.cornerRadius = .large
          $0.shadow = .none
        }) {
          VStack(spacing: 0) {
            Text("Productivity Made Simple")
              .foregroundStyle(UniversalColor.foreground.color)
              .font(UniversalFont.lgHeadline.withSize(32).font)
              .multilineTextAlignment(.center)
            
            Text("All your tasks in one place.")
              .foregroundStyle(UniversalColor.secondaryForeground.color)
              .font(UniversalFont.mdBody.font)
              .multilineTextAlignment(.center)
              .padding(.top, 12)
            
            SUButton(
              model: .init {
                $0.title = "Continue with Email"
                $0.color = .accent
                $0.isFullWidth = true
                $0.size = .large
              },
              action: model.didTapContinueWithEmail
            )
            .padding(.top, 32)
            
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
      }
      .padding()
    }
    .frame(maxWidth: .infinity)
    .background(UniversalColor.secondaryBackground.color)
    .fullScreenCover(item: $model.emailAuthVM) { emailAuthVM in
      EmailAuth(model: emailAuthVM)
    }
  }
}
