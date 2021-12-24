//
//  Splash.swift
//  Pods
//
//  Created by Stavros Pachoundakis on 2021-12-24.
//

import Foundation
import SwiftUI
import SSSwiftUIGIFView
struct Splash: View {
    @State var animate = false
    @State var endSplash = false
    
    var body: some View {
        ZStack {
            
            
            ZStack {
                
                SwiftUIGIFPlayerView(gifName: "mark")
//
                    .frame(width: UIScreen.main.bounds.width)
            }
 
        }
    }
    

}
