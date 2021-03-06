//
//  MealCell+CoreDataProperties.swift
//  Nutritioner
//
//  Created by Josiah Agosto on 1/3/21.
//
//

import Foundation
import CoreData


extension MealCell {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealCell> {
        return NSFetchRequest<MealCell>(entityName: "MealCell")
    }

    @NSManaged public var calories: String
    @NSManaged public var date: String
    @NSManaged public var id: UUID
    @NSManaged public var longDate: String
    @NSManaged public var name: String
    @NSManaged public var notes: String?
    @NSManaged public var day: Day
    @NSManaged public var meal: Set<Meal>

}

// MARK: Generated accessors for meal
extension MealCell {

    @objc(addMealObject:)
    @NSManaged public func addToMeal(_ value: Meal)

    @objc(removeMealObject:)
    @NSManaged public func removeFromMeal(_ value: Meal)

    @objc(addMeal:)
    @NSManaged public func addToMeal(_ values: NSSet)

    @objc(removeMeal:)
    @NSManaged public func removeFromMeal(_ values: NSSet)

}


extension MealCell: Identifiable {
    
}
