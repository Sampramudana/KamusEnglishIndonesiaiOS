//
//  KamusTableViewController.swift
//  KamusApps
//
//  Created by Becak Holic on 11/9/17.
//  Copyright © 2017 Sam Pramudana. All rights reserved.
//

import UIKit

class KamusTableViewController: UITableViewController {
    
    let kivaLoanURL = "http://localhost/KamusApp/index.php/api/getAllKamus"
    var loans = [Loan]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLatestLoans()
        
        tableView.estimatedRowHeight = 92.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return loans.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        // Configure the cell...
        cell.englishDesc.text = loans[indexPath.row].english
        cell.indonesianDesc.text = loans[indexPath.row].indonesian
        
        let data = loans[indexPath.row]
        
        return cell
    }
    func getLatestLoans() {
        
        guard let loanUrl = URL(string: kivaLoanURL) else {
            return
        }
        let request = URLRequest(url: loanUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                self.loans = self.parseJsonData(data: data)
                OperationQueue.main.addOperation ({
                    self.tableView.reloadData()
                })
            }
        })
        task.resume()
    }
    func parseJsonData(data: Data) -> [Loan] {
        
        var loans = [Loan]()
        
        do{
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            let jsonLoans = jsonResult?["data"] as! [AnyObject]
            for jsonLoan in jsonLoans{
                let loan = Loan()
                loan.english = jsonLoan["kamus_inggris"] as! String
                loan.indonesian = jsonLoan["kamus_indonesia"] as! String
                loans.append(loan)
            }
        }catch{
            print(error)
        }
        return loans
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
         override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
}
