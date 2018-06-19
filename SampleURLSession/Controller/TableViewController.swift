//
//  TableViewController.swift
//  SampleURLSession
//
//  Created by Yogesh Wagh on 18/06/18.
//  Copyright © 2018 yogesh. All rights reserved.
//

import UIKit

protocol TextableLabel {
    func configureWithItem(data:Fact?) -> Void
}

class TableViewController: UITableViewController {

    var fact : FactsData?
    var factpresenter = FactParser()
    
    let nonPrototypeCellIdentifier:String = "CellIdentifier"
    
    lazy var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.isHidden = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: nonPrototypeCellIdentifier)
        getData()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = CGFloat(80)
    }

    //Method to get data from remote server
    func getData()  {
        self.activityIndicator.startAnimating()
        factpresenter.getFactsData(complete: { (facts) in
            self.fact = facts
            DispatchQueue.main.async {
                self.title = self.fact?.title
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }) { (error) in
            print(error.localizedDescription)
            self.activityIndicator.stopAnimating()
        }
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
     if(fact == nil)
     {
        return 0
        }
        return (fact?.rows.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: nonPrototypeCellIdentifier, for: indexPath)
        if let cellx = cell as? TextableLabel
        {
            let item = fact?.rows[indexPath.row]
            cellx.configureWithItem(data: item)
            return cell
        }
        
        assertionFailure("unrecognized cell type")
        return UITableViewCell()
    }
 
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }


}
