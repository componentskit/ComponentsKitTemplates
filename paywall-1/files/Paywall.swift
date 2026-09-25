import ComponentsKit
import SwiftUI

// MARK: - ViewModel

@Observable
class PaywallVM {
  enum Duration {
    case monthly
    case annual
  }
  
  var selectedDuration: Duration = .monthly
  
  var monthlyOptionVM: SubscriptionOptionVM {
    return .init(
      title: "Monthly",
      price: "$9.99",
      pricePerMonth: "$9.99",
      isSelected: selectedDuration == .monthly
    )
  }
  var annualOptionVM: SubscriptionOptionVM {
    return .init(
      title: "Annual",
      price: "$79.99",
      pricePerMonth: "$6.66",
      isSelected: selectedDuration == .annual
    )
  }
  var benefitVMs: [SubscriptionBenefitVM] {
    return [
      .init(
        title: "Unlimited AI Generations",
        subtitle: "Create without limits – whenever inspiration strikes.",
        icon: "magic-stick"
      ),
      .init(
        title: "Full Access to All Content",
        subtitle: "Explore premium templates, guides, and resources.",
        icon: "notebook"
      ),
      .init(
        title: "Smart Workflows & Plans",
        subtitle: "Automate tasks and get personalized suggestions.",
        icon: "academic-cap"
      ),
    ]
  }
  var subscriptionSummary: String {
    let trialDuration = switch selectedDuration {
    case .monthly: "3 days"
    case .annual: "7 days"
    }
    let price = switch selectedDuration {
    case .monthly: "$9.99 / month"
    case .annual: "$79.99 / year"
    }
    return "\(trialDuration) free, then renews automatically at \(price)\nCancel anytime."
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
        .font(UniversalFont.lgHeadline.font)
        .padding(.top, 12)
      
      HStack {
        SubscriptionOption(
          model: model.monthlyOptionVM,
          didTapOption: model.didTapMonthlyOption
        )
        SubscriptionOption(
          model: model.annualOptionVM,
          didTapOption: model.didTapAnnualOption
        )
      }
      .padding(.top, 16)
      .animation(.linear(duration: 0.1), value: model.selectedDuration)
      
      Spacer()
      
      Text("Why Go Premium?")
        .foregroundStyle(UniversalColor.foreground.color)
        .font(UniversalFont.lgHeadline.font)
        .padding(.top, 12)
      
      LazyVStack(alignment: .leading, spacing: 0) {
        ForEach(model.benefitVMs, id: \.self) { model in
          SubscriptionBenefit(model: model)
            .padding(.top, 24)
        }
      }
      
      Spacer()
      Spacer()
      
      SUButton(
        model: .init {
          $0.title = "Start Free Trial"
          $0.color = .accent
          $0.isFullWidth = true
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
