//
//  GenresView.swift
//  MyBooks
//
//  Created by Hope on 2024/3/30.
//

import SwiftUI
import SwiftData

struct GenresView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Bindable var book: Book
    @Query(sort: \Genre.name) var genres: [Genre]
    @State private var newGenre = false
    
    var body: some View {
        NavigationStack {
            Group {
                if genres.isEmpty {
                    ContentUnavailableView {
                            Image(systemName: "bookmark.fill")
                                .font(.largeTitle)
                    } description: {
                        Text("You need to create some genres first.")
                    } actions: {
                        Button("Create Genre") {
                            newGenre.toggle()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    List {
                        ForEach(genres) { genre in
                            HStack {
                                if let bookGenres = book.genres {
                                    if bookGenres.isEmpty {
                                        Button {
                                            addRemove(genre)
                                        } label: {
                                            Image(systemName: "cicle")
                                        }
                                        .foregroundStyle(genre.hexColor)
                                    } else {
                                        Button {
                                            addRemove(genre)
                                        } label: {
                                            Image(systemName: bookGenres.contains(genre) ? "circle.fill":"circle")
                                        }
                                        .foregroundStyle(genre.hexColor)
                                    }
                                }
                                Text(genre.name)
                            }
                        }
                        LabeledContent {
                            Button {
                                newGenre.toggle()
                            } label: {
                                Image(systemName: "plus.cicle.fill")
                                    .imageScale(.large)
                            }
                        } label: {
                            Text("Create a new genre").font(.caption).foregroundStyle(.secondary)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle(book.title)
            .sheet(isPresented: $newGenre) {
                NewGenreView()
            }
        }
    }
    
    func addRemove(_ genre: Genre) {
        if let bookGenres = book.genres {
            if bookGenres.isEmpty {
                book.genres?.append(genre)
            } else {
                if bookGenres.contains(genre), let index = bookGenres.firstIndex(where: {$0.id == genre.id}){
                    book.genres?.remove(at: index)
                } else {
                    book.genres?.append(genre)
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    let books = Book.sampleBooks
//    let genres = Genre.sampleGenres
    preview.addExamples(books)
//    preview.addExamples(Genre.sampleGenres)
//    books[1].genres?.append(genres[0] )
    return GenresView(book: books[1]).modelContainer(preview.container)
}
