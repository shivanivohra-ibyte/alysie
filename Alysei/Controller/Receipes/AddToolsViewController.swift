//
//  AddToolsViewController.swift
//  Alysei Recipe Module
//
//  Created by mac on 30/07/21.
//

import UIKit

var selectToolsJson: [String : [ToolsArray]] = [:]
var selectedToolJson: [String : Any] = [:]
var selectedToolsArray = [ToolsArray()]

class AddToolsViewController: UIViewController, AddToolTableViewCellProtocol {
    @IBOutlet weak var addToolsView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var saveAndProceedTabBar: UIView!
    @IBOutlet weak var addMissingToolButton: UIButton!
    @IBOutlet weak var addToolsTableView: UITableView!
    @IBOutlet weak var addMissingToolView: UIView!
    
    @IBOutlet weak var addToolPopUpView: UIView!
    
    @IBOutlet weak var addToolQuantityView: UIView!
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var addToolUnitView: UIView!
    
    @IBOutlet weak var unitLabel: UILabel!
    
    @IBOutlet weak var addMissingToolTableView: UITableView!
    @IBOutlet weak var addedToolQuantityLabel: UILabel!
    @IBOutlet weak var addedToolItemButton: UIButton!
    
    @IBOutlet weak var addNewMissingToolBtn: UIButton!
    var newSearchModel: [AddToolsDataModel]? = []
    var addMissingToolModel: [ToolTypeDataModel]? = []
   
    var array1 = NSMutableArray()
    var array2 = NSMutableArray()

    var toolBar = UIToolbar()
    var picker1  = UIPickerView()
    var strReturn = String()
    var strReturn1 = Int()
    var arrQuantity = NSMutableArray()
    var arrUnit = NSMutableArray()
    var arraySelectedItem: [IndexPath] = []
    var arrayPickerData: [String] = []
    var selectedIndexPath : IndexPath?
    var selectedIndexPath1: IndexPath?
    
    var arrayFinal: [String] = []
    
