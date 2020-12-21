//
//  CoreDataHelper.swift
//  FoodTracker
//
//  Created by Josiah Agosto on 12/10/20.
//

import Foundation
import CoreData

protocol CoreDataHelperProtocol {
    func create(_ object: NSManagedObject)
    func fetch(_ objectType: NSManagedObject.Type, predicate: NSPredicate?, limit: Int?) -> Result<[NSManagedObject], Error>
    func saveToContext()
    func delete(_ object: NSManagedObject)
}

class CoreDataHelper: CoreDataHelperProtocol {
    // MARK: - References / Properties
    static let shared = CoreDataHelper()
    var context: NSManagedObjectContext {
        PersistenceController.shared.container.viewContext
    }
    
    //MARK: -  Protocol Methods
    //
    func create(_ object: NSManagedObject) {
        do {
            try context.save()
        } catch let error {
            print("Error Creating, \(error)")
        }
    }
    
    //
    func fetch<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate? = nil, limit: Int? = nil) -> Result<[T], Error> {
        let request = objectType.fetchRequest()
        request.predicate = predicate
        if let limit = limit {
            request.fetchLimit = limit
        }
        do {
            let result = try context.fetch(request)
            return .success(result as? [T] ?? [])
        } catch let error {
            return .failure(error)
        }
    }
    
    //
    func saveToContext() {
        do {
            try context.save()
        } catch let error {
            print("Error Updating, \(error)")
        }
    }
    
    //
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        saveToContext()
    }
    
    //
    public func calculateCalories(_ from: [MealCell]) -> Int16 {
        var allCalories: Int16 = 0
        let _ = from.forEach { (meal) in
            allCalories += Int16(meal.calories) ?? 0
        }
        if !from.isEmpty {
            SharedData.shared.addValuesToPlist(Int(allCalories), String.convertStringDateToDayOfWeek(from[0].longDate), from.count)
        } else {
            SharedData.shared.addValuesToPlist(0, String.getCurrentDay(), 0)
        }
        return allCalories
    }

}