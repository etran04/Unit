//
//  EditTaskViewController.swift
//  Unit
//
//  Created by Eric Tran on 10/10/15.
//  Copyright © 2015 TheDRE. All rights reserved.
//

import Foundation
import Parse
import UIKit

class EditTaskViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var assigneeField: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var priorityLevel: UISegmentedControl!
    @IBOutlet weak var statusPicker: UIPickerView!
    
    var pickerData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        statusPicker.delegate = self
        statusPicker.dataSource = self
        // Input data into the Array:
        pickerData = ["Not Started", "In Progress", "In Verification", "Finished"]
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}