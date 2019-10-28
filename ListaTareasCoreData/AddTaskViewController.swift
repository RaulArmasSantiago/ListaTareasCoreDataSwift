//
//  AddTaskViewController.swift
//  ListaTareasCoreData
//
//  Created by Raul Armas Santiago on 10/9/19.
//  Copyright © 2019 Sento40. All rights reserved.
//

import UIKit
import CoreData

var taskArray = [String]()
var dateArray = [String]()

class AddTaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    @IBOutlet weak var spinerOutlet: UIPickerView!
    @IBOutlet weak var spinerDateOutlet: UIDatePicker!
    @IBOutlet weak var btnSaveOutlet: UIButton!
    
    var selectTask = ""
    
    var task = ["Selecciona una tarea", "Ir a la escuela", "Super", "Cocinar", "Reporte semana", "Reunion con Gabriel", "Viaje", "Evento", "Cena Familiar", "Entrega de avances", "Examen", "Curso"]
    
    var dateFormatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinerOutlet.dataSource = self
        spinerOutlet.delegate = self
        
        btnSaveOutlet.isEnabled = false
        
        dateFormatter.dateFormat = "dd/MMM/yyyy - HH:mm"
        
        spinerDateOutlet.minimumDate = Date()

        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return task.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return task[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            btnSaveOutlet.isEnabled = false
        }else{
            btnSaveOutlet.isEnabled = true
            selectTask = task[row]
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func saveBtnAction(_ sender: Any) {
        let date = spinerDateOutlet.date
        print(date)
        
        let dateStr = dateFormatter.string(from: date)
        print(dateStr)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
        
        let task = NSManagedObject(entity: taskEntity, insertInto: managedContext)
        task.setValue(selectTask, forKeyPath: "tarea")
        task.setValue(dateStr, forKeyPath: "date")
        task.setValue(false, forKey: "status")
        
        do {
            try managedContext.save()
            print("Gurdo los datos")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.localizedDescription)")
        }
        
        
        
       
        
        
        
        taskArray.append(selectTask)
        dateArray.append(dateStr)
        print(taskArray,dateArray)
        
        navigationController?.popViewController(animated: true)
    }
}
