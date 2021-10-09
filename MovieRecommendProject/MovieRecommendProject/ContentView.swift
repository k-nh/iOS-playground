//
//  ContentView.swift
//  MovieRecommendProject
//
//  Created by 김나희 on 2021/10/09.
//

import SwiftUI

struct ContentView: View {
    let titles = ["Netflix Style Sample App"]
    var body: some View {
        NavigationView{
            List(titles, id: \.self){
                let netflixVC = HomeViewControllerRespresentable()
                    .navigationBarBackButtonHidden(true)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                NavigationLink($0, destination: netflixVC)
            }
            .navigationTitle("SwiftUI to UIKit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
