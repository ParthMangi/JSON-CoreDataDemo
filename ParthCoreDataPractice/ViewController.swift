//
//  ViewController.swift
//  ParthCoreDataPractice
//
//  Created by ravi on 27/04/18.
//  Copyright © 2018 ravi. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import AlamofireObjectMapper

class ViewController: UIViewController {
    
    let endPoint  = "https://jsonplaceholder.typicode.com/users"
    let cellIdentifier = "peopleCell"
    var reachability : Reachability?
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var tableViewUser: UITableView!
    
    var people =  [Person]()
    
    //-------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialSetup()
    }
    
    func initialSetup() {
        if Connectivity.isConnectedToInternet {
            showTableView(show: false)
            showLoading(show: true)
            getDataFromAPI()
        } else {
            getDataFromCoreData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpReachbility()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        removeReachability()
    }
    
    //-------------------------------------
    //MARK: Rechability Methods
    //-------------------------------------

    func setUpReachbility() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachbailityChanged), name: NSNotification.Name.reachabilityChanged, object:nil)
        self.reachability = Reachability.forInternetConnection()
        self.reachability!.startNotifier()

    }

    //-------------------------------------

    func removeReachability() {
        self.reachability!.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.reachabilityChanged, object: nil)
    }

    //-------------------------------------

    @objc func reachbailityChanged(notification : Notification) {
        let remoteHostStatus = self.reachability?.currentReachabilityStatus()
        if (remoteHostStatus?.rawValue != NotReachable.rawValue) {
            print("Internet Available")
            showTableView(show: false)
            showLoading(show: true)
            getDataFromAPI()
        } else {
            print("Internet Gone")
            getDataFromCoreData()
        }
    }

    //-------------------------------------
    //MARK: Custom Method
    //-------------------------------------
    
    func showAlertWith (title : String , message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //-------------------------------------
    
    func showLoading(show : Bool) {
        if show {
            loading.isHidden = false
            loading.startAnimating()
        } else {
            loading.isHidden = true
            loading.stopAnimating()
        }
    }
    
    //-------------------------------------
    
    func showTableView(show : Bool) {
        if show {
            tableViewUser.isHidden = false
        } else {
            tableViewUser.isHidden = true
        }
    }
    
    //-------------------------------------
    //MARK: Call User API
    
    func getDataFromAPI() {
        Alamofire.request(endPoint).responseArray { (response : DataResponse<[PMUser]>) in
            let userResponse = response.result.value
            self.saveDataInCoreData(data: userResponse!)
        }
    }
    
    //-------------------------------------
    //MARK: Core Data Methods
    
    func  saveDataInCoreData(data: [PMUser]) {
        people.removeAll()
        for user in data {
            let person = Person(context: PersistenceService.context)
            guard let name = user.name else { return }
            guard let email = user.email else { return }
            person.name = name
            person.email = email
            PersistenceService.saveContext()
            self.people.append(person)
        }
        showLoading(show: false)
        showTableView(show: true)
        tableViewUser.reloadData()
    }
    
    //-------------------------------------
    
    func getDataFromCoreData() {
        let fetchRequest : NSFetchRequest<Person> = Person.fetchRequest()
        do {
            let people = try PersistenceService.context.fetch(fetchRequest)
            self.people = people
            self.tableViewUser.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //-------------------------------------
    
    func deleteAllDataInCoreData() {
        //Delete all record from Person
        let fetchRequest : NSFetchRequest<Person> = Person.fetchRequest()
        _ = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
    }
    
    //-------------------------------------
    
    func deletePersonFromCoreData(person : Person) {
        let context  = PersistenceService.context
        context.delete(person)
        PersistenceService.saveContext()
    }
}

extension ViewController : UITableViewDataSource , UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    //-------------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //-------------------------------------
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        cell.textLabel?.text = people[indexPath.row].name
        cell.detailTextLabel?.text = people[indexPath.row].email
        return cell
    }
    
    //-------------------------------------
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    //-------------------------------------
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deletePersonFromCoreData(person: people[indexPath.row])
            people.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
}


