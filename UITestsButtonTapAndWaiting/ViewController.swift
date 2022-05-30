//
//  ViewController.swift
//  UITestsButtonTapAndWaiting
//
//  Created by Nikolay Suvandzhiev on 30/05/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var buttonGo_9: UIButton!
    @IBOutlet private var buttonGo_2: UIButton!
    @IBOutlet private var blockerView_3: UIView!


    @IBAction private func buttonGoTapped() {
        print("buttonGoTapped")
        textView.text.append(contentsOf: "[\(Date())] Go tapped\n")
        textView.scrollToBottom()
    }

    @IBAction private func unhideGoButton9() {
        print("unhideGoButton9")
        self.buttonGo_9.isHidden = false
    }

    @IBAction private func hideBlockerView3() {
        print("hideBlockerView3")
        self.blockerView_3.isHidden = true
    }

    @IBAction private func enableGoButton2() {
        print("enableGoButton2")
        self.buttonGo_2.isEnabled = true
        self.buttonGo_2.isUserInteractionEnabled = true
    }
}

extension UIScrollView {
    func scrollToBottom() {
        let contentHeight = contentSize.height - frame.size.height
        let contentoffsetY = max(contentHeight, 0)
        setContentOffset(CGPoint(x: 0, y: contentoffsetY), animated: true)

        // an iOS bug, see https://stackoverflow.com/a/20989956/971070
        self.isScrollEnabled = false
        self.isScrollEnabled = true
    }
}

