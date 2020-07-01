//
//  HomeTableViewCell.swift
//  BasicApp
//
//  Created by timofey makhlay on 7/1/20.
//  Copyright © 2020 Jasson Ehrlich. All rights reserved.
//

import UIKit
import SnapKit

class HomeTableViewCell: UITableViewCell, UITextFieldDelegate {
    static let identifier = "HomePageCell"
    
    var delegate: HomeDelegate?
    
    /// Cell view model (to edit raw data to approriate cell values)
    var cellViewModel : HomeCellViewModel? {
        didSet {
            titleTextField.text = cellViewModel?.title
            descriptionLabel.text = cellViewModel?.description
            categoryLabel.text = cellViewModel?.category
        }
    }
    
//    var tapView: UIView = {
//        var title = UIView()
//        title.backgroundColor = .clear
//        return title
//    }()
    
    // title
    var titleTextField: UITextField = {
        var title = UITextField()
        title.placeholder = "Type title here..."
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
        self.backgroundColor = .black
        setupCellLayout()
    }
    
    
    func editMode() {
        descriptionLabel.isHidden = true
        
    }
    
    // MARK: Return to next textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            delegate?.finishedEditing(at: textField.tag, title: titleTextField.text ?? "ERROR", category: categoryLabel.text ?? "ERROR")
            return true;
        }
        return false
    }
    
    
    // Required with initilizer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellLayout() {
        descriptionLabel.isHidden = false
        
        addSubview(titleTextField)
        addSubview(descriptionLabel)
        addSubview(categoryLabel)
//        addSubview(tapView)
        
        titleTextField.delegate = self
        
        titleTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(10)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleTextField.snp.bottom).offset(5)
            make.left.equalTo(self).offset(10)
        }
        
        categoryLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-10)
        }
        
//        tapView.snp.makeConstraints { (make) in
//            make.left.right.top.bottom.equalTo(self)
//        }
    }
    

}
