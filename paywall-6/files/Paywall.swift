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
  
  var subscribeButtonTitle: String {
    switch selectedDuration {
    case .monthly:
      return "Start 3 days free trial"
    case .annual:
      return "Start 7 days free trial"
    }
  }
  var monthlyOptionVM: SubscriptionOptionVM {
    return .init(
      title: "Monthly",
      period: "1 month",
      price: "$9.99",
      pricePerMonth: "$9.99 / month",
      isSelected: selectedDuration == .monthly
    )
  }
  var annualOptionVM: SubscriptionOptionVM {
    return .init(
      title: "Annual",
      period: "12 months",
      price: "$79.99",
      pricePerMonth: "$6.66 / month",
      isSelected: selectedDuration == .annual
    )
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
    return "\(trialDuration) free, then renews automatically at \(price). Cancel anytime."
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
    VStack(spacing: 0) {
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
      
      Spacer()
      
      Image("background")
        .resizable()
        .aspectRatio(1.0, contentMode: .fit)
        .frame(minHeight: 150, maxHeight: 200)
      
      Text("PREMIUM")
        .font(UniversalFont.smButton.font)
        .foregroundStyle(UniversalColor.accent.color)
        .multilineTextAlignment(.center)
        .padding(.top, 24)
      
      Text("Upgrade to Premium")
        .foregroundStyle(UniversalColor.foreground.color)
        .font(UniversalFont.lgHeadline.withSize(35).font)
        .multilineTextAlignment(.center)
        .padding(.top, 8)
      
      Text("Unlock full power mode: advanced tools, priority features, and unlimited usage — all in one simple plan.")
        .foregroundStyle(UniversalColor.secondaryForeground.color)
        .font(UniversalFont.smBody.font)
        .multilineTextAlignment(.center)
        .padding(.top, 12)
      
      Spacer()
      
      VStack(spacing: 12) {
        SubscriptionOption(
          model: model.annualOptionVM,
          didTapOption: model.didTapAnnualOption
        )
        SubscriptionOption(
          model: model.monthlyOptionVM,
          didTapOption: model.didTapMonthlyOption
        )
      }
      .animation(.linear(duration: 0.1), value: model.selectedDuration)
      
      Spacer()
      
      SUButton(
        model: .init {
          $0.title = model.subscribeButtonTitle
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
