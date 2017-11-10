//
//  DetailViewController.swift
//  Homepwner
//
//  Created by 张鑫 on 2017/11/9.
//  Copyright © 2017年 张鑫. All rights reserved.
//

import UIKit
import Photos

class DetailViewController: UIViewController {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var item: Item! {
        didSet {
            self.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    
    let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }()
    
    let dateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let pickerVc = UIImagePickerController()
        
        let alertVc = UIAlertController(title: "选择照片", message: nil, preferredStyle: .actionSheet)
        alertVc.addAction(UIAlertAction(title: "拍照", style: .default, handler: { (_) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                pickerVc.sourceType = .camera
                pickerVc.delegate = self
                self.present(pickerVc, animated: true, completion: nil)
            } else {
                let url = URL.init(string: UIApplicationOpenSettingsURLString)
                if UIApplication.shared.canOpenURL(url!) {
                    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                }
            }
        }))
        
        alertVc.addAction(UIAlertAction(title: "相册", style: .default, handler: { (action: UIAlertAction) in
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) in
                switch status {
                case .denied, .restricted:
                    let url = URL.init(string: UIApplicationOpenSettingsURLString)
                    if UIApplication.shared.canOpenURL(url!) {
                        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                    }
                    break
                default:
                    pickerVc.sourceType = .photoLibrary
                    pickerVc.delegate = self
                    self.present(pickerVc, animated: true, completion: nil)
                }
            })
        }))
       
       alertVc.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        present(alertVc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = item.name
        serialField.text = item.serialNumber
        valueField.text = numberFormatter.string(for: item.valueInDollars)
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        imageView.image = imageStore.image(forKey: item.itemKey)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        item.name = nameField.text ?? ""
        item.serialNumber = serialField.text
        if let valueText = valueField.text, let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
        
    }
}

extension DetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        print("\(info)")
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
                imageStore.setImage(image, forKey: item.itemKey)
        }
        dismiss(animated: true) {
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
