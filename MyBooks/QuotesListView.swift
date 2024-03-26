//
//  QoutesListView.swift
//  MyBooks
//
//  Created by Hope on 2024/3/16.
//

import SwiftUI

struct QuotesListView: View {
    @Environment(\.modelContext) private var modelContext
    let book: Book
    @State private var text: String = ""
    @State private var page: String = ""
    @State private var seletedQuote: Quote?
    var isEditing: Bool {
        seletedQuote != nil
    }
    var body: some View {
        GroupBox {
            HStack {
                LabeledContent("Page") {
                    TextField("Page #", text: $page)
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)
                        .frame(width:150)
                    Spacer()
                }
                if isEditing {
                    Button("Cancle") {
                        page = ""
                        text = ""
                        seletedQuote = nil
                    }
                    .buttonStyle(.bordered)
                }
                Button(isEditing ? "Update" : "Create") {
                    if isEditing {
                        seletedQuote?.page = page.isEmpty ? nil : page
                        seletedQuote?.text = text
                        page = ""
                        text = ""
                        seletedQuote = nil
                    } else {
                        let qoute = page.isEmpty ? Quote(text: text) : Quote(text: text, page: page)
                        book.quotes?.append(qoute)
                        text = ""
                        page = ""
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(text.isEmpty)
            }
            TextEditor(text: $text)
                .border(Color.secondary)
                .frame(height:100)
        }
        .padding(.horizontal)
        List {
            if let sortedQuotes = book.quotes {
                ForEach(sortedQuotes) { quote in
                    VStack(alignment: .leading) {
                        Text(quote.createdDate, format: .dateTime.month().day().year())
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(quote.text)
                        HStack {
                            Spacer()
                            if let page = quote.page, !page.isEmpty {
                                Text("Page: \(page)")
                            }
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        seletedQuote = quote
                        text = quote.text
                        page = quote.page ?? ""
                    }
                }
                .onDelete { indexSet in
                    withAnimation {
                        indexSet.forEach { index in
                            if let quote = book.quotes?[index] {
                                modelContext.delete(quote)
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.plain )
        .navigationTitle("Quotes")
    }
}

#Preview {
    let preview = Preview(Book.self)
    let books = Book.sampleBooks
    preview.addExamples(books)
    return NavigationStack {
        QuotesListView(book: books[4])
            .navigationBarTitleDisplayMode(.inline)
            .modelContainer(preview.container)
    }
}
