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
  
  enum Gender {
    case male, female, preferNotToSay
  }
  
  var currentScreen: Screen = .signIn
  
  var name = ""
  var email = ""
  var password = ""
  var selectedGender: Gender?
  
  private var nameError: String?
  private var emailError: String?
  private var passwordError: String?
  
  var title: String {
    switch currentScreen {
    case .signIn:
      return "Welcome Back, Explorer"
    case .signUp:
      return "Join the Journey"
    case .resetPassword:
      return "Reset Your Password"
    }
  }
  
  var subtitle: String {
    switch currentScreen {
    case .signIn:
      return "Access your trips, journals, and memories."
    case .signUp:
      return "Map your travels. Save your memories. Explore more."
    case .resetPassword:
      return "We’ll help you get back on the road in no time."
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
      $0.style = .bordered
      $0.titlePosition = .inside
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
      $0.style = .bordered
      $0.titlePosition = .inside
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
      $0.style = .bordered
      $0.titlePosition = .inside
      $0.autocapitalization = .never
      $0.titleFont = .mdButton
      $0.submitType = .done
      $0.isSecureInput = true
      $0.color = passwordError != nil ? .danger : .none
      $0.caption = passwordError
    }
  }
  
  func didTapPrimaryButton() {
    validate()
    
    let isValid = [nameError, emailError, passwordError]
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
    selectedGender = nil
  }
}

// MARK: - View

struct EmailAuth: View {
  @Bindable var model: EmailAuthVM
  
  enum Field {
    case name, email, password
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
            if model.currentScreen == .resetPassword {
              Image("background-reset")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 380, maxHeight: 260)
            }
            
            Text(model.title)
              .foregroundStyle(UniversalColor.foreground.color)
              .font(UniversalFont.lgHeadline.withSize(48).font)
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.top, 20)
            
            Text(model.subtitle)
              .foregroundStyle(UniversalColor.secondaryForeground.color)
              .font(UniversalFont.smBody.font)
              .frame(maxWidth: .infinity, alignment: .leading)
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
                $0.isEnabled = model.currentScreen != .signUp || model.selectedGender != nil
              },
              action: model.didTapPrimaryButton
            )
            .padding(.top)
            
            footerRow
              .padding(.top, 15)
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
          $0.title = "Forgot your password?"
          $0.style = .plain
          $0.color = .accent
          $0.size = .medium
        },
        action: model.didTapResetPasswordButton
      )
    }
    .padding(.top, 32)
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
      
      VStack(alignment: .leading) {
        Text("Select Gender")
          .font(UniversalFont.mdButton.font)
          .foregroundStyle(UniversalColor.foreground.color)
        
        SURadioGroup(
          selectedId: $model.selectedGender,
          model: .init {
            $0.items = [
              .init(id: .male) {
                $0.title = "Male"
              },
              .init(id: .female){
                $0.title = "Female"
              },
              .init(id: .preferNotToSay)  {
                $0.title = "Prefer not to say"
              }
            ]
          }
        )
      }
      .frame(maxWidth: .infinity, alignment: .leading)
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
    .padding(.top, 32)
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
    return HStack(spacing: 6) {
      if !text.isEmpty {
        Text(text)
          .foregroundStyle(UniversalColor.secondaryForeground.color)
          .font(UniversalFont.smBody.font)
      }
      SUButton(
        model: .init {
          $0.title = buttonText
          if model.currentScreen == .resetPassword {
            $0.isFullWidth = true
            $0.style = .light
            $0.size = .large
          } else {
            $0.color = .accent
            $0.style = .minimal
            $0.size  = .small
          }
        },
        action: footerAction
      )
    }
  }
}
