import ComponentsKit
import SwiftUI

// MARK: - ViewModel

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
  var isTermsAccepted = false
  
  private var nameError: String?
  private var emailError: String?
  private var passwordError: String?
  private var confirmPasswordError: String?
  
  var title: String {
    switch currentScreen {
    case .signIn:
      return "Welcome Back 👋"
    case .signUp:
      return "Create Your Account"
    case .resetPassword:
      return "Reset Your Password"
    }
  }
  
  var subtitle: String {
    switch currentScreen {
    case .signIn:
      return "Let’s get things done — log in to access your tasks."
    case .signUp:
      return "Plan better. Focus more. Start now."
    case .resetPassword:
      return "We’ll help you get back on track — enter your email."
    }
  }
  
  var primaryButtonTitle: String {
    switch currentScreen {
    case .signIn:
      return "Sign In"
    case .signUp:
      return "Sign Up"
    case .resetPassword:
      return "Send Reset Link"
    }
  }
  
  var nameInputVM: InputFieldVM {
    return .init {
      $0.title = "Name"
      $0.placeholder = "Enter your name"
      $0.isRequired = true
      $0.titlePosition = .outside
      $0.autocapitalization = .words
      $0.titleFont = .mdButton
      $0.submitType = .next
      $0.color = nameError != nil ? .danger : .none
      $0.caption = nameError
    }
  }
  var emailInputVM: InputFieldVM {
    return .init {
      $0.title = "Email"
      $0.placeholder = "Enter your email"
      $0.isRequired = true
      $0.titlePosition = .outside
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
      $0.title = "Password"
      $0.placeholder = "Enter your password"
      $0.isRequired = true
      $0.titlePosition = .outside
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
      $0.title = "Confirm Password"
      $0.placeholder = "Confirm your password"
      $0.isRequired = true
      $0.titlePosition = .outside
      $0.isSecureInput = true
      $0.autocapitalization = .never
      $0.titleFont = .mdButton
      $0.submitType = .done
      $0.color = confirmPasswordError != nil ? .danger : .none
      $0.caption = confirmPasswordError
    }
  }
  
  var checkboxText: AttributedString {
    do {
      return try AttributedString(
        markdown: "I accept the [Terms & Conditions](https://policies.google.com/terms)"
      )
    } catch {
      return AttributedString("I accept the Terms & Conditions")
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

// MARK: - View

struct EmailAuth: View {
  @Bindable var model: EmailAuthVM
  
  enum Field {
    case name, email, password, confirmPassword
  }
  
  @FocusState var focus: Field?
  
  var body: some View {
    VStack(spacing: 0) {
      HStack {
        Spacer()
        CloseButton(hasBackground: false)
      }
      .padding()
      
      GeometryReader { geometry in
        ScrollView(showsIndicators: false) {
          VStack(spacing: 0) {
            Spacer()
            
            Text(model.title)
              .foregroundStyle(UniversalColor.foreground.color)
              .font(UniversalFont.lgHeadline.withSize(32).font)
              .multilineTextAlignment(.center)
            
            Text(model.subtitle)
              .foregroundStyle(UniversalColor.secondaryForeground.color)
              .font(UniversalFont.smBody.font)
              .multilineTextAlignment(.center)
              .padding(.top, 12)
            
            switch model.currentScreen {
            case .signIn:
              signInForm
            case .signUp:
              signUpForm
            case .resetPassword:
              resetPasswordForm
            }
            
            Spacer()
            
            SUButton(
              model: .init {
                $0.title = model.primaryButtonTitle
                $0.color = .accent
                $0.isFullWidth = true
                $0.size = .large
              },
              action: model.didTapPrimaryButton
            )
            
            footerRow
              .padding(.top, 24)
          }
          .padding()
          .frame(minHeight: geometry.size.height)
        }
        .scrollDismissesKeyboard(.interactively)
      }
      .animation(.linear, value: model.currentScreen)
    }
    .background(UniversalColor.background.color)
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
          $0.title = "Can’t remember your password?"
          $0.style = .plain
          $0.color = .accent
          $0.size = .medium
        },
        action: model.didTapResetPasswordButton
      )
    }
    .padding(.top, 40)
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
      
      HStack {
        SUCheckbox(
          isSelected: $model.isTermsAccepted,
          model: .init {
            $0.size = .small
            $0.color = .accent
          }
        )
        Text(model.checkboxText)
          .foregroundStyle(UniversalColor.foreground.color)
          .font(UniversalFont.mdButton.font)
          .tint(UniversalColor.accent.color)
        Spacer()
      }
      .padding(.bottom, 10)
    }
    .padding(.top, 40)
  }
  
  var resetPasswordForm: some View {
    SUInputField(
      text: $model.email,
      globalFocus: $focus,
      localFocus: .email,
      model: model.emailInputVM
    )
    .padding(.top, 40)
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
