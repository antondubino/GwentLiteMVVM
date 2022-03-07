//
//  Box.swift
//  MVVM
//
//  Created by Антон Дубино on 09.12.2021.
//

import Foundation
import UIKit

class Dynamic<T> {
    typealias Listener = (T) -> ()
  private var listeners: [Listener] = []
  init(_ v: T) {
    value = v
  }
  var value: T {
    didSet {
      for l in listeners { l(value) } }
  }
  func bind(_ l: @escaping Listener) {
    listeners.append(l)
    l(value)
  }
  func addListener(_ l: @escaping Listener) {
    listeners.append(l)
  }
}
    
infix operator >>>
func >>> <T>(left: Dynamic<T>, right: @escaping (T) -> Void) {
  left.bind(right)
}

func >> <T>(left: Dynamic<T>, right: @escaping (T) -> Void) {
  return left.addListener(right)
}
