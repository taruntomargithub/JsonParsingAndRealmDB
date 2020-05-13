//
//  StudentViewModel.swift
//  JsonParsingAndRealmDB
//
//  Created by Tarun Tomar on 13/05/20.
//  Copyright © 2020 Tarun Tomar. All rights reserved.
//

import Foundation
import RealmSwift

class StudentViewModel {
    private var observer: (_ data: [StudentModel]) -> Void = {_ in }
    private var dataArray: [StudentModel] = [] {
        didSet {
            notify()
        }
    }
    
    func addObserver(_ observer: @escaping (_ data: [StudentModel]) -> Void) {
        self.observer = observer
    }
    
    private func notify() {
        self.observer(dataArray)
    }
    
    func fetchData() {
        readJSONFromFile(fileName: "StudentData")
    }
    
    private func readJSONFromFile(fileName: String)
    {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                if let json = try? JSONSerialization.jsonObject(with: data) as? [String:Any] {
                    if let studentDataArray = json["student"] as? [[String: Any]] {
                        let result = StudentModel.create(data: studentDataArray)
                        dataArray = result
                    }
                }
            } catch {
                print("Error in data creation : \(error.localizedDescription)")
                /// TODO : Show an alert here for proper error message
            }
        }
    }
}

