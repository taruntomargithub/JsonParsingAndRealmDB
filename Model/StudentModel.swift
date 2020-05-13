//
//  StudentModel.swift
//  JsonParsingAndRealmDB
//
//  Created by Tarun Tomar on 13/05/20.
//  Copyright © 2020 Tarun Tomar. All rights reserved.
//

import Foundation
import RealmSwift


class StudentModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var rollNumber = ""
    @objc dynamic var classStd = ""
    @objc dynamic var age = 0

    static func create(data: [[String:Any]]) -> [StudentModel] {
        var arrayOfStudents: [StudentModel] = []
        for element in data {
            guard let name = element["name"] as? String,
                let id = element["id"] as? Int,
                let rollNumber = element["rollNumber"] as? String,
                let classStd = element["class"] as? String,
                let age = element["age"] as? Int else {
                continue
            }
            let studentObj = StudentModel()
            studentObj.name = name
            studentObj.id = id
            studentObj.classStd = classStd
            studentObj.rollNumber = rollNumber
            studentObj.age = age
            arrayOfStudents.append(studentObj)
        }
        return arrayOfStudents
    }
}
