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
  var isTrialSelected: Bool = true
  
  var monthlyOptionVM: SubscriptionOptionVM {
    return .init(
      duration: "Monthly",
      price: "$9.99",
      pricePerMonth: "$9.99 / month",
      isSelected: selectedDuration == .monthly
    )
  }
  var annualOptionVM: SubscriptionOptionVM {
    return .init(
      duration: "Yearly",
      price: "$79.99",
      pricePerMonth: "only $6.6 / month",
      isSelected: selectedDuration == .annual
    )
  }
  var subscriptionSummary: String {
    let price = switch selectedDuration {
    case .monthly: "$9.99 per month"
    case .annual: "$79.99 per year"
    }
    if isTrialSelected {
      let trialDuration = switch selectedDuration {
      case .monthly: "3 days"
      case .annual: "7 days"
      }
      return "\(trialDuration) free, then renews automatically at \(price). Cancel anytime."
    } else {
      return "Renews automatically at \(price).\nCancel anytime."
    }
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
  @Bindable var model = PaywallVM()
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ZStack(alignment: .top) {
      Image("background")
        .resizable()
        .aspectRatio(contentMode: .fit)
      
      VStack {
        HStack {
          Spacer()
          SUButton(model: .init {
            $0.color = .init(main: .background, contrast: .accent)
            $0.cornerRadius = .full
            $0.image = .init(systemName: "xmark")
            $0.size = .small
            $0.style = .filled
          }) {
            dismiss()
          }
        }
        
        Spacer()
        
        SUCard(model: .init {
          $0.borderWidth = .none
          $0.cornerRadius = .large
          $0.shadow = .none
        }) {
          VStack(spacing: 0) {
            Text("PREMIUM")
              .font(UniversalFont.smButton.font)
              .foregroundStyle(UniversalColor.accent.color)
              .multilineTextAlignment(.center)
            
            Text("Subscribe to Premium")
              .foregroundStyle(UniversalColor.foreground.color)
              .font(UniversalFont.lgHeadline.withSize(40).font)
              .multilineTextAlignment(.center)
              .padding(.top, 8)
            
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
            .fixedSize(horizontal: false, vertical: true)
            .padding(.top, 35)
            .animation(.linear(duration: 0.1), value: model.selectedDuration)
            
            TrialOption(isTrialSelected: $model.isTrialSelected)
              .padding(.top, 16)
            
            SUButton(
              model: .init {
                $0.title = "Continue"
                $0.color = .accent
                $0.isFullWidth = true
                $0.cornerRadius = .large
                $0.size = .large
              },
              action: model.didTapSubscribeButton
            )
            .padding(.top, 16)
            
            Text(model.subscriptionSummary)
              .foregroundStyle(UniversalColor.secondaryForeground.color)
              .font(UniversalFont.mdCaption.font)
              .multilineTextAlignment(.center)
              .frame(maxWidth: .infinity)
              .padding(.top, 12)
          }
        }
      }
      .padding()
    }
    .frame(maxWidth: .infinity)
    .background(UniversalColor.accentBackground.color)
  }
}