    var strToolQuantity = Int()
    var strToolId = Int()
    var strToolUnit = String()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addedToolQuantityLabel.text = "\(arraySelectedItem.count) Items"
        addToolsTableView.reloadData()
    }
   
    override func viewDidLoad() {
    
        super.viewDidLoad()
        

        picker1.delegate = self
        picker1.dataSource = self
        
        arrQuantity = [1, 2]
        arrUnit = ["Kg", "Piece"]
        self.addNewMissingToolBtn.isHidden = true
        setUI()
        callAddTools()
        callListTools()
        
        self.addMissingToolView.isHidden = true
        self.addToolPopUpView.isHidden = true
        self.setupUI()
        self.addToolsTableView.delegate = self
        self.addToolsTableView.dataSource = self
        
        self.addMissingToolTableView.delegate = self
        self.addMissingToolTableView.dataSource = self
    }
    
    
    func setUI(){
        
        addToolsTableView.delegate = self
        addToolsTableView.dataSource = self
        addToolsView.layer.masksToBounds = false
        addToolsView.layer.shadowRadius = 2
        addToolsView.layer.shadowOpacity = 0.2
        addToolsView.layer.shadowColor = UIColor.lightGray.cgColor
        addToolsView.layer.shadowOffset = CGSize(width: 0 , height:2)
        searchView.layer.cornerRadius = 5
        saveButton.layer.cornerRadius = 5
        saveAndProceedTabBar.layer.masksToBounds = false
        saveAndProceedTabBar.layer.shadowRadius = 2
        saveAndProceedTabBar.layer.shadowOpacity = 0.8
        saveAndProceedTabBar.layer.shadowColor = UIColor.gray.cgColor
        saveAndProceedTabBar.layer.shadowOffset = CGSize(width: 0 , height:2)
    }
    
    func setupUI(){
        addToolQuantityView.layer.borderWidth = 1
        addToolQuantityView.layer.borderColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1).cgColor
        addToolQuantityView.layer.cornerRadius = 5
        addToolUnitView.layer.borderWidth = 1
        addToolUnitView.layer.borderColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1).cgColor
        addToolUnitView.layer.cornerRadius = 5
        addedToolQuantityLabel.text = "0 Items"

    }
    
    func setPickerToolbar(){
        
        picker1.backgroundColor = UIColor.white
        picker1.setValue(UIColor.black, forKey: "textColor")
        picker1.autoresizingMask = .flexibleWidth
        picker1.contentMode = .center
        picker1.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker1)
        picker1.reloadAllComponents()

        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 40))
        toolBar.barTintColor = AppColors.mediumBlue.color
        toolBar.tintColor = UIColor.white
        toolBar.sizeToFit()
        
       
    
       let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(onDoneButtonTapped))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    
       let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(onCancelButtonTapped))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)

        self.view.addSubview(toolBar)
        
            }
    
    @objc func onDoneButtonTapped() {
        
        switch picker1.tag {
        case 1:
            self.quantityLabel.text = String(self.strReturn1)
            toolBar.removeFromSuperview()
            picker1.removeFromSuperview()
        case 2:
            self.unitLabel.text = self.strReturn
            toolBar.removeFromSuperview()
            picker1.removeFromSuperview()
        default:
            break
        }
       
    }
    
    @objc func onCancelButtonTapped() {
        
        toolBar.removeFromSuperview()
        picker1.removeFromSuperview()

       }
    @IBAction func addMissingToolButton(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
       if sender.isSelected == false
       {
           self.addMissingToolButton.setImage(UIImage.init(named: "MENU"), for: .normal)
        self.addMissingToolView.isHidden = true
       }
       else
       {
           self.addMissingToolButton.setImage(UIImage.init(named: "5"), for: .normal)
        self.addMissingToolView.isHidden = false

        }
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        if addedToolQuantityLabel.text != "0 Items" {
            let addSteps = self.storyboard?.instantiateViewController(withIdentifier: "AddStepsViewController") as! AddStepsViewController
            addSteps.arrayIngridients = selectedIngridentsArray
            addSteps.arraytools = selectedToolsArray
            addSteps.page = 1
            self.navigationController?.pushViewController(addSteps, animated: true)
        }
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        let cancelPopUpVC = self.storyboard?.instantiateViewController(withIdentifier: "CancelPopUpViewController") as! CancelPopUpViewController
        selectedToolJson = ["selectedQuantity" : [strToolQuantity], "selectedUnit": [strToolUnit], "selectedToolId" : [strToolId]]
        cancelPopUpVC.modalPresentationStyle = .overFullScreen
        cancelPopUpVC.modalTransitionStyle = .crossDissolve
        cancelPopUpVC.Callback = {
            let cancelPopVC = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverRecipeViewController") as! DiscoverRecipeViewController
            cancelPopVC.checkbutton = 2
            self.navigationController?.pushViewController(cancelPopVC, animated: true)
            
        }
        self.present(cancelPopUpVC, animated: true)
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = addToolsTableView.cellForRow(at: indexPath) as! AddToolsTableViewCell
        cell.selectToolImgView.image = nil
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapForaddMyMissingTool(_ sender: Any) {
        
        let addmissIngridient = self.storyboard?.instantiateViewController(withIdentifier: "AddMissingToolViewController") as! AddMissingToolViewController
        self.addMissingToolView.isHidden = true
        self.addMissingToolButton.setImage(UIImage.init(named: "MENU"), for: .normal)
        self.addMissingToolButton.isSelected = false
        self.navigationController?.pushViewController(addmissIngridient, animated: true)
       
    }
    
    @IBAction func tapForClosePopUp(_ sender: Any) {
        self.addToolPopUpView.isHidden = true
    }
    
    
    @IBAction func tapForAddToolQuantiy(_ sender: Any) {
        
        picker1.tag = 1
        picker1.reloadAllComponents()
        setPickerToolbar()
    }
    @IBAction func tapForAddToolUnit(_ sender: Any) {
        picker1.tag = 2
        picker1.reloadAllComponents()
        setPickerToolbar()
    }
    
    @IBAction func tapForSaveTool(_ sender: UIButton) {
        if self.quantityLabel.text == "0" || self.unitLabel.text == "Unit"{
            self.addToolPopUpView.isHidden = false
            self.saveButton.layer.backgroundColor = UIColor.lightGray.cgColor
        }
        else{
            self.addToolPopUpView.isHidden = true
         
            
            let quantity = self.strReturn1
            let unit = self.strReturn
            let pickerData = String(quantity) + " " + unit
            arrayPickerData.append(pickerData)
            arraySelectedItem.append(selectedIndexPath ?? IndexPath(row: sender.tag, section: 0))
            self.addedToolQuantityLabel.text = "\(arraySelectedItem.count) Items"
            addToolsTableView.reloadData()
            self.saveButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha:1).cgColor
            
            selectedToolsArray.removeAll()
            for (indexPath,item) in arraySelectedItem.enumerated(){
              
                let valueIngridients: ToolsArray = (self.newSearchModel?[item.section].tools?[item.row]) as! ToolsArray
                print(valueIngridients)
                valueIngridients.pickerData = arrayPickerData[indexPath]
                valueIngridients.quantity = quantity
                valueIngridients.unit = unit
                selectedToolsArray.append(valueIngridients)
            }
        }
        
    }
    @IBAction func tapForShowAddedTools(_ sender: Any) {
        let recipeIngredients = self.storyboard?.instantiateViewController(withIdentifier: "RecipeIngredientsUseViewController") as! RecipeIngredientsUseViewController
        let selectedIngridient: [IngridentArray] = selectIngridientJson["selected_ingridient"]!
        recipeIngredients.arraySelectedItemTool = arraySelectedItem
//        recipeIngredients.arrayFinaltools = self.selectedToolsArray
       // recipeIngredients.arrayFinalIngridients = selectedIngridient
        selectToolsJson = ["selected_tool" : selectedToolsArray]
      
        self.navigationController?.pushViewController(recipeIngredients, animated: true)
    }
}

