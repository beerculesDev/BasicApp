//
//  HomeViewModel.swift
//  BasicApp
//
//  Created by timofey makhlay on 7/1/20.
//  Copyright © 2020 Jasson Ehrlich. All rights reserved.
//

import UIKit


class HomeViewModel {
    
    /// Cell raw data
    private var reminders: [Reminder]!
    
    /// Cell modified data
    private var cellViewModels: [HomeCellViewModel] = [HomeCellViewModel]() {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }
    
    /// Return number of cells
    var numberOfCells: Int {
        return self.cellViewModels.count
    }
    
    
    /// Any API calls
    var reloadCollectionViewClosure: (()->())? = {
        
    }
    
    /// Return cell at index
    func getCellViewModel(at indexPath: IndexPath ) -> HomeCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    /// Remove cell at index
    func removeSelectedContact(at indexPath: IndexPath ) {
        self.cellViewModels.remove(at: indexPath.row)
    }
    
    /// Create cell viewModel from struct
    func createCellViewModel(reminder: Reminder ) -> HomeCellViewModel {
        return HomeCellViewModel(title: reminder.title, category: reminder.category, description: reminder.description)
    }
    
    func createReminders() {
        var rawData: [Reminder] = [
            Reminder(title: "Buy condoms", category: "🛍", description: "XXL"),
            Reminder(title: "Clean up", category: "🧹", description: "Bathroom"),
            Reminder(title: "Workout", category: "💪🏿", description: "Inject african blood")
        ]
        
        var vms: [HomeCellViewModel] = []
        
        for reminder in rawData {
            let newVM = createCellViewModel(reminder: reminder)
            vms.append(newVM)
        }
        self.cellViewModels = vms
    }
}

