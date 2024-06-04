//
//  DropDown.swift
//  ExpatLand
//
//  Created by User on 07/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import UIKit

protocol DropDownDataSourceProtocol{
    func getDataToDropDown(cell: UITableViewCell, indexPos: Int, dropDownIdentifier: String)
    func numberOfRows(dropDownIdentifier: String) -> Int
    
    //Optional Method for item selection
    func selectItemInDropDown(indexPos: Int, dropDownIdentifier: String)
}

extension DropDownDataSourceProtocol{
    func selectItemInDropDown(indexPos: Int, dropDownIdentifier: String) {}
}

class DropDown: UIView{
    
    //MARK: Variables
        // The DropDownIdentifier is to differentiate if you are using multiple Xibs
        var dropDownIdentifier: String = "DROP_DOWN"
        // Reuse Identifier of your custom cell
        var cellReusableIdentifier: String = "DROP_DOWN_CELL"
        // Table View
        var dropDownTableView: UITableView?
        var width: CGFloat = 100
        var offset:CGFloat = 0
        var dropDownDataSourceProtocol: DropDownDataSourceProtocol?
        var nib: UINib?{
            didSet{
                dropDownTableView?.register(nib, forCellReuseIdentifier: self.cellReusableIdentifier)
            }
        }
        // Other Variables
        var viewPositionRef: CGRect?
        var isDropDownPresent: Bool = false
    
    
    
    //MARK: - DropDown Methods
        
        // Make Table View Programatically
        
    func setUpDropDown(viewPositionReference: CGRect,  offset: CGFloat , color:UIColor){
            self.makeBorder(1, color: color ,clipsToBounds: false)
            self.addShadow(radius: 4, cornerRadius: 2, color: Constants.Color.appDefaultColor)
            self.frame = CGRect(x: viewPositionReference.minX, y: viewPositionReference.maxY + offset, width: 0, height: 0)
            dropDownTableView = UITableView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: 0, height: 0))
            self.width = viewPositionReference.width
            self.offset = offset
            self.viewPositionRef = viewPositionReference
            dropDownTableView?.showsVerticalScrollIndicator = false
            dropDownTableView?.showsHorizontalScrollIndicator = false
            dropDownTableView?.backgroundColor = .white
            dropDownTableView?.separatorStyle = .none
            dropDownTableView?.delegate = self
            dropDownTableView?.dataSource = self
            dropDownTableView?.allowsSelection = true
            dropDownTableView?.isScrollEnabled = true
            dropDownTableView?.isUserInteractionEnabled = true
            dropDownTableView?.tableFooterView = UIView()
            self.addSubview(dropDownTableView!)
           
            
        }
    
    
    // Shows Drop Down Menu
        func showDropDown(height: CGFloat){
            if isDropDownPresent{
                self.hideDropDown()
            }else{
                isDropDownPresent = true
                self.frame = CGRect(x: (self.viewPositionRef?.minX)!, y: (self.viewPositionRef?.maxY)! + self.offset, width: width, height: 0)
                self.dropDownTableView?.frame = CGRect(x: 0, y: 0, width: width, height: 0)
                self.dropDownTableView?.reloadData()
                
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.05, options: .curveLinear
                    , animations: {
                    self.frame.size = CGSize(width: self.width, height: height)
                        self.dropDownTableView?.frame.size = CGSize(width: self.width, height:  height)
                })
            }
            
            // hide keyboard if present
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder),
                            to: nil, from: nil, for: nil)
            
        }
        
        // Use this method if you want change height again and again
        // For eg in UISearchBar DropDownMenu
        func reloadDropDown(height: CGFloat){
            self.frame = CGRect(x: (self.viewPositionRef?.minX)!, y: (self.viewPositionRef?.maxY)!
                + self.offset, width: width, height: 0)
            self.dropDownTableView?.frame = CGRect(x: 0, y: 0, width: width, height: 0)
            self.dropDownTableView?.reloadData()
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.05, options: .curveLinear
                , animations: {
                self.frame.size = CGSize(width: self.width, height: height)
                self.dropDownTableView?.frame.size = CGSize(width: self.width, height: height)
            })
        }
        
        //Sets Row Height of your Custom XIB
        func setRowHeight(height: CGFloat){
            self.dropDownTableView?.rowHeight = height
            self.dropDownTableView?.estimatedRowHeight = height
        }
        
        //Hides DropDownMenu
        func hideDropDown(){
            isDropDownPresent = false
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveLinear
                , animations: {
                self.frame.size = CGSize(width: self.width, height: 0)
                self.dropDownTableView?.frame.size = CGSize(width: self.width, height: 0)
            })
        }
        
        // Removes DropDown Menu
        // Use it only if needed
        func removeDropDown(){
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveLinear
                , animations: {
                self.dropDownTableView?.frame.size = CGSize(width: 0, height: 0)
            }) { (_) in
                self.removeFromSuperview()
                self.dropDownTableView?.removeFromSuperview()
            }
        }
    
    // reload data set 
       func refresh()
       {
        self.dropDownTableView?.reloadData()
       }
    
  
}

// MARK: - Table View Methods

extension DropDown: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dropDownDataSourceProtocol?.numberOfRows(dropDownIdentifier: self.dropDownIdentifier) ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = (dropDownTableView?.dequeueReusableCell(withIdentifier: self.cellReusableIdentifier) ?? UITableViewCell())
        dropDownDataSourceProtocol?.getDataToDropDown(cell: cell, indexPos: indexPath.row, dropDownIdentifier: self.dropDownIdentifier)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dropDownDataSourceProtocol?.selectItemInDropDown(indexPos: indexPath.row, dropDownIdentifier: self.dropDownIdentifier)
       
    }
}