extension AddToolsViewController: UITableViewDelegate
, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == addToolsTableView{
        return self.newSearchModel?.count ?? 0
        }
        if tableView == addMissingToolTableView{
            return 1
        }
        else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == addToolsTableView{
        return newSearchModel?[section].tools?.count ?? 0
        }
        if tableView == addMissingToolTableView{
            return self.addMissingToolModel?.count ?? 0
        }
        else{
            return 0
        }
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == addToolsTableView{
        return 70
        }
        else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if tableView == addToolsTableView{
        return self.newSearchModel?[section].toolDataName
        }
        else{
            return ""
        }
        
    }
 

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == addToolsTableView{
        let cell:AddToolsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AddToolsTableViewCell") as! AddToolsTableViewCell
            
            cell.indexPath = indexPath
            cell.addToolDelegate = self


        let imgUrl = (kImageBaseUrl + (self.newSearchModel?[indexPath.section].tools?[indexPath.row].imageId?.imgUrl ?? ""))

        cell.img.setImage(withString: imgUrl)
//         cell.imgSelected.isHidden  = true
            
            strToolQuantity = self.newSearchModel?[indexPath.section].tools?[indexPath.row].quantity ?? 0
            strToolUnit = self.newSearchModel?[indexPath.section].tools?[indexPath.row].unit ?? ""
            strToolId = self.newSearchModel?[indexPath.section].tools?[indexPath.row].recipeToolIds ?? 0
        cell.label2.text = self.newSearchModel?[indexPath.section].tools?[indexPath.row].toolTitle
        strToolId = self.newSearchModel?[indexPath.section].tools?[indexPath.row].recipeToolIds ?? 0

        cell.label2?.font = UIFont(name: "Montserrat-Bold", size: 16)
        cell.img.layer.cornerRadius = cell.img.frame.height/2
            
            if arraySelectedItem.contains(indexPath){
                
                cell.selectToolImgView.isHidden = false
                
            }else {
                cell.selectToolImgView.isHidden = true
            }
            
        return cell
        }
        else{
            let cell:AddMissingToolsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AddMissingToolsTableViewCell") as! AddMissingToolsTableViewCell
            cell.toolitemLabel.text = self.addMissingToolModel?[indexPath.row].toolType
            
            cell.toolQuantityLabel.text = "\(self.addMissingToolModel?[indexPath.row].count ?? 0)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == addToolsTableView{
            return
        }
        else{
            self.addMissingToolButton.setImage(UIImage.init(named: "MENU"), for: .normal)
            self.addMissingToolView.isHidden = true
            selectedIndexPath1 = indexPath

            print("\(String(describing: selectedIndexPath1))")
            self.addToolsTableView.scrollToRow(at: selectedIndexPath1!, at: .top, animated: true)

        }
    }
    
    func tapForTool(indexPath: IndexPath){
        let currentCell = addToolsTableView.cellForRow(at: indexPath) as! AddToolsTableViewCell

        if currentCell.selectToolImgView.isHidden == false{
            selectedIndexPath = indexPath
        self.addToolPopUpView.isHidden = true
        currentCell.selectToolImgView.isHidden = true
            
            for (index,item) in arraySelectedItem.enumerated(){
                if item == indexPath{
                    arraySelectedItem.remove(at: index)
                    arrayPickerData.remove(at: index)
                   
                }
            }
            self.addedToolQuantityLabel.text = "\(arraySelectedItem.count) Items"
            if addedToolQuantityLabel.text != "0 Items"{
                self.saveButton.layer.backgroundColor = UIColor.lightGray.cgColor
            }
    }
        else{
            selectedIndexPath = indexPath
            self.addToolPopUpView.isHidden = false

       }
        
        
      
       
    }
    
}

