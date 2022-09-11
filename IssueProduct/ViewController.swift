//
//  ViewController.swift
//  IssueProduct
//
//  Created by 若宮拓也 on 2022/09/05.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource {
    
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var detailTextField: UITextField!
    
    @IBOutlet var addTodo: UIButton!
    @IBOutlet var table: UITableView!
    
    let realm = try! Realm()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        table.dataSource = self

    }
    
    func read() -> Todo?{
        //realmを使ってTodoから最初のデータを取り出す
        return realm.objects(Todo.self).first
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let results = realm.objects(Todo.self)
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let results = realm.objects(Todo.self)
        
        cell.textLabel?.text = "\(results[indexPath.row].title)"
        cell.detailTextLabel?.text = "\(results[indexPath.row].date )"
        return cell
    }
    
    //Viewが表示される直前に呼ばれる。
    //Viewが表示されるたびに呼ばれる。
    override func viewWillAppear(_ animated: Bool) {
        let results = realm.objects(Todo.self)
        table.reloadData()
        print(results)
        print(results.count)
        
    }
    
    //セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    

    
    //スワイプしたセルを削除　
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let targetEmployee = realm.objects(Todo.self)[indexPath.row]
            try! realm.write{
                realm.delete(targetEmployee)
              }
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    


}

