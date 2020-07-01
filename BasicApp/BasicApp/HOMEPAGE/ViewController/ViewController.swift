//
//  ViewController.swift
//  BasicApp
//
//  Created by timofey makhlay on 7/1/20.
//  Copyright © 2020 Jasson Ehrlich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
        navigationController!.navigationBar.prefersLargeTitles = true
        
        
        viewModel.createReminders()
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
    }


}


// MARK: TableView Data Source
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

// Table View Cells configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell

        // Getting the view model for a cell
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        
        // Remove cell bottom line
        cell.selectionStyle = .none
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cell tapped

    }

}


// MARK: TableView Delegate
extension ViewController: UITableViewDelegate {
    //     Table View Cell Styling
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
