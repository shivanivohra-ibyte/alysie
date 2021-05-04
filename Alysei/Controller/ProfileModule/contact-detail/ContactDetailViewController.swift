//
//  ContactDetailViewController.swift
//  Alysei
//
//  Created by Janu Gandhi on 07/04/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SVProgressHUD
import CoreLocation

protocol ContactDetailDisplayLogic: class {
    func showAlertWithMessage(_ message: String)
}

class ContactDetailViewController: UIViewController, ContactDetailDisplayLogic {
    var interactor: ContactDetailBusinessLogic?
    var router: (NSObjectProtocol & ContactDetailRoutingLogic & ContactDetailDataPassing)?

    var viewModel: ContactDetail.Contact.ViewModel!
    var locationManager: CLLocationManager!
    var userType: UserRoles = .voyagers

    // MARK:- Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK:- Setup

    private func setup() {
        let viewController = self
        let interactor = ContactDetailInteractor()
        let presenter = ContactDetailPresenter()
        let router = ContactDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK:- View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel != nil {
            self.emailTextField.text = "\(viewModel.email)"
            self.phoneTextField.text = "\(viewModel.phone ?? "")"
            self.addressTextField.text = "\(viewModel.address ?? "")"
            self.websiteTextField.text = "\(viewModel.websiteURL ?? "")"
            self.facebookTextField.text = "\(viewModel.facebookURL ?? "")"
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

//     MARK:- IBOutlets
    @IBOutlet var emailTextField: UITextFieldExtended!
    @IBOutlet var phoneTextField: UITextFieldExtended!
    @IBOutlet var addressTextField: UITextFieldExtended!
    @IBOutlet var websiteTextField: UITextFieldExtended!
    @IBOutlet var facebookTextField: UITextFieldExtended!

    // MARK:- protocol methods

    func showAlertWithMessage(_ message: String) {
        SVProgressHUD.dismiss()

        let alert:UIAlertController = UIAlertController(title: AlertTitle.appName, message: message, preferredStyle: UIAlertController.Style.alert)


        let okayAction = UIAlertAction(title: AlertMessage.kOkay,
                                       style: UIAlertAction.Style.default) { (action) in
            self.backButtonTapped()
        }

        alert.addAction(okayAction)
        self.present(alert, animated: true, completion: nil)

    }



    func addressTextFieldSelected(_ sender: UITextField) -> Void{

        if CLLocationManager.locationServicesEnabled() {

            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:

                showTwoButtonsAlert(message: AlertMessage.kLocationPopUp, buttonTitle: AppConstants.Settings){
                    if let bundleId = Bundle.main.bundleIdentifier,
                       let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)"){
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            case .authorizedAlways, .authorizedWhenInUse:
                let controller = pushViewController(withName: MapViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? MapViewC
                controller?.dismiss = { [weak self] (mapAddressModel) in
                    self?.addressTextField.text = "\(mapAddressModel.address1), \(mapAddressModel.address2), \(mapAddressModel.mapAddress)".capitalized
                }
//                controller?.delegate = self
            default:
                break
            }
        }
    }


    public func pushViewController(withName name: String, fromStoryboard storyboard: String) -> UIViewController {

        let storyboard = UIStoryboard.init(name: storyboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name)

        self.navigationController?.pushViewController(viewController, animated: true)
        return viewController
    }

    //MARK:- custom methods

    private func validateAllfields() -> Bool {

       guard self.emailTextField.text?.isValid(.email) == true else {
            showAlert(withMessage: "Please enter a valid email ID.")
        return false
        }

        guard self.phoneTextField.text?.isValid(.mobileNumber) == true else {
            showAlert(withMessage: "Please enter a valid phone number.")
            return false
        }

        if !(self.facebookTextField.text?.isEmpty ?? true) {
            guard self.facebookTextField.text?.isValid(.facebook) == true else {
                showAlert(withMessage: "Please enter a valid facebook url.")
                return false
            }
        }


        if (self.userType == .voyagers || self.userType == .voiceExperts) && (self.websiteTextField.text?.count ?? 0 > 0)  {
            guard self.websiteTextField.text?.isValid(.url) == true else {
                showAlert(withMessage: "Please enter a valid URL.")
                return false
            }
        } else {
            guard self.websiteTextField.text?.isValid(.url) == true else {
                showAlert(withMessage: "Please enter a valid URL.")
                return false
            }
        }

        return true
    }

    // MARK:- @IBAction methods

    @IBAction func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {

        if self.validateAllfields() {
            SVProgressHUD.show()

            let requestModel = ContactDetail.Contact.Request(phone: self.phoneTextField.text,
                                                             address: self.addressTextField.text,
                                                             website: self.websiteTextField.text,
                                                             facebookURL: self.facebookTextField.text)
            self.interactor?.updateContactDetail(requestModel)

        }
    }
    
}


extension ContactDetailViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.addressTextField {
            self.addressTextFieldSelected(textField)
            return false
        }
        return true
    }
}

extension ContactDetailViewController: SaveAddressCallback {

    func addressSaved(_ model: SignUpStepTwoDataModel, addressLineOne: String, addressLineTwo: String, mapAddress: String?) {

        self.navigationController?.popViewController(animated: true)
//        model.selectedValue = addressLineOne +  " " + addressLineTwo + ", " + "\((mapAddress ?? ""))"
//        model.selectedAddressLineOne = addressLineOne
//        model.selectedAddressLineTwo = addressLineTwo
//
//        let latModel = kSharedInstance.signUpViewModel.arrSignUpStepTwo.filter({$0.name == AppConstants.KeyLatitude})
//        latModel.first?.selectedValue = String(kSharedUserDefaults.latitude)
//        let longModel = kSharedInstance.signUpViewModel.arrSignUpStepTwo.filter({$0.name == AppConstants.KeyLongitude})
//        longModel.first?.selectedValue = String(kSharedUserDefaults.longitude)

        self.addressTextField.text = "\(addressLineOne) \(addressLineTwo) \(mapAddress)"


    }
}
