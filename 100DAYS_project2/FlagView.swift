//
//  FlagView.swift
//  100DAYS_project2
//
//  Created by Taras Kyparenko on 6/4/2023.
//

import SwiftUI

struct FlagImage: View {
    let name: String
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .shadow(radius: 5)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(name: "France")
    }
}
