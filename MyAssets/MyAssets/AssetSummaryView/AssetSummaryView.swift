//
//  AssetSummaryView.swift
//  MyAssets
//
//  Created by 김나희 on 2021/10/11.
//

import SwiftUI

struct AssetSummaryView: View {
    @EnvironmentObject var assetData: AssetSummaryData
    var assets: [Asset] {
        return assetData.assets
    }
    var body: some View {
        VStack(spacing: 20) {
            ForEach(assets) { asset in
                switch asset.type {
                case .creditCard:
                    AssetCardSectionView(asset: asset)
                        .frame(idealHeight: 250)
                default:
                    AssetCardSectionView(asset: asset)
                }
                AssetSectionView(assetSection: asset)
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
        }
    }
}

struct AssetSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        AssetSummaryView()
            .environmentObject(AssetSummaryData())
            .background(Color.gray.opacity(0.2))
    }
}
