import ComponentsKit
import SwiftUI

struct CloseButton: View {
  @Environment(\.dismiss) var dismiss
  
  var hasBackground: Bool = false
  
  var body: some View {
    SUButton(
      model: .init {
        $0.color = .init(
          main: .accent,
          contrast: .accentContrast,
          background: .background
        )
        $0.cornerRadius = .full
        $0.image = .init(systemName: "xmark")
        $0.size = .small
        $0.style = hasBackground ? .light : .minimal
      },
      action: { dismiss() }
    )
  }
}
