//
//  DropDownView.swift
//  ExpatLand
//
//  Created by User on 08/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import UIKit


protocol DropDownViewDataSetProtocol{
    
    func fetchItemIds(ids: [Int],view:DropDownView)
    func hideExistingDropDowns(view:DropDownView)
}

class DropDownView: UIView {

    // MARK: PROPERTIES -

    let errorLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = Validation.errorEmptyTextFeild
        l.isHidden = true
        l.font = UIFont.kAppDefaultFontRegular(ofSize: 12)
        l.textColor = Constants.Color.appDefaultErrorColor
        l.numberOfLines = 0
        return l
    }()

    let textfield: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.addShadow(radius: 4, cornerRadius: 2, color: Constants.Color.appDefaultColor)
        tf.inputView = UIView()
        tf.textColor = Constants.Color.appBaseBalticColor
        tf.placeholder = Constants.TextConstant.email
        tf.font = UIFont.kAppDefaultFontRegular(ofSize: 14)
        tf.tintColor = Constants.Color.appBaseBalticColor
        tf.rightViewMode = .always
        return tf
    }()

    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 8
        sv.distribution = .fill
        sv.alignment = .fill
        return sv
    }()
    
    let rightButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "downArrow") , for: .normal)
        btn.imageView?.tintColor = Constants.Color.appDefaultColor
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        return btn
    }()
    
    let tapView: UIView = UIView()
    
    // Mark: Variables -
    let dropDown = DropDown()
    var data: [Element] = [Element]()
    var dropDownViewDataSetProtocol: DropDownViewDataSetProtocol?

    // MARK: MAIN -

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
        setUpConstraints()
    }

    // MARK: FUNCTIONS -

    func setUpViews(){
        addSubview(stackView)
        addSubview(tapView)
        stackView.addArrangedSubview(textfield)
        stackView.addArrangedSubview(errorLabel)
        rightButton.frame = CGRect(x:0, y:0, width:Int(textfield.frame.size.height / 2), height:Int(self.frame.size.height / 2))
        textfield.rightView = rightButton
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object:nil)
    }

    func setUpConstraints(){
        stackView.pin(to: self)
        addTapView()
        textfield.heightAnchor.constraint(equalToConstant: 53).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    func setUpDropDown(){
        dropDown.dropDownIdentifier = "DROP_DOWN_NEW"
        dropDown.cellReusableIdentifier = "dropDownCell"
        dropDown.dropDownDataSourceProtocol = self
      
        if textfield.hasError()
        {
            dropDown.setUpDropDown(viewPositionReference: (textfield.frame), offset: -1, color: Constants.Color.appDefaultErrorColor)
        }
        else
        {
            dropDown.setUpDropDown(viewPositionReference: (textfield.frame), offset: -1, color: Constants.Color.appDefaultColor)
        }
        dropDown.nib = UINib(nibName: "DropDownTableViewCell", bundle: nil)
        dropDown.width = textfield.frame.width
        dropDown.setRowHeight(height: 44)
        dropDown.isUserInteractionEnabled = true
        addSubview(dropDown)
        
    }
    
    func setUpDropDown(childView:UIView,view: UIView){
        dropDown.dropDownIdentifier = "DROP_DOWN_NEW"
        dropDown.cellReusableIdentifier = "dropDownCell"
        dropDown.dropDownDataSourceProtocol = self
        if textfield.hasError()
        {
            dropDown.setUpDropDown(viewPositionReference: (childView.frame), offset: -1, color: Constants.Color.appDefaultErrorColor)
        }
        else
        {
            dropDown.setUpDropDown(viewPositionReference: (childView.frame), offset: -1, color: Constants.Color.appDefaultColor)
        }
        dropDown.nib = UINib(nibName: "DropDownTableViewCell", bundle: nil)
        dropDown.width = childView.frame.width
        dropDown.setRowHeight(height: 44)
        dropDown.isUserInteractionEnabled = true
        view.addSubview(dropDown)
        
    }
    
    func setUpDropDown(frame:CGRect,view: UIView){
        dropDown.dropDownIdentifier = "DROP_DOWN_NEW"
        dropDown.cellReusableIdentifier = "dropDownCell"
        dropDown.dropDownDataSourceProtocol = self
        if textfield.hasError()
        {
            dropDown.setUpDropDown(viewPositionReference: (frame), offset: -1, color: Constants.Color.appDefaultErrorColor)
        }
        else
        {
            dropDown.setUpDropDown(viewPositionReference: (frame), offset: -1, color: Constants.Color.appDefaultColor)
        }
        dropDown.nib = UINib(nibName: "DropDownTableViewCell", bundle: nil)
        dropDown.width = frame.width
        dropDown.setRowHeight(height: 44)
        dropDown.isUserInteractionEnabled = true
        view.addSubview(dropDown)
        
    }
    
    
    
    
    private func addTapView() {
           tapView.translatesAutoresizingMaskIntoConstraints = false
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleShowHide))
           tapView.addGestureRecognizer(tapGesture)
           addSubview(tapView)
           tapView.pin(to: self)
       }
    

    
    @objc
        func toggleShowHide() {
            toggle()
        }
    
    func toggle() {
        if self.dropDown.isDropDownPresent
        {
         //   dropDownViewDataSetProtocol?.fetchItemIds(ids:  self.data.filter{ $0.selected }.map{ $0.id }, view: self)
            self.dropDown.hideDropDown()
            rightButton.setImage(UIImage(named: "downArrow") , for: .normal)
            guard !textfield.hasError() else { return }
           hideError()
        }
        else {
            if data.count > 5 {
                self.dropDown.showDropDown(height: CGFloat(5 * 44))
            }
            else {
                self.dropDown.showDropDown(height: CGFloat(data.count * 44))
            }
          
            rightButton.setImage(UIImage(named: "upArrow") , for: .normal)
            if(textfield.hasError())
            {
                textfield.makeBorder(1, color: Constants.Color.appDefaultErrorColor ,clipsToBounds: false)
            }
            else
            {
                textfield.makeBorder(1, color: Constants.Color.appDefaultColor ,clipsToBounds: false)
            }
           
            dropDownViewDataSetProtocol?.hideExistingDropDowns(view: self)
           
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        
        if  self.dropDown.isDropDownPresent{
            self.dropDown.hideDropDown()
            rightButton.setImage(UIImage(named: "downArrow") , for: .normal)
            guard !textfield.hasError() else { return }
            hideError()
            
        }
    }
    
    func hideDropDown()
    {
        self.dropDown.hideDropDown()
        rightButton.setImage(UIImage(named: "downArrow") , for: .normal)
        guard !textfield.hasError() else { return }
       hideError()
        
    }
    deinit {
      NotificationCenter.default.removeObserver(self)
    }
   
}

