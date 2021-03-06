//
//  AddFileTacheViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 26/03/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import WeScan
import CropViewController

import Reachability
import NVActivityIndicatorView

// +++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++
class AddFileTacheViewController: UIViewController, CropViewControllerDelegate , ImageScannerControllerDelegate ,NVActivityIndicatorViewable {

    var isFromCommentaire : Bool = false;
    var screenCommentaire : AddCommentaireTacheViewController! = nil
    
    var tache : Tache = Tache();
    var mFile : File = File();
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var imageViewDocument: UIImageView!
    var imageDocumentToSend : UIImage! = nil;
    
    // **************************
    // **************************
    // **************************
    override func viewDidLoad() {
        super.viewDidLoad()

        saveButton.layer.cornerRadius = 5
        saveButton.clipsToBounds = true
        
        // Do any additional setup after loading the view.
        self.imageDocumentToSend = nil;
        self.imageViewDocument.image = UIImage(named: "image_file");
        let preferences = UserDefaults.standard
        let path_last_document = preferences.string(forKey: Utils.SHARED_PREFERENCE_LAST_DOCUMENT)
        if(path_last_document != nil)
        {
            Utils.deleteFile(fileName: path_last_document!)
        }
        preferences.set(nil, forKey: Utils.SHARED_PREFERENCE_LAST_DOCUMENT)
        preferences.synchronize()
        
        // Create a white border with defined width
        imageViewDocument.layer.borderColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1) ;
        imageViewDocument.layer.borderWidth = 1.5;
        // Set image corner radius
        imageViewDocument.layer.cornerRadius = 5.0;
        // To enable corners to be "clipped"
        imageViewDocument.clipsToBounds = true
    }
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    func presentCropViewController (imageToCrop: UIImage) {
        
        
        let cropViewController = CropViewController(image: imageToCrop)
        cropViewController.delegate = self
        present(cropViewController, animated: true, completion: nil)
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        // 'image' is the newly cropped version of the original image
        // 'image' is the newly cropped version of the original image
        
        self.imageDocumentToSend = image;
        self.imageViewDocument.image = self.imageDocumentToSend;
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    @IBAction func selectNouveauScan(_ sender: Any) {
        
        self.scan();
        
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func scan() {
        
        // Somewhere on your ViewController
        let scannerVC = ImageScannerController()
        scannerVC.imageScannerDelegate = self
        self.present(scannerVC, animated: true, completion: nil)
    }
    
    // *********************
    // **********************
    // ***********************
    // Somewhere on your ViewController that conforms to ImageScannerControllerDelegate
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        print(error)
    }
    // *********************
    // **********************
    // ***********************
    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        // Your ViewController is responsible for dismissing the ImageScannerController
        scanner.dismiss(animated: true, completion: nil)
        
        self.imageDocumentToSend = results.scannedImage.resizeImage()
        self.imageViewDocument.image = self.imageDocumentToSend
    }
    
    // *********************
    // **********************
    // ***********************
    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        // Your ViewController is responsible for dismissing the ImageScannerController
        scanner.dismiss(animated: true, completion: nil)
        
        self.imageDocumentToSend = nil;
        self.imageViewDocument.image = UIImage(named: "image_file");
    }

    
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    @IBAction func AttacherDocument(_ sender: Any) {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if(self.imageDocumentToSend != nil)
        {
            
            let preferences = UserDefaults.standard
            let path_last_document = preferences.string(forKey: Utils.SHARED_PREFERENCE_LAST_DOCUMENT)
            if(path_last_document != nil)
            {
                Utils.deleteFile(fileName: path_last_document!)
            }
            
            let path_image = Utils.saveImageToDocuments(imageToSave: self.imageDocumentToSend)
            print(path_image);
            preferences.set(path_image, forKey: Utils.SHARED_PREFERENCE_LAST_DOCUMENT)
            preferences.synchronize()
            
            mFile = File()
            mFile.fileName = path_image;
            
            // cas 1
            if(isFromCommentaire && screenCommentaire != nil)
            {
                screenCommentaire.mFichier = mFile;
                self.navigationController?.popViewController(animated: true)
                return
            }
            
            //cas 2
            let reachability = Reachability()!
            if (reachability.connection == .none ) //si pas de connexion internet
            {
                let alert = UIAlertController(title: "Erreur", message: NSLocalizedString("no_internet_connexion", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return;
            }
            
            
            
            // All Correct OK
            DispatchQueue.main.async {
                let size = CGSize(width: 150, height: 50)
                self.startAnimating(size, message: "Attachement du document en cours... Veuillez patienter svp...", type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
            }
            
            DispatchQueue.main.async{
                WSQueries.addFileToTaskForcesTerrains(delegate: self, taskId: self.tache.taskId, fichier: self.mFile);
            }
            
        }else
        {
            let alert = UIAlertController(title: "Erreur",
                                          message: "Veuillez scanner/sélectionner un document",
                                          preferredStyle: UIAlertController.Style.alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
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

}

// +++++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++++
extension AddFileTacheViewController : WSAddFileToTaskForcesTerrainsDelegate
{
    // ***********************************
    // ***********************************
    // ***********************************
    func didFinishWSAddFileToTask(error: Bool, code_erreur: Int, description: String) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error)
        {
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Succès", message: "Votre document est attaché avec succès.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (_) in
                    
                    self.tache.files.append(self.mFile)
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
            return;
            
        }else
        {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Erreur", message: (description + "\ncode erreur : " + String(code_erreur)), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return;
            }
        }
    }
}



// +++++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++++
extension UIImage {
    
    func resizeImage() -> UIImage {
        
        var targetSize = CGSize(width: 768, height: 1024); // photo portrait
        if(self.size.width > self.size.height ) // if landscape
        {
            targetSize = CGSize(width: 1024, height: 768); // photo landscape
        }
        
        if(self.size.width < targetSize.width && self.size.height < targetSize.height)
        {
            return self; // pas besoin de redimentionner
        }
        
        
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    //******
    //******
    func resizeImage(targetSize : CGSize) -> UIImage {
        
        
        
        if(self.size.width < targetSize.width && self.size.height < targetSize.height)
        {
            return self; // pas besoin de redimentionner
        }
        
        
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
