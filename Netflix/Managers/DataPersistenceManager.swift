//
//  DataPersistenceManager.swift
//  Netflix
//
//  Created by Abraam on 08.05.2022.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    static let shared = DataPersistenceManager()
    
    func downloadTitleWith(model: Title, completion: @escaping(Result<Void, Error>) -> Void ) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let contex = appDelegate.persistentContainer.viewContext
    let item = TitleItem(context: contex)
        item.title = model.title
        item.id = model.id
        item.image = model.image
        item.resultDescription = model.resultDescription
        item.resultType = model.resultType
        
        do {
            try contex.save()
            completion(.success(()))
        } catch  {
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    func fetchFromDatabase(completion: @escaping (Result<[TitleItem], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let contex = appDelegate.persistentContainer.viewContext
        let reqeust: NSFetchRequest<TitleItem>
        reqeust = TitleItem.fetchRequest()
        do {
           let titles =  try contex.fetch(reqeust)
            completion(.success(titles))
        } catch  {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    func deleteItemWith(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let contex = appDelegate.persistentContainer.viewContext
        contex.delete(model) // delete database object
        do {
            try contex.save()
            completion(.success(()))
        } catch  {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
    
}
