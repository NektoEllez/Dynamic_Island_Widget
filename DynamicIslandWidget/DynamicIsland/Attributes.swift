//
//  Attributes.swift
//  WidgetTestApp
//
//  Created by Иван Марин on 24.04.2023.
//

import ActivityKit
import WidgetKit
import SwiftUI

//Target Membership for this file: UIKit App + Widget Exension

@available(iOS 16.1, *)
struct DynamicIslandAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        //You can append your changable parameters in ContentState. And call it "context.state.YOUR_PARAMETER_NAME"
        var stateCode: String
    }
    
    //You can append not changable parametrs here. And call it "context.attributes.YOUR_PARAMETER_NAME"
    var name: String
}
