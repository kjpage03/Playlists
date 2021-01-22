//
//  SetupViewController.swift
//  Playlists
//
//  Created by Kaleb Page on 1/5/21.
//

import UIKit
import StoreKit
import SwiftUI

class SetupViewController: UIViewController, SKCloudServiceSetupViewControllerDelegate {

    @Binding var hasSubscription: Bool
    
    init(hasSub: Binding<Bool>){
        self._hasSubscription = hasSub
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    let controller = SKCloudServiceController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        
        requestAuth()
        
    }
    
    func requestAuth() {
        SKCloudServiceController.requestAuthorization { (status) in
            switch status {
            case .authorized:
                self.controller.requestCapabilities { (capabilites, error) in
                    if capabilites.contains(.musicCatalogPlayback) {
                        
                        self.hasSubscription = true
                    }
                    
                    if capabilites.contains(.musicCatalogSubscriptionEligible) {
                        self.presentSetupVC()
                    }
                }
            case .denied:
                print("Request was denied.")
                let ac = UIAlertController(title: "This app will not function correctly without your Apple Music Library.", message: nil, preferredStyle: .actionSheet)
                let cancel = UIAlertAction(title: "Good Riddance", style: .cancel, handler: nil)
                let action = UIAlertAction(title: "Try Again", style: .default) { (action) in
                    self.requestAuth()
                }
                
                ac.addAction(cancel)
                ac.addAction(action)
                
                self.present(ac, animated: true, completion: nil)
            case .restricted:
                print("Welp")
            case .notDetermined:
                print("welP")
                
            default:
                fatalError()
            }
        }
    }
    
    func presentSetupVC() {
        let setupVC = SKCloudServiceSetupViewController()
        setupVC.delegate = self
        
        let options: [SKCloudServiceSetupOptionsKey: Any] = [.action: SKCloudServiceSetupAction.subscribe]
        
        setupVC.load(options: options) { [weak self] (result: Bool, error: Error?) in
           guard error == nil else { return }
           
            if result {
                self?.present(setupVC, animated: true, completion: nil)
            }
        }
        
    }
    
    func cloudServiceSetupViewControllerDidDismiss(_ cloudServiceSetupViewController: SKCloudServiceSetupViewController) {
    
        controller.requestCapabilities { (capabilites, error) in
            if capabilites.contains(.musicCatalogPlayback) {
                
                self.hasSubscription = true
            }
            
            if capabilites.contains(.musicCatalogSubscriptionEligible) {
                let ac = UIAlertController(title: "Welp :(", message: "Sorry we couldn't work things out.", preferredStyle: .actionSheet)
                let action = UIAlertAction(title: "Outta here", style: .default) { (action) in
                    fatalError()
                }
                ac.addAction(action)
                self.present(ac, animated: true)
            }
        
    }

}

        
        

}
