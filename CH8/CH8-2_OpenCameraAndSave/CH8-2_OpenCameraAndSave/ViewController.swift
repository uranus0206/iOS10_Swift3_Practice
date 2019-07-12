//
//  ViewController.swift
//  CH8-2_OpenCameraAndSave
//
//  Created by Chung-I Wu on 2019/7/11.
//  Copyright © 2019 Chung-I Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func takePictureButton(_ sender: Any) {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .camera
        imagePickerVC.delegate = self
        show(imagePickerVC, sender: self)
//        present(imagePickerVC, animated: false, completion: nil)
    }
}

extension ViewController: UINavigationControllerDelegate {}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let iamge = info[.originalImage] as! UIImage
        UIImageWriteToSavedPhotosAlbum(iamge, nil, nil, nil)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
