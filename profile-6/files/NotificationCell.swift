import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct NotificationCellVM: Hashable {
  let title: String
  let subtitle: String
  let isSelected: Bool
  
  var borderColor: UniversalColor {
    isSelected ? .accent : .clear
  }
  var backgroundColor: UniversalColor {
    isSelected ? .accentBackground : .secondaryBackground
  }
}

// MARK: - View

struct NotificationCell: View {
  let model: NotificationCellVM
  let onTap: () -> Void
  
  var body: some View {
    SUCard(
      model: .init {
        $0.animationScale = .none
        $0.backgroundColor = model.backgroundColor
        $0.borderColor = model.borderColor
        $0.cornerRadius = .small
        $0.isTappable = true
        $0.shadow = .none
      },
      content: {
        HStack {
          VStack(alignment: .leading, spacing: 12) {
            HStack {
              Text(model.title)
                .foregroundStyle(UniversalColor.foreground.color)
                .font(UniversalFont.mdHeadline.font)
              
              Spacer()
              
              SUCheckbox(
                isSelected: .init(
                  get: { model.isSelected },
                  set: { _ in onTap() }
                ),
                model: .init {
                  $0.size = .large
                  $0.color = .accent
                  $0.cornerRadius = .full
                }
              )
            }
            Text(model.subtitle)
              .foregroundStyle(UniversalColor.secondaryForeground.color)
              .font(UniversalFont.mdCaption.font)
          }
        }
        .frame(maxWidth: .infinity)
      },
      onTap: onTap
    )
  }
}
