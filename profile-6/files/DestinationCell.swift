import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct DestinationCellVM {
  enum Style {
    case normal
    case destructive
  }
  
  let title: String
  let value: String?
  var style: Style = .normal
  
  var foregroundColor: Color {
    switch style {
    case .normal:
      return UniversalColor.foreground.color
    case .destructive:
      return UniversalColor.danger.color
    }
  }
  
  var secondaryColor: Color {
    switch style {
    case .normal:
      return UniversalColor.secondaryForeground.color
    case .destructive:
      return UniversalColor.danger.color
    }
  }
}

// MARK: - View

struct DestinationCell: View {
  let model: DestinationCellVM
  let onTap: () -> Void
  
  var body: some View {
    SUCard(
      model: .cell,
      content: {
        HStack(spacing: 8) {
          Text(model.title)
            .foregroundStyle(model.foregroundColor)
            .font(UniversalFont.mdButton.font)
          
          Spacer()
          
          if let value = model.value {
            Text(value)
              .foregroundStyle(UniversalColor.secondaryForeground.color)
              .font(UniversalFont.mdBody.font)
          }
          
          Image(systemName: "chevron.right")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 10, height: 10)
            .foregroundStyle(model.secondaryColor)
        }
        .frame(height: 44)
      },
      onTap: onTap
    )
  }
}