extension DropDownView {

    func showError(error: String)
    {
        
        textfield.makeBorder(1, color: Constants.Color.appDefaultErrorColor ,clipsToBounds: false)
        rightButton.imageView?.tintColor = Constants.Color.appDefaultErrorColor
        errorLabel.text = error
        errorLabel.isHidden = false
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }

    func hideError()
    {
        rightButton.imageView?.tintColor = Constants.Color.appDefaultColor
        textfield.makeBorder(0, color: Constants.Color.appDefaultErrorColor ,clipsToBounds: false)
        errorLabel.isHidden = true
    }
    
    func isEnabled(enable:Bool)
    {
        if enable
        {
            self.isUserInteractionEnabled = true
            textfield.backgroundColor = UIColor.white
            
            if textfield.hasError()
            {
                rightButton.imageView?.tintColor = Constants.Color.appDefaultErrorColor
            }
            else
            {
                rightButton.imageView?.tintColor = Constants.Color.appDefaultColor
            }
            
        }
        else {
            self.isUserInteractionEnabled = false
            rightButton.imageView?.tintColor = .placeholderText
            textfield.backgroundColor = Constants.Color.appBaseSmokeColor
        }
    }
    
    func validate()->Bool
    {
        if textfield.text?.isEmpty ?? false
        {
            showError(error: Validation.errorEmptyTextFeild)
            return false
        }
        
        hideError()
        return true
    }
    
    func resetDropDown()
    {
        textfield.text = ""
        data.indices.forEach{ data[$0].selected = false}
        dropDown.refresh()
    }
}

extension DropDownView:DropDownDataSourceProtocol {
    func getDataToDropDown(cell: UITableViewCell, indexPos: Int, dropDownIdentifier: String) {
        if dropDownIdentifier == "DROP_DOWN_NEW"{
            let customCell = cell as! DropDownTableViewCell
            customCell.lblName.text = self.data[indexPos].name
            customCell.indicatorView.isHidden = !self.data[indexPos].selected
            if self.data[indexPos].selected {
                customCell.mainView.backgroundColor = Constants.Color.appCellBackgroundColor
            }
            else {
                customCell.mainView.backgroundColor = .white
            }
            
        }
    }
    
    func numberOfRows(dropDownIdentifier: String) -> Int {
        return self.data.count
    }
    
    func selectItemInDropDown(indexPos: Int, dropDownIdentifier: String)
    {
        if self.data[indexPos].selected {
            self.data[indexPos].selected = false
        }
        else {
            self.data[indexPos].selected = true
        }
        self.dropDown.refresh()
        textfield.text = self.data.filter{ $0.selected }.map{ $0.name }.joined(separator: ", ")
        dropDownViewDataSetProtocol?.fetchItemIds(ids:  self.data.filter{ $0.selected }.map{ $0.id }, view: self)
       
    }
    
}


// MARK: - Element
struct Element: Codable {
    let id: Int
    let name: String
    var selected:Bool = false
}
