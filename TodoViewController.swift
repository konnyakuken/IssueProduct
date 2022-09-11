//
//  TodoViewController.swift
//  IssueProduct
//
//  Created by 若宮拓也 on 2022/09/09.
//

import UIKit
import RealmSwift
import SwiftUI

class TodoViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var detailTextField: UITextView!
    
    //日付の設定
    @IBOutlet weak var DateField: UITextField!
    var datePicker: UIDatePicker = UIDatePicker()
    
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 枠のカラー
        detailTextField.layer.borderColor = UIColor.black.cgColor
        
        // 枠の幅
        detailTextField.layer.borderWidth = 1.0
        
        // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale(identifier: "MDY")
        DateField.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // インプットビュー設定
        DateField.inputView = datePicker
        DateField.inputAccessoryView = toolbar
    }
    
    func read() -> Todo?{
        //realmを使ってTodoから最初のデータを取り出す
        return realm.objects(Todo.self).first
    }
    
    @IBAction func save(){
        let title: String = titleTextField.text!
        let detail: String = detailTextField.text!
        let date: String = DateField.text!
        
        if(title != "" && detail != "" && date != ""){
            addDB(title: title,detail: detail,date: date)
            let alert: UIAlertController = UIAlertController(title: "成功", message: "保存しました", preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(title: "OK", style: .default,handler: nil)
            )
            present(alert,animated:true,completion: nil)
        }else{
            let alert: UIAlertController = UIAlertController(title: "失敗", message: "すべての項目を埋めてください", preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(title: "OK", style: .default,handler: nil)
            )
            present(alert,animated:true,completion: nil)
        }
        
        
       
    }
    
    func addDB(title:String,detail:String,date:String){
        let todo: Todo? = read()
        //インスタンス作成
        let newTodo = Todo()
        newTodo.title = title
        newTodo.detail = detail
        newTodo.date = date
        if todo != nil {
            let results = realm.objects(Todo.self)
            newTodo.id = (Int(results[results.count - 1].id)) + 1
        } else {
            newTodo.id = 1
        }
        try! realm.write{
            realm.add(newTodo)
        }
        print(realm.objects(Todo.self))
    }
    
    
    
    // 決定ボタン押下
    @objc func done() {
        DateField.endEditing(true)
        
        // 日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        DateField.text = "\(formatter.string(from: datePicker.date))"
    }


}
