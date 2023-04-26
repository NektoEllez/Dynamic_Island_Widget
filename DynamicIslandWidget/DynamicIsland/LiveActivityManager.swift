//
//  LiveActivityManager.swift
//  WidgetTestApp
//
//  Created by Иван Марин on 24.04.2023.
//

import Foundation
import ActivityKit

//Target Membership for this file: UIKit App + Widget Exension

class LiveActivityManager: ObservableObject {
    
    @Published var activity: Activity<DynamicIslandAttributes>?

    // MARK: - STARTING

    func startActivity(_ state: String) {
        Task {
            let attributes = DynamicIslandAttributes(name: "viZone")
            let state = DynamicIslandAttributes.ContentState(stateCode: state)
            do {
                let activity = try Activity<DynamicIslandAttributes>.request(
                    attributes: attributes,
                    contentState: state,
                    pushType: nil
                )
                self.activity = activity
            } catch let error {
                print("Error starting activity \(error) \(error.localizedDescription)")
            }
        }
    }

    // MARK: - UPDATING

    func updateActivity(_ state: String) {
        Task {
            let updatedStatus = DynamicIslandAttributes.ContentState(stateCode: state)
            for activtiy in Activity<DynamicIslandAttributes>.activities {
                await activtiy.update(using: updatedStatus)
            }
        }
    }

    // MARK: - STOPPING

    func stopActivity() {
        //If you terminate app, and reopen, you need delete previous activities. Loop is used for this
        Task {
            for activity in Activity<DynamicIslandAttributes>.activities {
                await activity.end(dismissalPolicy: .immediate)
            }
        }
    }
}