extension AddToolsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch picker1.tag {
        case 1:
            
            return self.arrQuantity.count

        case 2:

        return self.arrUnit.count
            

        default:

        break

        }
     return 0
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var str_return : String = String ()
    
        switch picker1.tag {
        
        case 1:

            if let stName = self.arrQuantity.object(at: row) as? Int
         {
                str_return = String(stName)
         }

        case 2:

            if let stName = self.arrUnit.object(at: row) as? String
         {
             str_return = stName
         }

        default: break

        }
      return str_return
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        var strSelectedId = String()
        switch picker1.tag {
        
        case 1:
            
            if row == 0
            {
                self.strReturn1 = self.arrQuantity[0] as! Int
                 
            }
            if row == 1
            {
                self.strReturn1 = self.arrQuantity[1] as! Int
                 
            }
        
        case 2:
            if row == 0{
                self.strReturn = self.arrUnit[0] as! String
            }
            if row == 1
            {
                self.strReturn = self.arrUnit[1] as! String
                 
            }
      
        default:
            break
        }
    }
}

extension AddToolsViewController{
    
    func callAddTools(){
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getrecipeTools, requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
       
            let dictResponse = dictResponse as? [String:Any]
            

                if let data = dictResponse?["data"] as? [[String:Any]]{
                    self.newSearchModel = data.map({AddToolsDataModel.init(with: $0)})
                    self.addToolsTableView.reloadData()


            }
        }
    }
    
    func callListTools(){
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getrecipeTools, requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
       
            let dictResponse = dictResponse as? [String:Any]
            
                if let data = dictResponse?["types"] as? [[String:Any]]{
                    self.addMissingToolModel = data.map({ToolTypeDataModel.init(with: $0)})
                    self.addMissingToolTableView.reloadData()
            }
        }
    }
}
