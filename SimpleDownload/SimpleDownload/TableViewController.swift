//
//  TableViewController.swift
//  SimpleDownload
//
//  Created by Dominik Auinger on 24.01.22.
//

import UIKit

class TableViewController: UITableViewController {
    
    var randomInfo: String? = ""
    
    var queue = DispatchQueue(label: "Download")
    let path = "https://jsonplaceholder.typicode.com/todos"
    var todoModel = TodoModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        queue.async {
            let model = self.donwload()
            
            DispatchQueue.main.async {
                self.todoModel = model
                self.tableView.reloadData()
            }
        }
    }
    
    func donwload() -> TodoModel {
        let model = TodoModel()
        if let url = URL(string: path) {
            if let data = try? Data(contentsOf: url) {
                print("downloaded: \(data)")
                print(randomInfo!)
                if let obj = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    for todo in obj {
                        let todoObj = Todo()
                        todoObj.title = todo["title"] as! String
                        todoObj.id = todo["id"] as! Int
                        todoObj.userId = todo["userId"] as! Int
                        todoObj.completed = todo["completed"] as! Bool
                        model.todos.append(todoObj)
                    }
                } else {
                    print("data parse failed")
                }
            } else {
                print("download failed")
            }
        }
        return model
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoModel.todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = todoModel.todos[indexPath.row].title

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
