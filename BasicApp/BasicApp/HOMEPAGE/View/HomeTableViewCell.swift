//
//  HomeTableViewCell.swift
//  BasicApp
//
//  Created by timofey makhlay on 7/1/20.
//  Copyright © 2020 Jasson Ehrlich. All rights reserved.
//

import UIKit
import SnapKit

class HomeTableViewCell: UITableViewCell {
    static let identifier = "HomePageCell"
    
    
    /// Cell view model (to edit raw data to approriate cell values)
    var cellViewModel : HomeCellViewModel? {
        didSet {
            titleLabel.text = cellViewModel?.title
            descriptionLabel.text = cellViewModel?.description
            categoryLabel.text = cellViewModel?.category
        }
    }
    
    // title
    var titleLabel: UILabel = {
        var title = UILabel()
        title.text = "Test"
        return title
    }()
    
    // description
    var descriptionLabel: UILabel = {
        var title = UILabel()
        title.text = "Test"
        return title
    }()
    
    // category
    var categoryLabel: UILabel = {
        var title = UILabel()
        title.text = "Test"
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setupCellLayout()
    }
    
    
    // Required with initilizer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellLayout() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(categoryLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(10)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(self).offset(10)
        }
        
        categoryLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-10)
        }
    }
    

}
