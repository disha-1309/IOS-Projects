//
//  CoreDataManager.swift
//  Real Estate
//
//  Created by Droisys on 07/10/25.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    // Managed Object Context Access
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Real_Estate") 
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // Saving data
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
                print("Data Saved Successfully!")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //New user registered
    func registerUser(email: String, passwordHash: String) {
        let newUser = User(context: context)
        newUser.email = email
        newUser.password = passwordHash // અહીં Hashed Password સ્ટોર કરવું
        newUser.isLoggedIn = false
        
        saveContext()
    }
    
    //fetch user
    func fetchUser(email: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let users = try context.fetch(request)
            return users.first
        } catch {
            print("Could not fetch user: \(error.localizedDescription)")
            return nil
        }
    }
}
