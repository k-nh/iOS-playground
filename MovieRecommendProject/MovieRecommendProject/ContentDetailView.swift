//
//  ContentDetailView.swift
//  MovieRecommendProject
//
//  Created by 김나희 on 2021/10/09.
//

import SwiftUI

struct ContentDetailView: View {
    @State var item: Item?
    var body: some View {
        VStack{
            if let item = item {
                Image(uiImage: item.image)
                    .aspectRatio(contentMode: .fit)
                Text(item.description)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                Color.white
            }
        }
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let item0 = Item(description: "흥미", imageName: "poster0")
        ContentDetailView(item: item0)
    }
}
