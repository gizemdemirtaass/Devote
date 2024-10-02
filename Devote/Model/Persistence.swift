//
//  Persistence.swift
//  Devote
//
//  Created by gizem demirtas on 24.09.2024.
//

import CoreData

struct PersistenceController {
    // MARK: - 1. PERSISTENT CONTROLLER -> Tüm uygulamamız kullanması için bir singleton.
    static let shared = PersistenceController()

    // MARK: - 2. PERSISTENT CONTAINER -> Temel veriler için depolama özelliğidir.
    // Kalıcı container kullanmak, çekirdek veri yığınımızı başlatmak ve çekirdek veri modelimizi daha sonra yüklemek için tercih edilen yoldur.
    let container: NSPersistentContainer

    // MARK: - INITIALIZATION (Load the persistent store)
    //Kalıcı konteyneri devote adı verilen çekirdek veri depomuza yönlendirerek başlıyoruz.
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Devote")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // MARK: - PREVIEW
   
       static let preview: PersistenceController = {
           let result = PersistenceController(inMemory: true)
           let viewContext = result.container.viewContext
           for i in 0..<5 {
               let newItem = Item(context: viewContext)
               newItem.timestamp = Date()
               newItem.task = "Sample task No\(i)"
               newItem.completion = false
               newItem.id = UUID()
               
               
           }
           do {
               try viewContext.save()
           } catch {
               // Replace this implementation with code to handle the error appropriately.
               // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
               let nsError = error as NSError
               fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
           }
           return result
       }()
    
}
