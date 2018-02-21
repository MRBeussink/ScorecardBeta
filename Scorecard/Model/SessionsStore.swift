//
//  SessionsStore.swift
//  Scorecard
//
//  Created by Mark Beussink on 20180104.
//  Copyright © 2018 Mark Beussink. All rights reserved.
//

import Foundation
import CoreData

enum SessionsResult {
    case success([Session])
    case failure(Error)
}

enum CoursesResult {
    case success([Course])
    case failure(Error)
}

enum DeleteResult {
    case success
    case failure(Error)
}

enum ItemsResult {
    case success([Item])
    case failure(Error)
}

class SessionsStore {
    
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Scorecard")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error setting up Core Data \(error).")
            }
        }
        return container
    }()
    
    
    func saveStore() {
        //let context = self.persistentContainer.viewContext
        
        do {
            try self.persistentContainer.viewContext.save()
        } catch let error {
            print("Core Data save failed: \(error)")
        }
    }
    
    
    // MARK: Sessions
    
    func addNewSession(starting date: Date) {
        let context = self.persistentContainer.viewContext
        let newSession = NSEntityDescription.insertNewObject(forEntityName: "Session",
                                                             into: context)
        
        newSession.setValue(date, forKey: "startDate")
        
        do {
            try self.persistentContainer.viewContext.save()
        } catch let error {
            print("Core Data save failed: \(error)")
        }
        print("New session added")
    }
    
    func fetchAllSessions(completion: @escaping (SessionsResult) -> Void) {
        let fetchRequest: NSFetchRequest<Session> = Session.fetchRequest()
        let sortByStartDate = NSSortDescriptor(key: #keyPath(Session.startDate), ascending: false)
        
        fetchRequest.sortDescriptors = [sortByStartDate]
        
        let viewContext = persistentContainer.viewContext
        viewContext.perform {
            do {
                let allSessions = try viewContext.fetch(fetchRequest)
                completion(.success(allSessions))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func delete(session: Session, completion: @escaping () -> Void) {
        let viewContext = persistentContainer.viewContext
        viewContext.delete(session)
        do {
            try viewContext.save()
            completion()
        } catch let error {
            print("Core Data Save failed: \(error)")
        }
    }
    
    // MARK: Courses
    
    func fetchCourses(for session: Session, completion: @escaping (CoursesResult) -> Void) {
        let fetchRequest: NSFetchRequest<Course> = Course.fetchRequest()
        let sortByName = NSSortDescriptor(key: #keyPath(Course.name), ascending: true)
        
        guard let startDate = session.startDate else {
            fatalError("Attempting to fetch courses for session without a start date")
        }
        
        
        let sessionPredicate = NSPredicate(format: "session.startDate == %@",
                                           startDate as NSDate)
        
        fetchRequest.sortDescriptors = [sortByName]
        fetchRequest.predicate = sessionPredicate
        
        let viewContext = persistentContainer.viewContext
        viewContext.perform {
            do {
                let sessionCourses = try viewContext.fetch(fetchRequest)
                completion(.success(sessionCourses))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func addNewCourse(name: String, to session: Session) {
        let context = self.persistentContainer.viewContext
        let newCourse = NSEntityDescription.insertNewObject(forEntityName: "Course", into: context)
        
        
        newCourse.setValue(name, forKey: "name")
        newCourse.setValue(session, forKey: "session")
        
        do {
            try self.persistentContainer.viewContext.save()
        } catch let error {
            print("Core Data saved failed: \(error)")
        }
        print("New course added")
    }
    
    func delete(course: Course, completion: @escaping () -> Void) {
        let viewContext = persistentContainer.viewContext
        viewContext.delete(course)
        
        do {
            try viewContext.save()
            completion()
        } catch let error {
            print("Core Data save failed: \(error)")
        }
    }
    
    
    // MARK: Items
    
    func fetchItems(for course: Course, completion: @escaping (ItemsResult) -> Void) {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let sortByWeight = NSSortDescriptor(key: #keyPath(Item.weight), ascending: false)
        
        guard let name = course.name else {
            fatalError("Attempting to fetch courses for session without a name.  Fix this!")
        }
        
        let coursePredicate = NSPredicate(format: "course.name == %@", name)
        
        fetchRequest.sortDescriptors = [sortByWeight]
        fetchRequest.predicate = coursePredicate
        
        let viewContext = persistentContainer.viewContext
        viewContext.perform {
            do {
                let courseItems = try viewContext.fetch(fetchRequest)
                completion(.success(courseItems))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    
}



















































