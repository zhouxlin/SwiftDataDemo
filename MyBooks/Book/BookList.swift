//
//  BookList.swift
//  MyBooks
//
//  Created by Hope on 2024/3/11.
//

import SwiftUI
import SwiftData

struct BookList: View {
    @Environment(\.modelContext) private var context
    @Query private var books: [Book]
    
    init(sortOrder: SortOrder, filterString: String) {
        let sortDescriptors: [SortDescriptor<Book>] = switch sortOrder {
        case .status:
            [SortDescriptor(\Book.status), SortDescriptor(\Book.title)]
        case .title:
            [SortDescriptor(\Book.title)]
        case .author:
            [SortDescriptor(\Book.author)]
        }
        let predicate = #Predicate<Book> { book in
            book.title.localizedStandardContains(filterString)
            || book.author.localizedStandardContains(filterString)
            || filterString.isEmpty
        }
        _books = Query(filter: predicate ,sort: sortDescriptors)
    }
    var body: some View {
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
                                    if let genres = book.genres {
                                        ViewThatFits {
                                            ScrollView(.horizontal, showsIndicators: false) {
                                                GenresStackvView(genres: genres)
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
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    preview.addExamples(Genre.sampleGenres)
    return NavigationStack {
        BookList(sortOrder: .author, filterString: "")
    }
    .modelContainer(preview.container)
}
