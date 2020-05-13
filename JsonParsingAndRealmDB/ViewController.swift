//
//  ViewController.swift
//  JsonParsingAndRealmDB
//
//  Created by Tarun Tomar on 13/05/20.
//  Copyright © 2020 Tarun Tomar. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var studentTableView: UITableView!
    private var data: [StudentModel] = []
    lazy var viewModel: StudentViewModel = {
        var vm = StudentViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.addObserver { [weak self] (data) in
            /// Observe here when data added
            self?.data = data
            self?.loadTable()
        }
        viewModel.fetchData()
    }
 
    func loadTable() {
        studentTableView.delegate = self
        studentTableView.dataSource = self
        studentTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = studentTableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as! StudentCell
        let model = data[indexPath.row]
        cell.configureCell(model)
        return cell
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 80
       }

}

class StudentCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var rollNumberLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var classLbl: UILabel!
    
    func configureCell(_ model: StudentModel) {
        nameLbl.text = model.name
        rollNumberLbl.text = model.rollNumber
        ageLbl.text = String(model.age)
        classLbl.text = model.classStd
    }
}
