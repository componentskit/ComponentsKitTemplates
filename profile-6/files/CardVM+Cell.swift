import ComponentsKit

extension CardVM {
  static var cell: CardVM {
    return .init {
      $0.animationScale = .small
      $0.backgroundColor = .secondaryBackground
      $0.borderWidth = .none
      $0.cornerRadius = .small
      $0.contentPaddings = .init(horizontal: 16, vertical: 0)
      $0.shadow = .none
      $0.isTappable = true
    }
  }
}
