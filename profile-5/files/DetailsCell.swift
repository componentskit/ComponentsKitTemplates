import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct DetailsCellVM {
  enum Action {
    case edit
    case copy(isCopied: Bool)
  }
  
  let title: String
  let value: String
  let action: Action
  
  var actionTitle: String {
    switch action {
    case .edit:
      return "Edit"
    case .copy(let isCopied):
      return isCopied ? "Copied" : "Copy"
    }
  }
}

// MARK: - View

struct DetailsCell: View {
  let model: DetailsCellVM
  let onTap: () -> Void
  
  var body: some View {
    SUCard(
      model: .profileCell,
      content: {
        HStack {
          VStack(alignment: .leading, spacing: 8) {
            Text(model.title)
              .foregroundStyle(UniversalColor.secondaryForeground.color)
              .font(UniversalFont.smButton.font)
            Text(model.value)
              .foregroundStyle(UniversalColor.foreground.color)
              .font(UniversalFont.mdButton.font)
          }
          
          Spacer()
          
          Text(model.actionTitle)
            .foregroundStyle(UniversalColor.accent.color)
            .font(UniversalFont.mdButton.font)
        }
        .frame(height: 64)
      },
      onTap: onTap
    )
  }
}
