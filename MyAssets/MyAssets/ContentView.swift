//
//  ContentView.swift
//  MyAssets
//
//  Created by 김나희 on 2021/10/09.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .asset
    
    enum Tab {
        case asset
        case recommend
        case alert
        case setting
    }
    var body: some View {
        TabView(selection: $selection){
            AssetView()
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("자산")
                }
                .tag(Tab.asset)
            Color.blue
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .tabItem {
                    Image(systemName: "hand.thumbsup.fill")
                    Text("추천")
                }
                .tag(Tab.recommend)
            Color.yellow
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("알림")
                }
                .tag(Tab.alert)
            Color.red
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("설정")
                }
                .tag(Tab.setting)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
