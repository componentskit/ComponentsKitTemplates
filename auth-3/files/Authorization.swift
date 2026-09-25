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
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ZStack(alignment: .top) {
      VStack {
        HStack {
          Spacer()
          SUButton(model: .init {
            $0.image = .init(systemName: "xmark")
            $0.color = .accent
            $0.style = .minimal
            $0.size = .small
          }) {
            dismiss()
          }
        }
        
        Spacer()
        
        VStack(spacing: 0) {
          Text("All Your IDs. One Secure Place.")
            .foregroundStyle(UniversalColor.foreground.color)
            .font(UniversalFont.lgHeadline.withSize(40).font)
            .multilineTextAlignment(.center)
          
          Text("Store, manage, and access your personal documents anytime, anywhere.")
            .foregroundStyle(UniversalColor.secondaryForeground.color)
            .font(UniversalFont.mdBody.font)
            .multilineTextAlignment(.center)
            .padding(.top, 12)
          
          Spacer()
          
          Image("background")
            .resizable()
            .aspectRatio(contentMode: .fit)
          
          Spacer()
          
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
      .padding()
    }
    .frame(maxWidth: .infinity)
    .background(UniversalColor.secondaryBackground.color)
    .ignoresSafeArea(.keyboard)
    .centerModal(
      item: $model.emailAuthVM,
      model: { _ in .init() },
      header: { model in EmailAuthHeader(model: model) },
      body: { model in EmailAuthBody(model: model) },
      footer: { model in EmailAuthFooter(model: model) }
    )
  }
}
