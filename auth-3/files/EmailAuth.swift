import ComponentsKit
import SwiftUI

// MARK: - EmailAuthVM

@Observable
class EmailAuthVM: Identifiable {
  enum Screen {
    case signIn
    case signUp
    case resetPassword
  }
  
  var currentScreen: Screen = .signIn
  
  var name = ""
  var email = ""
  var password = ""
  var confirmPassword = ""
  
  private var nameError: String?
  private var emailError: String?
  private var passwordError: String?
  private var confirmPasswordError: String?
  
  var title: String {
    switch currentScreen {
    case .signIn:
      return "Access Your Digital Vault"
    case .signUp:
      return "Access Your Digital Vault"
    case .resetPassword:
      return "Reset Your Password"
    }
  }
  
  var nameInputVM: InputFieldVM {
    return .init {
      $0.placeholder = "Name"
      $0.autocapitalization = .words
      $0.titleFont = .mdButton
      $0.submitType = .next
      $0.color = nameError != nil ? .danger : .none
      $0.caption = nameError
    }
  }
  var emailInputVM: InputFieldVM {
    return .init {
      $0.placeholder = "Email"
      $0.autocapitalization = .never
      $0.titleFont = .mdButton
      $0.keyboardType = .emailAddress
      $0.submitType = currentScreen == .resetPassword ? .done : .next
      $0.color = emailError != nil ? .danger : .none
      $0.caption = emailError
    }
  }
  var passwordInputVM: InputFieldVM {
    return .init {
      $0.placeholder = "Password"
      $0.isSecureInput = true
      $0.autocapitalization = .never
      $0.titleFont = .mdButton
      $0.submitType = currentScreen == .signUp ? .next : .done
      $0.color = passwordError != nil ? .danger : .none
      $0.caption = passwordError
    }
  }
  var confirmPasswordInputVM: InputFieldVM {
    return .init {
      $0.placeholder = "Confirm Password"
      $0.isSecureInput = true
      $0.autocapitalization = .never
      $0.titleFont = .mdButton
      $0.submitType = .done
      $0.color = confirmPasswordError != nil ? .danger : .none
      $0.caption = confirmPasswordError
    }
  }
  
  func didTapPrimaryButton() {
    validate()
    
    let isValid = [nameError, emailError, passwordError, confirmPasswordError]
      .allSatisfy { $0 == nil }
    
    if isValid {
      /* handle primary button tap */
    }
  }
  func didTapSecondaryButton() {
    switch currentScreen {
    case .signIn:
      changeScreen(to: .signUp)
    case .signUp:
      changeScreen(to: .signIn)
    case .resetPassword:
      changeScreen(to: .signIn)
    }
  }
  func didTapResetPasswordButton() {
    changeScreen(to: .resetPassword)
  }
  
  private func validate() {
    emailError = FormValidator.emailError(for: email)
    switch currentScreen {
    case .signIn:
      passwordError = FormValidator.passwordError(for: password)
    case .signUp:
      nameError = name.isEmpty ? "Name is required" : nil
      passwordError = FormValidator.passwordError(for: password)
      confirmPasswordError =
      (password == confirmPassword && !confirmPassword.isEmpty)
      ? nil
      : "Passwords do not match"
    case .resetPassword:
      break
    }
  }
  private func changeScreen(to screen: Screen) {
    clearErrors()
    currentScreen = screen
  }
  private func clearErrors() {
    nameError = nil
    emailError = nil
    passwordError = nil
    confirmPasswordError = nil
  }
}

// MARK: - EmailAuthHeader

struct EmailAuthHeader: View {
  let model: EmailAuthVM
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ZStack {
      HStack {
        Spacer()
        Button {
          dismiss()
        } label: {
          Image(systemName: "xmark")
            .resizable()
            .frame(width: 10, height: 10)
            .foregroundColor(UniversalColor.foreground.color)
        }
        .frame(width: 24, height: 24)
        .background(UniversalColor.content1.color)
        .clipShape(Circle())
      }
      Text(model.title)
        .foregroundStyle(UniversalColor.foreground.color)
        .font(UniversalFont.mdHeadline.font)
        .multilineTextAlignment(.center)
    }
  }
}

