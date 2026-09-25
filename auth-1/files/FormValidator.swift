import Foundation

struct FormValidator {
  static func emailError(for email: String) -> String? {
    guard !email.isEmpty else {
      return "Email is required"
    }
    let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let valid = NSPredicate(format: "SELF MATCHES %@", pattern)
      .evaluate(with: email)
    return valid ? nil : "Please enter a valid email address"
  }
  
  static func passwordError(
    for password: String,
    minLength: Int = 8
  ) -> String? {
    guard !password.isEmpty else {
      return "Password is required"
    }
    guard password.count >= minLength else {
      return "Password must be at least \(minLength) characters"
    }
    return nil
  }
}
