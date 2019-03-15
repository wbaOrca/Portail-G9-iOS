//
//  PDFViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 27/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import Reachability

class DocumentViewController: UIViewController , URLSessionDownloadDelegate , UIDocumentInteractionControllerDelegate {

    
    public var url_document_string : String = String();
    var fileName : String = "";
    
    var isFileOpened : Bool = false;
    var downloadTask: URLSessionDownloadTask!
    var backgroundSession: URLSession!
    var documentController : UIDocumentInteractionController!
    
    
    
    @IBOutlet weak var progressView: UIProgressView?
    @IBOutlet weak var labelWaiting: UILabel?
    @IBOutlet weak var viewForPDF: UIView!
    
    // *****************************************
    // *****************************************
    // ****** viewDidLoad
    // *****************************************
    // *****************************************
    override func viewDidLoad() {
        super.viewDidLoad()

        
        progressView?.isHidden = true;
        labelWaiting?.isHidden = true;
       
        let url = URL(string: url_document_string)!
        fileName = url.lastPathComponent
        
    }
    // *****************************************
    // *****************************************
    // ****** backButtonAction
    // *****************************************
    // *****************************************
    @IBAction func backButtonAction(sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true);
    }
    // *****************************************
    // *****************************************
    // ****** viewDidAppear
    // *****************************************
    // *****************************************
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated);
        if(self.backgroundSession != nil)
        {
            self.backgroundSession.finishTasksAndInvalidate()
        }
        let reachability = Reachability()!
        if (reachability.connection == .none ) //si pas de connexion internet
        {
            //simple alert dialog
            let alertLoadingData = UIAlertController(title: "Pas de connexion internet.", message: "Veuillez vérifier votre connexion internet.", preferredStyle: UIAlertController.Style.alert);
            
            self.present(alertLoadingData, animated: true, completion: nil);
            
            return
        }else
        {
            if(isFileOpened == false)
            {
                //openPreviewFile();
                downloadFile(urlAsString: url_document_string);
                isFileOpened =  true ;
            }
        }
        
       
    }
    // *****************************************
    // *****************************************
    // ****** downloadFile
    // *****************************************
    // *****************************************
    func downloadFile (urlAsString : String)
    {
        print(urlAsString)
        let url = URL(string: urlAsString)!
        
        //**** remove files ******
        let dir = NSSearchPathForDirectoriesInDomains (FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first;
        
        let fileManager = FileManager()
        let filePath = URL(fileURLWithPath:dir!).appendingPathComponent(self.fileName);
        do {
            
            try fileManager.removeItem(at: filePath);
            
        }catch{
            print("An error occurred while removeItem file to destination url")
        }
        //**** remove files ******
        
        let backgroundSessionConfiguration = URLSessionConfiguration.background(withIdentifier: "BackgroundSessionPDF")
        self.backgroundSession = URLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
        
        
        progressView?.isHidden = false;
        labelWaiting?.isHidden = false;
        progressView?.setProgress(0.0, animated: false)
        
        
        downloadTask = backgroundSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    
    // *****************************************
    // *****************************************
    // ****** URLSession didCompleteWithError
    // *****************************************
    // *****************************************
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didCompleteWithError error: Error?)
    {
        downloadTask = nil
        progressView?.setProgress(0.0, animated: false)
        
        progressView?.isHidden = true;
        labelWaiting?.isHidden = true;
        if (error != nil)
        {
           print(error?.localizedDescription)
        }else
        {
            print("didCompleteWithError")
        }
    }
    
    // *****************************************
    // *****************************************
    // ****** URLSession didFinishDownloadingToURL
    // *****************************************
    // *****************************************
    // 1
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL)
    {
        
        
        
        let dir = NSSearchPathForDirectoriesInDomains (FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first;
        
        let fileManager = FileManager()
        
        let filePath = URL(fileURLWithPath:dir!).appendingPathComponent(self.fileName);
        
        if fileManager.fileExists(atPath: filePath.absoluteString){
        
            //File Exist
        }
        else{
            do {
                try fileManager.moveItem(at: location, to: filePath)
                // show file
                print("destinationURLForFile = ",filePath.path)
                openPreviewFile();
            }catch{
                print("An error occurred while moving file to destination url")
            }
        }
        
        
    }
    // *****************************************
    // *****************************************
    // ****** URLSession downloadTask
    // *****************************************
    // *****************************************
    // 2
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64)
    {
        self.progressView?.setProgress(Float(totalBytesWritten)/Float(totalBytesExpectedToWrite), animated: true)
    }

    
    
    
    
    // *****************************************
    // *****************************************
    // ****** openPreviewFile
    // *****************************************
    // *****************************************
     func openPreviewFile() {
        
        let dir = NSSearchPathForDirectoriesInDomains (FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first;
        
        let filePath = URL(fileURLWithPath:dir!).appendingPathComponent(self.fileName);
        
        documentController = UIDocumentInteractionController.init(url:filePath)
        documentController.delegate = self;
        documentController.presentPreview(animated: true);
        
    }
    // *****************************************
    // *****************************************
    // ****** documentInteractionControllerViewControllerForPreview
    // *****************************************
    // *****************************************
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController
    {
        return self ;
    }
    // *****************************************
    // *****************************************
    // ****** documentInteractionControllerViewForPreview
    // *****************************************
    // *****************************************
    func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView?
    {
        return self.viewForPDF;
    }
    // *****************************************
    // *****************************************
    // ****** documentInteractionControllerDidEndPreview
    // *****************************************
    // *****************************************
    func documentInteractionControllerDidEndPreview(_ controller: UIDocumentInteractionController)
    {
        self.navigationController?.popViewController(animated: true);
    }
    // *****************************************
    // *****************************************
    // ****** didReceiveMemoryWarning
    // *****************************************
    // *****************************************
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
