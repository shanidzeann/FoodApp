//
//  DatabaseManager.swift
//  FoodApp
//
//  Created by Anna Shanidze on 13.04.2022.
//

import Foundation
import SQLite

protocol DatabaseManagerProtocol {
    func getItems() -> [Item]
    func addToDB(title: String, description: String, price: Int)
}

class DatabaseManager: DatabaseManagerProtocol {
    
    var db: Connection?
    var dishes = Table("dishes")
    
    let id = Expression<Int64>("id")
    let title = Expression<String>("title")
    let price = Expression<Int64>("price")
    let description = Expression<String>("description")
    
    init() {
        connectToDB()
        createTable()
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
                t.column(price)
                t.column(description)
            })
        } catch {
            print(error)
        }
    }
    
    func addToDB(title: String, description: String, price: Int) {
        do {
            let stmt = try db?.prepare("INSERT INTO dishes (title, description, price) VALUES (?, ?, ?)")
            try stmt?.run(title, description, price)
        } catch {
            print(error)
        }
    }
    
    func getItems() -> [Item] {
        var items = [Item]()
        do {
            for row in try db!.prepare("SELECT title, description, price FROM dishes") {
                let title = row[0] as! String
                let description = row[1] as! String
                let price = row[2] as! Int64
                let item = Item(title: title, description: description, price: Int(price))
                items.append(item)
            }
        } catch {
            print(error)
        }
        print(items)
        return items
    }
}
