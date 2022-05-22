//
//  ViewController.swift
//  HW5
//
//  Created by Artem Mazurkevich on 06.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var availableProductsLabel: UILabel!
    @IBOutlet weak var productEmojiLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productsPicker: UIPickerView!
    @IBOutlet weak var incomeLabel: UILabel!
    
    var currentProduct: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsPicker.delegate = self
        productsPicker.dataSource = self
        initData()
    }
    
    @IBAction func onBuyButton(_ sender: Any) {
        buyCurrentProduct()
        productsPicker.reloadAllComponents()
        updateAvailableProducts()
        updateCurrentProduct()
    }
    
    @IBAction func onSkipButton(_ sender: Any) {
        updateCurrentProduct()
    }
    
    @IBAction func onSellButton(_ sender: Any) {
        if StoreManager.shared.availableProducts.isEmpty {
            showEmptyStoreAlert()
        } else {
            sellProduct()
            productsPicker.reloadAllComponents()
            updateAvailableProducts()
            updateIncome()
        }
    }
    
    private func initData() {
        updateAvailableProducts()
        updateCurrentProduct()
        updateIncome()
    }
    
    private func showEmptyStoreAlert() {
        let alert = UIAlertController(title: "Oops...", message: "Your store is empty, please buy some products before selling.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func updateAvailableProducts() {
        availableProductsLabel.text = "Available products (\(StoreManager.shared.availableProducts.count))"
    }
    
    private func updateCurrentProduct() {
        currentProduct = StoreManager.shared.generateRandomProduct()
        productNameLabel.text = "Product name: \(currentProduct.name)"
        productDescriptionLabel.text = "Product description: \(currentProduct.description)"
        productPriceLabel.text = "Product price: \(currentProduct.price) $"
        productEmojiLabel.text = currentProduct.emoji
    }
    
    private func updateIncome() {
        incomeLabel.text = "💰 Income: \(StoreManager.shared.income)$ 💰"
    }
    
    private func buyCurrentProduct() {
        StoreManager.shared.buyProducts(products: currentProduct)
    }
    
    private func sellProduct() {
        let sellingProduct = StoreManager.shared.availableProducts[productsPicker.selectedRow(inComponent: 0)]
        StoreManager.shared.sellProducts(products: sellingProduct)
    }
}

extension UIViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return StoreManager.shared.availableProducts.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return StoreManager.shared.availableProducts[row].getStringValue()
    }
}
