//
//  WidgetTest.swift
//  WidgetTestApp
//
//  Created by Иван Марин on 24.04.2023.
//

import ActivityKit
import SwiftUI
import WidgetKit

//Target Membership for this file: Widget Exension

@main
struct WidgetTest: WidgetBundle {
    var body: some Widget {
        viZoneStatusWidget()
    }
}

struct viZoneStatusWidget: Widget {

    @State var progressValue: CGFloat = 0.25
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DynamicIslandAttributes.self) { context in
            let state = WidgetState(rawValue: context.state.stateCode) ?? .waitForResponse
            
            // Lock screen/banner UI goes here
            loackScreenView(state: state)
            
        } dynamicIsland: { context in
            let state = WidgetState(rawValue: context.state.stateCode) ?? .waitForResponse
            
            return DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    dynamicIslandExpandedLeadingView(state: state)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    dynamicIslandExpandedTrailingView(state: state)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    dynamicIslandExpandedBottomView(state: state)
                }
                .contentMargins(.all, 40)
            } compactLeading: {
                compactLeadingView(state: state)
            } compactTrailing: {
                compactTrailingView(state: state)
            } minimal: {
                minimalView(width: 25, height: 25, state: state)
            }
        }
    }
}

// MARK: - Private Methods

extension viZoneStatusWidget {
    
    // MARK: - Views
    // Lock Screen Widget
    func loackScreenView(state: WidgetState) -> some View {
        HStack(alignment: .center) {
            VStack(alignment: .center) {
                Spacer(minLength: 20)
                
                Text(
                    Date().addingTimeInterval(0),
                    style: .relative
                )
                .font(.system(.title).bold())
                .minimumScaleFactor(0.2)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                
                HStack {
                    Image("viZoneIconWidget")
                        .colorMultiply(state.messageColor)
                    Text(state.message)
                        .font(Font.system(.body, design: .monospaced))
                        .minimumScaleFactor(0.2)
                        .lineLimit(1)
                }
                .scaledToFit()
                Spacer(minLength: 20)
            }
        }
    }
    
    //MARK: Expanded Views
    // Left views
    @ViewBuilder func dynamicIslandExpandedLeadingView(state: WidgetState) -> some View {
        StatusCodeView(contextState: state)
    }
    
    // Right Views
    @ViewBuilder func dynamicIslandExpandedTrailingView(state: WidgetState) -> some View {
        switch state {
        case .error:
            StateMessageView(contextState: state)
        case .warning:
            StateMessageView(contextState: state)
        case .ok:
            StateMessageView(contextState: state)
        case .waitForResponse:
            CustomProgressView(progress: self.$progressValue)
        }
    }
    // Bottom Views
    func dynamicIslandExpandedBottomView(state: WidgetState) -> some View {
            Text(
                Date().addingTimeInterval(0),
                style: .relative
            )
            .font(.system(.title).bold())
            .minimumScaleFactor(0.4)
            .multilineTextAlignment(.center)
            .lineLimit(1)
    }
    
    //MARK: Compact Views
    func compactLeadingView(state: WidgetState) -> some View {
        CompactLeadingView(contextState: state)
    }
    
    func compactTrailingView(state: WidgetState) -> some View {
        HStack {
            Text(state.message)
                .scaledToFit()
                .minimumScaleFactor(0.2)
                .lineLimit(1)
            
            Spacer()
        }
    }
    
    func minimalView(width: CGFloat, height: CGFloat, state: WidgetState) -> some View {
        NavigationLink(destination: EmptyView()) {
            IconWidgetView(contextState: state, frameWidth: width, frameHeight: height)
        }
    }
}

// MARK: - SwiftUIView_Previews

#if DEBUG

@available(iOSApplicationExtension 16.2, *)
struct LoackScreenView_Previews: PreviewProvider {
    static let status = WidgetState.waitForResponse
    static let attributes = DynamicIslandAttributes(name: "Me")
    static let contentState = DynamicIslandAttributes.ContentState(stateCode: status.rawValue)
    
    static var previews: some View {
        Group {
            attributes
                .previewContext(contentState, viewKind: .dynamicIsland(.compact))
                .previewDisplayName("Island Compact")
            attributes
                .previewContext(contentState, viewKind: .dynamicIsland(.expanded))
                .previewDisplayName("Island Expanded")
            attributes
                .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
                .previewDisplayName("Minimal")
            attributes
                .previewContext(contentState, viewKind: .content)
                .previewDisplayName("Notification")
        }
    }
}
#endif
