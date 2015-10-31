//
//  CreateSessionViewController.swift
//  B2BTutoring
//
//  Created by Claire Zhang on 10/29/15.
//  Copyright © 2015 Team 1. All rights reserved.
//

import UIKit
import Eureka

class CreateSessionViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeForm()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    enum Category : String, CustomStringConvertible {
        case Art = "Art"
        case Cars_and_motorcycles = "Cars and motorcycles"
        case Cooking = "Cooking"
        case Design = "Design"
        case DIY_and_crafts = "DIY_and_crafts"
        case Film = "Film"
        case Health = "Health"
        case Music = "Music"
        case Photography = "Photography"
        case Sports = "Sports"
        
        var description : String { return rawValue }
        
        static let allValues = [Art, Cars_and_motorcycles, Cooking, Design, DIY_and_crafts, Film, Health, Music, Photography, Sports]
    }

    
    private func initializeForm() {
        let font = UIFont(name: "Avenir-Medium", size: 16.0)
        
        TextRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = font
            cell.textField.font = font
        }
        
        DateTimeInlineRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = font
            cell.detailTextLabel?.font = font
        }
    
        PickerInlineRow<Category>.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = font
            cell.detailTextLabel?.font = font
        }
        
        TextAreaRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = font
            cell.detailTextLabel?.font = font
        }
        
        form =
            
            TextRow("Title").cellSetup {
                $0.cell.textField.placeholder = $0.row.tag
            }
            
            <<< TextRow("Location").cellSetup {
                $0.cell.textField.placeholder = $0.row.tag
            }
        
//            <<< PickerRow<Category>("Category") { (row : PickerRow<Category>) -> Void in
//                row.options = Category.allValues
//                row.title = "Category"
//                row.value = row.options[0]
//            }
            
            <<< PickerInlineRow<Category>("Category") { (row : PickerInlineRow<Category>) -> Void in
                row.title = row.tag
                row.options = Category.allValues
                row.value = row.options[0]
            }
            
            <<< TextRow("Tags").cellSetup {
                $0.cell.textField.placeholder = $0.row.tag
            }
            
            +++
            
            DateTimeInlineRow("Starts") {
                $0.title = $0.tag
                $0.value = NSDate().dateByAddingTimeInterval(60*60*24)
                }
                .onChange { [weak self] row in
                    let endRow: DateTimeInlineRow! = self?.form.rowByTag("Ends")
                    if row.value?.compare(endRow.value!) == .OrderedDescending {
                        endRow.value = NSDate(timeInterval: 60*60*24, sinceDate: row.value!)
                        endRow.cell!.backgroundColor = .whiteColor()
                        endRow.updateCell()
                    }
                }
                .onExpandInlineRow { cell, row, inlineRow in
                    inlineRow.cellUpdate { [weak self] cell, dateRow in
                        cell.datePicker.datePickerMode = .DateAndTime
                    }
                    let color = cell.detailTextLabel?.textColor
                    row.onCollapseInlineRow { cell, _, _ in
                        cell.detailTextLabel?.textColor = color
                    }
                    cell.detailTextLabel?.textColor = cell.tintColor
            }
            
            <<< DateTimeInlineRow("Ends"){
                $0.title = $0.tag
                $0.value = NSDate().dateByAddingTimeInterval(60*60*25)
                }
                .onChange { [weak self] row in
                    let startRow: DateTimeInlineRow! = self?.form.rowByTag("Starts")
                    if row.value?.compare(startRow.value!) == .OrderedAscending {
                        row.cell!.backgroundColor = .redColor()
                    }
                    else{
                        row.cell!.backgroundColor = .whiteColor()
                    }
                    row.updateCell()
                }
                .onExpandInlineRow { cell, row, inlineRow in
                    inlineRow.cellUpdate { [weak self] cell, dateRow in
                        cell.datePicker.datePickerMode = .DateAndTime
                    }
                    let color = cell.detailTextLabel?.textColor
                    row.onCollapseInlineRow { cell, _, _ in
                        cell.detailTextLabel?.textColor = color
                    }
                    cell.detailTextLabel?.textColor = cell.tintColor
                }
        
            form +++=
            
            TextAreaRow("Description") {
                $0.placeholder = "Description"
                $0.cell.textView.font = font
            }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
