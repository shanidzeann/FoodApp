//
//  DatabaseManager.swift
//  FoodApp
//
//  Created by Anna Shanidze on 13.04.2022.
//

import Foundation
import SQLite

class DatabaseManager: DatabaseManagerProtocol {
    
    static let shared = DatabaseManager()
    
    var db: Connection?
    var dishes = Table("dishes")
    
    let id = Expression<Int>("id")
    let title = Expression<String>("title")
    let price = Expression<Int>("price")
    let description = Expression<String>("description")
    let imageUrl = Expression<String>("imageUrl")
    let count = Expression<Int>("count")
    
    var items: [CartItem]?
    var totalPrice: Int = 0
    
    init() {
        connectToDB()
        createTable()
        getItems()
        totalPrice = getTotalPrice()
        print(items)
    }
    
    private func connectToDB() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
            ).first!
            //     copyDatabaseIfNeeded(sourcePath: Bundle.main.path(forResource: "db", ofType: "sqlite3")!)
            db = try Connection("\(path)/db.sqlite3")
        } catch {
            print(error)
        }
    }
    
    @discardableResult
    func copyDatabaseIfNeeded(sourcePath: String) -> Bool {
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let destinationPath = documents + "/db.sqlite3"
        let exists = FileManager.default.fileExists(atPath: destinationPath)
        guard !exists else { return false }
        do {
            try FileManager.default.copyItem(atPath: sourcePath, toPath: destinationPath)
            return true
        } catch {
            print("error during file copy: \(error)")
            return false
        }
    }
    
    private func createTable() {
        do {
            guard let db = db else { return }
            
            try db.run(dishes.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(title)
                t.column(description)
                t.column(price)
                t.column(imageUrl)
                t.column(count)
            })
        } catch {
            print(error)
        }
    }
    
    func addToDB(id: Int, title: String, description: String, price: Int, imageUrl: String, count: Int) {
        do {
            let stmt = try db?.prepare("INSERT INTO dishes VALUES (?, ?, ?, ?, ?, ?) ON CONFLICT(id) DO UPDATE SET count = count + 1")
            try stmt?.run(id, title, description, price, imageUrl, count)
            totalPrice += price
        } catch {
            print(error)
        }
        getItems()
    }
    
    func deleteFromDB(id: Int) {
        do {
            let delete = try db?.prepare("SELECT price FROM dishes WHERE id = (?)")
            for row in try delete!.run(id) {
                let price = row[0] as! Int64
                totalPrice -= Int(price)
            }
            
            let updateStmt = try db?.prepare("UPDATE dishes SET count = CASE WHEN count > 0 THEN count - 1 ELSE 0 END WHERE id = (?)")
            try updateStmt?.run(id)
            let deleteStmt = try db?.prepare("DELETE FROM dishes WHERE count = 0 AND id = (?)")
            try deleteStmt?.run(id)
        } catch {
            print(error)
        }
        getItems()
    }
    
    func getItems() {
        var items = [CartItem]()
        do {
            for row in try db!.prepare("SELECT id, title, description, price, imageUrl, count FROM dishes") {
                let id = row[0] as! Int64
                let title = row[1] as! String
                let description = row[2] as! String
                let price = row[3] as! Int64
                let image = row[4] as! String
                let count = row[5] as! Int64
                let item = CartItem(id: Int(id), title: title, description: description, price: Int(price), imageUrl: image, count: Int(count))
                items.append(item)
            }
        } catch {
            print(error)
        }
        self.items = items
    }
    
    func getTotalPrice() -> Int {
        var totalPrice = 0
        do {
            for row in try db!.prepare("SELECT price, count FROM dishes") {
                let price = row[0] as! Int64
                let count = row[1] as! Int64
                totalPrice += Int(price) * Int(count)
            }
        } catch {
            print(error)
        }
        return totalPrice
    }
}
