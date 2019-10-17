//
//  ViewController.swift
//  RNDropDownTableView
//
//  Created by Ryan Kwon on 2019/10/17.
//  Copyright © 2019 Ryan Kwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: RNDropDownTableView!
    @IBOutlet var sampleLabel: UILabel!
     
    let sampleData: [String] = ["Select Fruits", "Banana", "Apple", "Lemon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.dropDownMenuDelegate = self
        tableView.dropDownArrowFrame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.rowHeight)
        tableView.layer.cornerRadius = 2
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        cell.textLabel?.text = sampleData[indexPath.row]
        cell.textLabel?.textColor = .white
        return cell
    }
}

extension ViewController: DropDownMenuDelegate {
    func typeDidSelected(_ tableView: RNDropDownTableView, _ indexPath: IndexPath) {
        sampleLabel.text = tableView.cellForRow(at: indexPath)?.textLabel?.text ?? ""
    }
}
