import UIKit

var words = """
         "Author" : {

         },
         "Back" : {

         },
         "Cancel" : {

         },
         "Cancle" : {

         },
         "Create" : {

         },
         "Create a new genre" : {

         },
         "Create Genre" : {

         },
         "Date Added" : {

         },
         "Date Completed" : {

         },
         "Date Started" : {

         },
         "Enter your first book" : {

         },
         "filter on title or author" : {

         },
         "Genres" : {

         },
         "My Books" : {

         },
         "name" : {

         },
         "New a book" : {

         },
         "New Genre" : {

         },
         "Page" : {

         },
         "Page #" : {

         },
         "Page: %@" : {

         },
         "Quotes" : {

         },
         "Rating" : {

         },
         "recommendedBy" : {

         },
         "Set the genre color" : {

         },
         "Sort by %@" : {

         },
         "Status" : {

         },
         "Synopsis" : {

         },
         "Title" : {

         },
         "Update" : {

         },
         "You need to create some genres first." : {

         }
"""

var keywords: String {
    words.replacingOccurrences(of: " : {", with: "")
        .replacingOccurrences(of: "    \"", with: "")
        .replacingOccurrences(of: "\"\n\n    },", with: "")
        .replacingOccurrences(of: "\"\n\n    }", with: "")
}

print(keywords)
