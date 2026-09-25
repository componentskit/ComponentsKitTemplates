import ComponentsKit

extension CardVM {
  static var sectionCard: CardVM {
    return .init {
      $0.backgroundColor = .secondaryBackground
      $0.borderWidth = .none
      $0.cornerRadius = .medium
      $0.shadow = .none
    }
  }
}
