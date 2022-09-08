//
//  TodoViewController.swift
//  IssueProduct
//
//  Created by 若宮拓也 on 2022/09/09.
//

import UIKit
import RealmSwift

class TodoViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource {
    
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var detailTextField: UITextField!
    
    @IBOutlet var addTodo: UIButton!

    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //titleTextField.delegate = self
        //detailTextField.delegate = self
        
        table.dataSource = self
        
        //let todo: Todo? = read()
        
        //titleTextField.text = todo?.title
        //detailTextField.text = todo?.detail
        
    }
    
    func read() -> Todo?{
        //realmを使ってTodoから最初のデータを取り出す
        return realm.objects(Todo.self).first
    }
    
    @IBAction func save(){
        let title: String = titleTextField.text!
        let detail: String = detailTextField.text!
        
        let todo: Todo? = read()
        
        if todo != nil {
            try! realm.write{
                todo!.title = title
                todo!.detail = detail
            }
        } else {
            let newTodo = Todo()
            newTodo.title = title
            newTodo.detail = detail
            
            try! realm.write{
                realm.add(newTodo)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = "test"
        
        return cell!
        
    }
    


}
