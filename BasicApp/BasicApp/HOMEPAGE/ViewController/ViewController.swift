//
//  ViewController.swift
//  BasicApp
//
//  Created by timofey makhlay on 7/1/20.
//  Copyright © 2020 Jasson Ehrlich. All rights reserved.
//

import UIKit

protocol HomeDelegate {
    func finishedEditing(at tag: Int, title: String, category: String)
}

class ViewController: UIViewController, HomeDelegate {
    func finishedEditing(at tag: Int, title: String, category: String) {
        let newReminder = Reminder(title: title, category: category, description: nil)
        viewModel.appendCellViewModel(viewModel.createCellViewModel(reminder: newReminder))
        tableView.reloadData()
    }
    
    /// View model property  in the VC
    lazy var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    
    // Veritcal list of items
    lazy var tableView: UITableView = {
        let v = UITableView()
        // Register Table View Cells
        v.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        v.delegate = self
        v.dataSource = self
        v.backgroundColor = .clear
        v.tableFooterView = UIView(frame: .zero)
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        view.backgroundColor = .red
        
        // Set  the title in the navigation controller
        self.title = "Home"
        
        // Add button
//       self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addTapped))
        
        viewModel.createReminders()
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
    }

//    @objc func addTapped() {
//        print("Button tapped")
//    }

}


// MARK: TableView Data Source
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells + 1
    }

// Table View Cells configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell

        if indexPath.row == viewModel.numberOfCells {
            cell.editMode()
            cell.delegate = self
            cell.titleTextField.tag = indexPath.row
        } else {
            // Getting the view model for a cell
            let cellVM = viewModel.getCellViewModel(at: indexPath)
            cell.cellViewModel = cellVM
//            cell.titleTextField.tag = indexPath.row
            
            // Remove cell bottom line
            cell.selectionStyle = .none
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cell tapped

    }
    
    // Delete a cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.row != viewModel.numberOfCells {
            viewModel.removeSelectedContact(at: indexPath)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }

}


// MARK: TableView Delegate
extension ViewController: UITableViewDelegate {
    //     Table View Cell Styling
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
