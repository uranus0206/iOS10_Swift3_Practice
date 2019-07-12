//
//  ViewController.swift
//  CH8-3_PickPhotoFromLibrary
//
//  Created by Chung-I Wu on 2019/7/12.
//  Copyright © 2019 Chung-I Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func buttonPress(_ sender: UIButton) {
        let pickVC = UIImagePickerController()
        
        pickVC.sourceType = .photoLibrary
        pickVC.delegate = self
        
        // Set style as popover
        pickVC.modalPresentationStyle = .popover
        let pop = pickVC.popoverPresentationController
        pop?.sourceView = sender
        
        // Set arrow direction
        pop?.sourceRect = sender.bounds
        pop?.permittedArrowDirections = .any
        
        show(pickVC, sender: self)
    }
}

extension ViewController: UINavigationControllerDelegate {}
extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[.originalImage] as! UIImage
        imgView.image = img
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
