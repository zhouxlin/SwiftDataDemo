//
//  GenresStackvView.swift
//  MyBooks
//
//  Created by Hope on 2024/4/2.
//

import SwiftUI

struct GenresStackvView: View {
    var genres: [Genre]
    var body: some View {
        HStack {
            ForEach(genres.sorted(using: KeyPathComparator(\Genre.name))) { genre in
                Text(genre.name)
                    .font(.caption)
                    .foregroundStyle(.white)
                    .padding(5)
                    .background(RoundedRectangle(cornerRadius: 5).fill(genre.hexColor))
                
            }
        }
    }
}

//#Preview {
//    GenresStackvView()
//}
