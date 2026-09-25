import ComponentsKit
import SwiftUI

struct ScrollableSegmentControl: View {
  @Namespace private var underlineNamespace
  
  let items: [ProfileVM.Page]
  @Binding var selected: ProfileVM.Page
  
  var body: some View {
    GeometryReader { geo in
      ScrollViewReader { proxy in
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 0) {
            ForEach(items, id: \.self) { item in
              Button {
                withAnimation(.easeInOut(duration: 0.25)) {
                  selected = item
                  proxy.scrollTo(item, anchor: .center)
                }
              } label: {
                VStack(spacing: 10) {
                  Text(item.title)
                    .font(UniversalFont.mdButton.font)
                    .foregroundColor(
                      selected == item
                      ? UniversalColor.accent.color
                      : UniversalColor.secondaryForeground.color
                    )
                    .fixedSize(horizontal: true, vertical: false)
                  
                  ZStack {
                    if selected == item {
                      Rectangle()
                        .fill(UniversalColor.accent.color)
                        .frame(height: 2)
                        .matchedGeometryEffect(
                          id: "underline",
                          in: underlineNamespace
                        )
                    } else {
                      Rectangle()
                        .fill(Color.clear)
                        .frame(height: 2)
                    }
                  }
                }
                .padding(.horizontal, 16)
              }
              .id(item)
            }
          }
          .frame(minWidth: geo.size.width)
          .background(
            Rectangle()
              .fill(UniversalColor.divider.color)
              .frame(height: 2)
              .padding(.horizontal, 16),
            alignment: .bottom
          )
        }
      }
    }
    .padding(.top, 16)
    .padding(.bottom, 20)
  }
}
