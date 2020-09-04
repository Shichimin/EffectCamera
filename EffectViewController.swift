//
//  EffectViewController.swift
//  MyCamera
//
//  Created by Tomoki Kawakami on 2020/09/04.
//  Copyright © 2020 Tomoki Kawakami. All rights reserved.
//

import UIKit

class EffectViewController: UIViewController {
    
    var originalImage : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        effectImage.image = originalImage
    }
    
    @IBOutlet weak var effectImage: UIImageView!
    
    let filterArray = ["CIPhotoEffectMono",
                       "CIPhotoEffectChrome",
                       "CIPhotoEffectFade",
                       "CIPhotoEffectInstant",
                       "CIPhotoEffectNoir",
                       "CIPhotoEffectProcess",
                       "CIPhotoEffectTonal",
                       "CIPhotoEffectTransfer",
                       "CISepiaTone"
    ]
    
    var filterSelectNumber = 0

    @IBAction func effetButtonAction(_ sender: Any) {
        if let image = originalImage {
            let filterName = filterArray[filterSelectNumber]
            
            filterSelectNumber += 1
            
            if filterSelectNumber == filterArray.count {
                filterSelectNumber = 0
            }
            
            let rotate = image.imageOrientation
            let inputImage = CIImage(image: image)
            
            guard let effectFilter = CIFilter(name: filterName) else {
                return
            }
            
            effectFilter.setDefaults()
            effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
            
            guard let outputImage = effectFilter.outputImage else {
                return
            }
            
            let ciContext = CIContext(options: nil)
            guard let  cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else {
                return
            }
            
            effectImage.image = UIImage(cgImage: cgImage, scale: 1.0, orientation: rotate)
        }
    }
    @IBAction func shareButtonAction(_ sender: Any) {
        if let shareImage  = effectImage.image?.resize() {
            let shareItems = [shareImage]
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            controller.popoverPresentationController?.sourceView = view
            present(controller, animated: true, completion: nil)
        }
    }
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
