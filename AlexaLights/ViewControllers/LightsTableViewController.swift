//
//  LightsTableViewController.swift
//  AlexaLights
//
//  Created by DevMountain on 9/6/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit
import CoreData


//4) Adopt the deleage protocol.  Write on resume "I'm qualified to be the LighttableViewCells boss
class LightsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, LightTableViewCellDelegate {
    
    func lightSwitchWasFlipped(cell: LightTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let light = fetchedResultsController.object(at: indexPath)
        light.isOn = !light.isOn
        cell.light = light
    }

    let fetchedResultsController: NSFetchedResultsController<Light> = {
        
        let fetchRequest: NSFetchRequest<Light> = Light.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "isOn", ascending: false)]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController.delegate = self
//        let _ = LightController.shared.mockLights
        do{
           try fetchedResultsController.performFetch()
        }catch {
            print("There was as error in \(#function) :  \(error) \(error.localizedDescription)")
        }

    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        
        switch type{
            
        case .delete:
            guard let indexPath = indexPath else {return}
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        case .move:
            guard let oldIndexPath = indexPath,
                let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
            
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "lightCell", for: indexPath) as? LightTableViewCell else {return UITableViewCell() }
        let light = fetchedResultsController.object(at: indexPath)
        cell.light = light
        //6) assign the delegate property of the child = to self
        cell.delegate = self
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let light = fetchedResultsController.object(at: indexPath)
            LightController.shared.delete(light: light)
        }
    }
    
    func presentAlertController(){
        let alertController = UIAlertController(title: "Add A new Room with Lights", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "New Room Name"
        }
        
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
            guard let name = alertController.textFields?.first?.text else {return}
            LightController.shared.createLightWith(name: name, icon: UIImage(named: "LaundryRoom")!)
        }
        alertController.addAction(dismissAction)
        alertController.addAction(saveAction)
        
        present(alertController, animated: true)
    }
    
    @IBAction func addLightButtonTapped(_ sender: Any) {
        presentAlertController()
    }
    
}
