//
//  LatestColorEditorViewController.swift
//  Example
//
//  Created by Matsuoka Yoshiteru on 2018/10/21.
//  Copyright © 2018年 culumn. All rights reserved.
//

import UIKit


protocol ColorEditorViewControllerDelegate: class {
    
    func viewController(
         didEdit color: UIColor
    )
}

class ColorEditorViewController: UIViewController {

    weak var delegate: ColorEditorViewControllerDelegate?

    @IBOutlet weak var colorPicker: ColorPickerView!

    var selectedColor = UIColor.white

    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        colorPicker.updateSelectedColor(selectedColor)
        colorPicker.delegate = self
        
    }

    @IBAction func didTapCloseButton(_ sender: UIButton) {
        dismiss(animated: true) {
            self.delegate?.viewController(didEdit: self.selectedColor)
        }
    }
}

// ++++++++++++++++++++++++++
// ++++++++++++++++++++++++++
// ++++++++++++++++++++++++++
extension ColorEditorViewController: ColorPickerViewDelegate {

    func colorPickerWillBeginDragging(_ colorPicker: ColorPickerView) {
        selectedColor = colorPicker.selectedColor
    }

    func colorPickerDidSelectColor(_ colorPicker: ColorPickerView) {
        selectedColor = colorPicker.selectedColor
    }

    func colorPickerDidEndDagging(_ colorPicker: ColorPickerView) {
        selectedColor = colorPicker.selectedColor
    }
}
