import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct ProgressBannerVM: Hashable {
  let title: String
  let value: String
  let progressState: ProgressState
  
  enum ProgressState: Hashable {
    case completed
    case incomplete(current: Int, total: Int)
  }
  
  var color: ComponentColor {
    switch progressState {
    case .completed:
      return .success
    case .incomplete:
      return .warning
    }
  }
}

// MARK: - View

struct ProgressBanner: View {
  let model: ProgressBannerVM
  let onTap: () -> Void
  
  var body: some View {
    SUCard(
      model: .init {
        $0.animationScale = .small
        $0.backgroundColor = model.color.background
        $0.borderWidth = .medium
        $0.shadow = .none
        $0.borderColor = model.color.main
        $0.cornerRadius = .small
        $0.contentPaddings = .init(horizontal: 16, vertical: 12)
        $0.isTappable = true
      },
      content: {
        HStack(spacing: 16) {
          if case let .incomplete(current, total) = model.progressState {
            SUCircularProgress(model: .init {
              $0.size = .small
              $0.currentValue = (Double(current) / Double(total)) * 100.0
              $0.lineWidth = 4
              $0.color = .init(
                main: model.color.main,
                contrast: model.color.contrast,
                background: .background
              )
              $0.label = "\(current)/\(total)"
              $0.font = .mdCaption
            })
          }
          
          VStack(alignment: .leading, spacing: 8) {
            Text(model.title)
              .foregroundStyle(UniversalColor.secondaryForeground.color)
              .font(UniversalFont.smButton.font)
            
            Text(model.value)
              .foregroundStyle(model.color.main.color)
              .font(UniversalFont.mdButton.font)
          }
          
          Spacer()
          
          SUButton(model: .init {
            $0.color = .init(
              main: .background,
              contrast: model.color.main
            )
            $0.cornerRadius = .full
            $0.image = .init(systemName: "chevron.right")
            $0.size = .small
            $0.style = .filled
          })
        }
      },
      onTap: onTap
    )
  }
}
