//
//  TodoViewController.swift
//  IssueProduct
//
//  Created by 若宮拓也 on 2022/09/09.
//

import UIKit

class TodoViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var detailTextField: UITextView!
    
    @IBOutlet weak var DateField: UITextField!
    var datePicker: UIDatePicker = UIDatePicker()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        DateField.inputView = datePicker
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // インプットビュー設定
        DateField.inputView = datePicker
        DateField.inputAccessoryView = toolbar
    }
    
    // 決定ボタン押下
    @objc func done() {
        DateField.endEditing(true)
        
        // 日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        DateField.text = "\(formatter.string(from: Date()))"
    }

   

}
