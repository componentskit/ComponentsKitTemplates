import ComponentsKit
import SwiftUI

// MARK: - ViewModel

@Observable
class PaywallVM {
  enum Duration {
    case weekly
    case monthly
    case annual
  }
  
  var selectedDuration: Duration = .monthly
  
  var weeklyOptionVM: SubscriptionOptionVM {
    return .init(
      title: "Weekly",
      price: "$9.99",
      badge: nil,
      isSelected: selectedDuration == .weekly
    )
  }
  var monthlyOptionVM: SubscriptionOptionVM {
    return .init(
      title: "Monthly",
      price: "$19.99",
      badge: nil,
      isSelected: selectedDuration == .monthly
    )
  }
  var annualOptionVM: SubscriptionOptionVM {
    return .init(
      title: "Annual",
      price: "$199.99",
      badge: .init {
        $0.title = "SAVE 60%"
        $0.color = .accent
        $0.cornerRadius = .full
        $0.style = .light
      },
      isSelected: selectedDuration == .annual
    )
  }
  var benefitVMs: [SubscriptionBenefitVM] {
    return [
      .init(
        subtitle: "Learn naturally with real-life conversation practice",
        icon: "user-speak"
      ),
      .init(
        subtitle: "Access grammar tips, quizzes, and word games",
        icon: "gamepad"
      ),
      .init(
        subtitle: "Track fluency progress with personalized learning paths",
        icon: "routing"
      ),
    ]
  }
  var subscriptionSummary: String {
    let trialDuration = switch selectedDuration {
    case .weekly: "3 days"
    case .monthly: "1 week"
    case .annual: "2 weeks"
    }
    let price = switch selectedDuration {
    case .weekly: "$9.99 / week"
    case .monthly: "$19.99 / month"
    case .annual: "$199.99 / year"
    }
    return "\(trialDuration) free, then renews automatically at \(price)\nCancel anytime."
  }
  
  func didTapWeeklyOption() {
    selectedDuration = .weekly
  }
  func didTapMonthlyOption() {
    selectedDuration = .monthly
  }
  func didTapAnnualOption() {
    selectedDuration = .annual
  }
  func didTapSubscribeButton() {
    /* handle subscribe button tap */
  }
}

// MARK: - View

struct Paywall: View {
  let model = PaywallVM()
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack {
        Spacer()
        SUButton(model: .init {
          $0.image = .init(systemName: "xmark")
          $0.color = .accent
          $0.style = .minimal
          $0.size = .small
        }) {
          dismiss()
        }
      }
      
      Text("Subscribe to Premium")
        .foregroundStyle(UniversalColor.foreground.color)
        .font(UniversalFont.lgHeadline.withSize(40).font)
      
      Spacer()
      
      LazyVStack(alignment: .leading, spacing: 16) {
        ForEach(model.benefitVMs, id: \.self) { model in
          SubscriptionBenefit(model: model)
        }
      }
      
      Spacer()
      
      Text("Choose your plan")
        .foregroundStyle(UniversalColor.foreground.color)
        .font(UniversalFont.lgHeadline.font)
      
      VStack(spacing: 8) {
        SubscriptionOption(
          model: model.weeklyOptionVM,
          didTapOption: model.didTapWeeklyOption
        )
        SubscriptionOption(
          model: model.monthlyOptionVM,
          didTapOption: model.didTapMonthlyOption
        )
        SubscriptionOption(
          model: model.annualOptionVM,
          didTapOption: model.didTapAnnualOption
        )
      }
      .padding(.top, 12)
      .animation(.linear(duration: 0.1), value: model.selectedDuration)
      
      Spacer()
      
      SUButton(
        model: .init {
          $0.title = "Start Free Trial"
          $0.color = .accent
          $0.isFullWidth = true
          $0.cornerRadius = .large
          $0.size = .large
        },
        action: model.didTapSubscribeButton
      )
      
      Text(model.subscriptionSummary)
        .foregroundStyle(UniversalColor.secondaryForeground.color)
        .font(UniversalFont.mdCaption.font)
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        .padding(.top, 12)
    }
    .frame(maxWidth: .infinity)
    .padding()
    .background(UniversalColor.background.color)
  }
}
