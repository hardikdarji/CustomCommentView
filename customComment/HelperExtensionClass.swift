//
//  HelperExtensionClass.swift
//  CustomCommentView
//
//  Created by hardik.darji on 3/28/18.
//  Copyright © 2018 hardikdarji. All rights reserved.
//

import UIKit
extension UITableView {
    func indexPathForView (view : UIView) -> IndexPath? {
        let location = view.convert(CGPoint(x: 0,y :0), to: self)
        return indexPathForRow(at: location)
    }
}
