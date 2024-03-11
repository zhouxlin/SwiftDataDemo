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
    @Environment(\.modelContext) private var context
    @Query(sort: (\Book.title)) private var books: [Book]
    @State private var createBook = false
    @State private var sortOrder = SortOrder.status
    var body: some View {
        NavigationStack {
            Picker("", selection: $sortOrder) {
                ForEach (SortOrder.allCases) { sortOrder in
                    Text("Sort by \(sortOrder.rawValue)").tag(sortOrder)
                }
            }
            .buttonStyle(.bordered)
            Group {
                if (books.isEmpty) {
                    ContentUnavailableView("Enter your first book", systemImage:"book.fill")
                } else {
                    List {
                        ForEach(books) { book in
                            NavigationLink {
                                EditBookView(book: book)
                            } label: {
                                HStack (spacing: 10) {
                                    book.icon
                                    VStack(alignment: .leading){
                                        Text(book.title).font(.title2)
                                        Text(book.author).foregroundStyle(.secondary)
                                        if let rating = book.rating {
                                            HStack {
                                                ForEach(1..<rating, id: \.self) {
                                                    _ in
                                                    Image(systemName: "star.fill")
                                                        .imageScale(.small)
                                                        .foregroundColor(.yellow)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .onDelete { indexSet in
                            indexSet.forEach{ index in
                                let book = books[index]
                                context.delete(book)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
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

#Preview {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    return BookListView().modelContainer(preview.container)
}
