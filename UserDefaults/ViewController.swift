//
//  ViewController.swift
//  UserDefaults
//
//  Created by jorgemr on 20/10/17.
//  Copyright © 2017 InformaticaBiomedica. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var index = 0
    var myEmojis : [[String]]!
    var newProperty: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiLabel.text = ""
        descriptionLabel.text = ""
        nextButton.alpha = 0.0
        previousButton.alpha = 0.0
        deleteButton.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveInfo(_ sender: UIButton) {
        if emojiTextField.text != "" && descriptionTextField.text != ""{
            let newEmoji = [emojiTextField.text!,descriptionTextField.text!]
            if var emojis = UserDefaults.standard.object(forKey: "emoji") as? [[String]]{
                emojis.append(newEmoji)
                UserDefaults.standard.set(emojis, forKey: "emoji")
                print("emoji añadido correctamente")
            }else{
                UserDefaults.standard.set([newEmoji], forKey: "emoji")
                print("emoji guardado correctamente")
            }
            emojiTextField.text = ""
            descriptionTextField.text = ""
        } else {
            let okAlert = UIAlertAction(title: "Ok", style: .default, handler: nil)
            let cancelAlert = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            let alertController = UIAlertController(title: "Something went wrong", message: "Fill all fields", preferredStyle: .alert)
            alertController.addAction(okAlert)
            alertController.addAction(cancelAlert)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func getInfo(_ sender: UIButton) {
        if let emoji = UserDefaults.standard.object(forKey: "emoji") as? [[String]]{
            index = 0
            myEmojis = emoji
            emojiLabel.text = myEmojis[index][0]
            descriptionLabel.text = myEmojis[index][1]
            nextButton.alpha = 1.0
            previousButton.alpha = 1.0
            deleteButton.isHidden = false
        } else {
            let okAlert = UIAlertAction(title: "Ok", style: .default, handler: nil)
            let cancelAlert = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            let alertController = UIAlertController(title: "There is no emojis", message: "Save new emojis", preferredStyle: .alert)
            alertController.addAction(okAlert)
            alertController.addAction(cancelAlert)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func nextEmoji(_ sender: UIButton) {
        if index < myEmojis.count - 1 {
            index += 1
            emojiLabel.text = myEmojis[index][0]
            descriptionLabel.text = myEmojis[index][1]
        }
    }
    
    @IBAction func previousEmoji(_ sender: UIButton) {
        if index >= 1 {
            index -= 1
            emojiLabel.text = myEmojis[index][0]
            descriptionLabel.text = myEmojis[index][1]
        }
    }
    
    @IBAction func DeleteEmoji(_ sender: UIButton) {
        if myEmojis.count == 1 {
            UserDefaults.standard.removeObject(forKey: "emoji")
            emojiLabel.text = ""
            descriptionLabel.text = ""
            nextButton.alpha = 0.0
            previousButton.alpha = 0.0
            deleteButton.isHidden = true
        } else if index == myEmojis.count - 1 {
            myEmojis.remove(at: index)
            index -= 1
            emojiLabel.text = myEmojis[index][0]
            descriptionLabel.text = myEmojis[index][1]
            UserDefaults.standard.set(myEmojis, forKey: "emoji")
        } else {
            myEmojis.remove(at: index)
            emojiLabel.text = myEmojis[index][0]
            descriptionLabel.text = myEmojis[index][1]
            UserDefaults.standard.set(myEmojis, forKey: "emoji")
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func newFunc() {
        
    }
    
}

