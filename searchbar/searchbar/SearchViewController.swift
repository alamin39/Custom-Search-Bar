//
//  SearchViewController.swift
//  searchbar
//
//  Created by Al-Amin on 2023/10/08.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var clearButton: UIImageView!
    @IBOutlet weak var clearView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        textField.delegate = self
        cancelButton.isHidden = true
        
        searchView.layer.cornerRadius = 4
        searchView.layer.borderWidth = 1
        searchView.layer.borderColor = UIColor.red.cgColor
        
        clearButton.isHidden = true
        
        clearView.isUserInteractionEnabled = true
        clearView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clearAll)))
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: textField)
    }
    
    @objc private func clearAll() {
        textField.text = ""
        clearButton.isHidden = true
    }
    
    @objc private func textDidChange() {
        clearButton.isHidden = (textField.text?.isEmpty == true)
        if let searchText = textField.text {
            print(searchText)
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        textField.resignFirstResponder()
        textField.text = ""
        clearButton.isHidden = true
        cancelButton.isHidden = true
        searchView.layer.borderWidth = 1
    }
}

extension SearchViewController: UITextFieldDelegate, UISearchBarDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        clearButton.isHidden = (textField.text?.isEmpty == true)
        cancelButton.isHidden = false
        searchView.layer.borderWidth = 2
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        clearButton.isHidden = (textField.text?.isEmpty == true)
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let searchText = textField.text {
            print(searchText)
        }
        return true
    }
}
