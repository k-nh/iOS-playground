//
//  AssetMenuBottonStyle.swift
//  MyAssets
//
//  Created by 김나희 on 2021/10/10.
//

import SwiftUI

struct AssetMenuBottonStyle: ButtonStyle {
    let menu: AssetMenu
    
    func makeBody(configuration: Configuration) -> some View {
        return VStack{
            Image(systemName: menu.systemImageName)
                .resizable()
                .frame(width: 30, height: 30)
                .padding([.leading, .trailing], 10)
            Text(menu.title)
                .font(.system(size: 12, weight: .bold))
        }
        .padding()
        .foregroundColor(.blue)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct AssetMenuBottonStyle_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 24){
            Button(""){
                print("")
            }
            .buttonStyle(AssetMenuBottonStyle(menu: .creditScore))
            
            Button(""){
                print("")
            }
            .buttonStyle(AssetMenuBottonStyle(menu: .bankAccount))
            
            Button(""){
                print("")
            }
            .buttonStyle(AssetMenuBottonStyle(menu: .creditCard))
            
            Button(""){
                print("")
            }
            .buttonStyle(AssetMenuBottonStyle(menu: .cash))
        }
        .background(Color.gray.opacity(0.2))
    }
}
