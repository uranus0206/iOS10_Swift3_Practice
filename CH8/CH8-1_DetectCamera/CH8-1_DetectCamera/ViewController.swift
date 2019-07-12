//
//  ViewController.swift
//  CH8-1_DetectCamera
//
//  Created by Chung-I Wu on 2019/7/11.
//  Copyright © 2019 Chung-I Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("This device has camera.")
            
            if UIImagePickerController.isCameraDeviceAvailable(.front) {
                print("Has front camera.")
            }
            
            if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                print("Has rear camera.")
            }
            
            if UIImagePickerController.isFlashAvailable(for: .front) {
                print("Has front flash.")
            }
            
            if UIImagePickerController.isFlashAvailable(for: .rear) {
                print("Has rear flash.")
            }
        }
    }


}

