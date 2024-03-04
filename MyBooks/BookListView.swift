//
//  ContentView.swift
//  MyBooks
//
//  Created by Hope on 2024/3/3.
//

import SwiftUI

struct BookListView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            .navigationTitle("My Books")
            .toolbar{
                Button{
                    
                }label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
            }
        }
    }
}

#Preview {
    BookListView()
}
