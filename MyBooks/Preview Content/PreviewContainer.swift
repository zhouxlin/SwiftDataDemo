//
//  PreviewContainer.swift
//  MyBooks
//
//  Created by Hope on 2024/3/10.
//

import Foundation
import SwiftData

struct Preview {
    let container:ModelContainer
    init(_ models: any PersistentModel.Type...) {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema(models)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Couldon't create preview container")
        }
    }
    
    func addExamples(_ examples: [any PersistentModel]) {
        Task { @MainActor in // 加入异步任务，在主线程中进行
            examples.forEach { example in
                container.mainContext.insert(example)
            }
        }
    }
}
