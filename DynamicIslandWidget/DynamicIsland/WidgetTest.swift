//
//  WidgetTest.swift
//  WidgetTestApp
//
//  Created by Иван Марин on 24.04.2023.
//

import ActivityKit
import SwiftUI
import WidgetKit
import WidgetTestCommonModels

//Target Membership for this file: Widget Extension

@main
struct WidgetTest: WidgetBundle {
    var body: some Widget {
        viZoneStatusWidget()
    }
}

struct viZoneStatusWidget: Widget {

    @State var progressValue: CGFloat = 0.1

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DynamicIslandAttributes.self) { context in
            let model = WidgetStateModel(
                state: WidgetState(rawValue: context.state.dynamicIslandState) ?? .waitForResponse,
                message: context.state.message,
                hex: context.state.hex,
                time: context.state.time
            )
            
            // Lock screen/banner UI goes here
            loackScreenView(model: model)
            
        } dynamicIsland: { context in
            let model = WidgetStateModel(
                state: WidgetState(rawValue: context.state.dynamicIslandState) ?? .waitForResponse,
                message: context.state.message,
                hex: context.state.hex,
                time: context.state.time
            )

            return DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    dynamicIslandExpandedLeadingView(model: model)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    dynamicIslandExpandedTrailingView(model: model)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    dynamicIslandExpandedBottomView(model: model)
                }
                .contentMargins(.all, 40)
            } compactLeading: {
                compactLeadingView(model: model)
            } compactTrailing: {
                compactTrailingView(model: model)
            } minimal: {
                minimalView(width: 25, height: 25, model: model)
            }
        }
    }
}

// MARK: - Private Methods

extension viZoneStatusWidget {
    
    // MARK: - Views
    // Lock Screen Widget
    func loackScreenView(model: WidgetStateModel) -> some View {
        LockScreenWidgetView(contextState: model, progressValue: self.progressValue)
    }
    
    //MARK: Expanded Views
    // Left views
    @ViewBuilder func dynamicIslandExpandedLeadingView(model: WidgetStateModel) -> some View {
        
        StatusCodeView(contextState: model)
    }
    
    // Right Views
    @ViewBuilder func dynamicIslandExpandedTrailingView(model: WidgetStateModel) -> some View {
        switch model.state {
        case .error, .warning, .ok:
            StateMessageView(contextState: model)
        case .waitForResponse:
            CustomProgressView(progress: self.$progressValue, frameWidth: 75, lineWidth: 12)
                .padding(10)
        }
    }
    // Bottom Views
    func dynamicIslandExpandedBottomView(model: WidgetStateModel) -> some View {
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
    func compactLeadingView(model: WidgetStateModel) -> some View {
        HStack{
            
            switch model.state {
            case .error, .warning, .ok:
                CompactLeadingView(contextState: model)
            case .waitForResponse:
                CompactLeadingView(contextState: model)
                CustomProgressView(progress: self.$progressValue, frameWidth: 17, lineWidth: 5)
                    
            }
        }
    }

    func compactTrailingView(model: WidgetStateModel) -> some View {
        HStack {
            StateMessageView(contextState: model)
        }
        .padding(5)
    }
    
    func minimalView(width: CGFloat, height: CGFloat, model: WidgetStateModel) -> some View {
        NavigationLink(destination: EmptyView()) {
            switch model.state {
            case .error, .warning, .ok:
                IconWidgetView(contextState: model, frameWidth: width, frameHeight: height)
            case .waitForResponse:
                CustomProgressView(progress: self.$progressValue, frameWidth: 20, lineWidth: 5)
                    .padding(2)
            }
        }
    }
}

// MARK: - SwiftUIView_Previews

#if DEBUG

@available(iOSApplicationExtension 16.2, *)
struct LoackScreenView_Previews: PreviewProvider {
    static let status = WidgetState.waitForResponse
    static let attributes = DynamicIslandAttributes(name: "Me")
    static let contentState = DynamicIslandAttributes.ContentState(
        dynamicIslandState: status.rawValue,
        message: "Lorem ipsum",
        hex: "#800080",
        time: 10
    )

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