// MARK: - EmailAuthBody

struct EmailAuthBody: View {
  @Bindable var model: EmailAuthVM
  @FocusState var focus: Field?
  
  enum Field {
    case name, email, password, confirmPassword
  }
  
  var body: some View {
    Group {
      switch model.currentScreen {
      case .signIn: signInForm
      case .signUp: signUpForm
      case .resetPassword: resetPasswordForm
      }
    }
    .padding(.top, 8)
    .animation(.linear, value: model.currentScreen)
  }
  
  var signInForm: some View {
    VStack(spacing: 20) {
      SUInputField(
        text: $model.email,
        globalFocus: $focus,
        localFocus: .email,
        model: model.emailInputVM
      )
      .onSubmit { focus = .password }
      
      SUInputField(
        text: $model.password,
        globalFocus: $focus,
        localFocus: .password,
        model: model.passwordInputVM
      )
      
      SUButton(
        model: .init {
          $0.title = "Forgot your password?"
          $0.style = .plain
          $0.color = .accent
          $0.size = .medium
        },
        action: model.didTapResetPasswordButton
      )
    }
  }
  
  var signUpForm: some View {
    VStack(spacing: 20) {
      SUInputField(
        text: $model.name,
        globalFocus: $focus,
        localFocus: .name,
        model: model.nameInputVM
      )
      .onSubmit { focus = .email }
      
      SUInputField(
        text: $model.email,
        globalFocus: $focus,
        localFocus: .email,
        model: model.emailInputVM
      )
      .onSubmit { focus = .password }
      
      SUInputField(
        text: $model.password,
        globalFocus: $focus,
        localFocus: .password,
        model: model.passwordInputVM
      )
      .onSubmit { focus = .confirmPassword }
      
      SUInputField(
        text: $model.confirmPassword,
        globalFocus: $focus,
        localFocus: .confirmPassword,
        model: model.confirmPasswordInputVM
      )
    }
  }
  
  var resetPasswordForm: some View {
    SUInputField(
      text: $model.email,
      globalFocus: $focus,
      localFocus: .email,
      model: model.emailInputVM
    )
  }
}

// MARK: - EmailAuthFooter

struct EmailAuthFooter: View {
  let model: EmailAuthVM
  
  var body: some View {
    VStack(spacing: 0) {
      SUButton(
        model: .init {
          $0.title = "Continue"
          $0.color = .accent
          $0.isFullWidth = true
          $0.size = .large
        },
        action: model.didTapPrimaryButton
      )
      
      footerRow
        .padding(.top, 16)
    }
  }
  
  var footerRow: some View {
    switch model.currentScreen {
    case .signIn:
      footer(
        text: "New here?",
        buttonText: "Create an account",
        footerAction: model.didTapSecondaryButton
      )
      
    case .signUp:
      footer(
        text: "Already have an account?",
        buttonText: "Sign In",
        footerAction: model.didTapSecondaryButton
      )
      
    case .resetPassword:
      footer(
        text: "",
        buttonText: "Return to Sign In",
        footerAction: model.didTapSecondaryButton
      )
    }
  }
  
  func footer(
    text: String,
    buttonText: String,
    footerAction: @escaping () -> Void
  ) -> some View {
    HStack(spacing: 6) {
      if !text.isEmpty {
        Text(text)
          .foregroundStyle(UniversalColor.secondaryForeground.color)
          .font(UniversalFont.smBody.font)
      }
      SUButton(
        model: .init {
          $0.title = buttonText
          $0.color = .accent
          $0.size = .small
          $0.style = .minimal
        },
        action: footerAction
      )
    }
  }
}
