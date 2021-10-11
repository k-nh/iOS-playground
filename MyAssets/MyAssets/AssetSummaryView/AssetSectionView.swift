//
//  AssetSectionView.swift
//  MyAssets
//
//  Created by 김나희 on 2021/10/11.
//

import SwiftUI

struct AssetSectionView: View {
    @ObservedObject var assetSection: Asset
    var body: some View {
        VStack(spacing: 20) {
            AssetSectionHeaderView(title: assetSection.type.title)
            ForEach(assetSection.data) { asset in
                HStack {
                    Text(asset.title)
                        .font(.title)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(asset.amount)
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                Divider()
            }
        }
        .padding()
    }
}

struct AssetSectionView_Previews: PreviewProvider {
    static var previews: some View {
        let asset = Asset (id: 0, type: .bankAccount, data:[ AssetData(id: 1, title: "신한은행", amount: "44.44444원"),AssetData(id: 2, title: "신한은행", amount: "44.44444원"),AssetData(id: 3, title: "신한은행", amount: "44.44444원")])
        AssetSectionView(assetSection: asset)
    }
}
