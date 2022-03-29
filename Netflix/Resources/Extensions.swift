//
//  Extensions.swift
//  Netflix
//
//  Created by Abraam on 29.03.2022.
//

import Foundation
extension String {
    func capitalFirstLatter() ->String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
