//
//  ContentView.swift
//  MyBooks
//
//  Created by Hope on 2024/3/3.
//

import SwiftUI
import SwiftData


enum SortOrder: String, Identifiable, CaseIterable {
    case status, title, author
    
    var id: Self {
        self
    }
}
 
struct BookListView: View {

    @State private var createBook = false
    @State private var sortOrder = SortOrder.status
    @State private var filter = ""
    
    var body: some View {
        NavigationStack {
            Picker("", selection: $sortOrder) {
                ForEach (SortOrder.allCases) { sortOrder in
                    Text("Sort by \(sortOrder.rawValue)").tag(sortOrder)
                }
            }
            .buttonStyle(.bordered)
            BookList(sortOrder: sortOrder, filterString: filter)
                .searchable(text: $filter, prompt: "filter on title or author")
            .navigationTitle("My Books")
            .toolbar{
                Button{
                    createBook = true
                }label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
            }
        }
        .sheet(isPresented: $createBook) {
            NewBookView()
        }
        .presentationDetents([.medium])
    }
}

#Preview("English") {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    preview.addExamples(Genre.sampleGenres)
    return BookListView().modelContainer(preview.container)
}
#Preview("Chiness") {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    preview.addExamples(Genre.sampleGenres)
    return BookListView().modelContainer(preview.container)
        .environment(\.locale, Locale(identifier: "zh-Hans"))
}
