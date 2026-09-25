import ComponentsKit
import SwiftUI

struct Profile: View {
  @Bindable var model = ProfileVM()
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack {
      ScrollView(showsIndicators: false) {
        LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
          userInfoSection
            .padding(.horizontal)
            .padding(.top)
          
          Section(
            header:
              ScrollableSegmentControl(
                items: ProfileVM.Page.allCases,
                selected: $model.selectedPage
              )
              .background(UniversalColor.background.color)
          ) {
            sectionContent
              .padding(.horizontal)
          }
        }
        .padding(.bottom, model.bottomGradientOverlayHeight)
      }
      .overlay(alignment: .bottom) { bottomGradientOverlay }
      .padding(.bottom)
      .background(UniversalColor.background.color)
      .toolbar {
        ToolbarItem(placement: .principal) {
          Text("Account")
            .foregroundStyle(UniversalColor.foreground.color)
            .font(UniversalFont.mdHeadline.font)
        }
        ToolbarItem(placement: .navigationBarLeading) {
          SUButton(
            model: .init {
              $0.image = .init(systemName: "chevron.left")
              $0.color = .accent
              $0.style = .minimal
              $0.size = .large
            },
            action: { dismiss() }
          )
        }
      }
      .navigationBarTitleDisplayMode(.inline)
    }
  }
  
  @ViewBuilder
  var sectionContent: some View {
    VStack(spacing: 24) {
      ForEach(model.currentSections, id: \.self) { section in
        VStack(spacing: 12) {
          if let title = section.title {
            HStack {
              Text(title)
                .foregroundStyle(UniversalColor.foreground.color)
                .font(UniversalFont.mdHeadline.font)
              Spacer()
            }
          }
          
          VStack(spacing: section.spacing) {
            ForEach(section.cells, id: \.self) { cell in
              cellView(for: cell)
            }
          }
        }
      }
    }
    .padding(.top, 20)
  }
  
  @ViewBuilder
  private func cellView(for cell: ProfileVM.Cell) -> some View {
    switch cell {
    case .progressBanner(let kind):
      ProgressBanner(
        model: model.progressBannerVM(for: kind),
        onTap: { model.didTapProgressBannerCell(kind) }
      )
      
    case .destination(let kind):
      DestinationCell(
        model: model.destinationCellVM(for: kind),
        onTap: { model.didTapDestinationCell(kind) }
      )
      
    case .copy(let kind):
      CopyCell(
        model: model.copyCellVM(for: kind),
        onTap: { model.didTapCopyCell(kind) }
      )
      
    case .toggle(let kind):
      ToggleCell(
        model: model.toggleCellVM(for: kind),
        onTap: { model.didTapToggleCell(kind) }
      )
      
    case .notification(let kind):
      NotificationCell(
        model: model.notificationsVM(for: kind),
        onTap: { model.selectedNotificationType = kind }
      )
    }
  }
  
  // MARK: UserInfo
  
  var userInfoSection: some View {
    SUCard(model: .init {
      $0.backgroundColor = .secondaryBackground
      $0.borderWidth = .none
      $0.shadow = .none
    }) {
      VStack(spacing: 16) {
        HStack(alignment: .center, spacing: 16) {
          ZStack {
            SUCircularProgress(model: .init {
              $0.size = .medium
              $0.currentValue = 100
              $0.lineWidth = 4
            })
            SUAvatar(model: .init {
              $0.imageSrc = .local(.init("avatar"))
              $0.size = .medium
            })
          }
          
          Text("kenzi***@gmail.com")
            .foregroundStyle(UniversalColor.foreground.color)
            .font(UniversalFont.lgHeadline.font)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
          
          Spacer()
        }
        SUButton(
          model: .init {
            $0.title = "Edit Profile"
            $0.color = .accent
            $0.isFullWidth = true
            $0.cornerRadius = .large
          },
          action: model.didTapEditProfile
        )
      }
    }
  }
  
  // MARK: BottomGradientOverlay
  
  var bottomGradientOverlay: some View {
    LinearGradient(
      gradient: Gradient(colors: [
        Color.clear,
        UniversalColor.background.color,
      ]),
      startPoint: .top,
      endPoint: .bottom
    )
    .frame(height: model.bottomGradientOverlayHeight)
  }
}
