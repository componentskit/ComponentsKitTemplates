import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct ToggleCellVM: Hashable {
  let title: String
  let isOn: Bool
}

// MARK: - View

struct ToggleCell: View {
  let model: ToggleCellVM
  let onTap: () -> Void
  
  var body: some View {
    SUCard(
      model: .cell,
      content: {
        HStack(spacing: 12) {
          Text(model.title)
            .foregroundStyle(UniversalColor.foreground.color)
            .font(UniversalFont.mdButton.font)
          
          Spacer()
          
          Toggle("", isOn: Binding(
            get: { model.isOn },
            set: { _ in
              onTap()
            }
          ))
          .tint(UniversalColor.accent.color)
        }
        .frame(height: 44)
      },
      onTap: onTap
    )
  }
}
