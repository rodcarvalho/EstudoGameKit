//
//  MyUtils.swift
//  EstudoGameKit
//
//  Created by Rodrigo Carvalho on 24/05/21.
//

import CoreGraphics
import GameplayKit

func + (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func += (left: inout CGPoint, right: CGPoint) {
  left = left + right
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func -= (left: inout CGPoint, right: CGPoint) {
  left = left - right
}

func * (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

func *= (left: inout CGPoint, right: CGPoint) {
  left = left * right
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func *= (point: inout CGPoint, scalar: CGFloat) {
  point = point * scalar
}

func / (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

func /= (left: inout CGPoint, right: CGPoint) {
  left = left / right
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

func /= (point: inout CGPoint, scalar: CGFloat) {
  point = point / scalar
}

#if !(arch(x86_64) || arch(arm64))
func atan2(y: CGFloat, x: CGFloat) -> CGFloat {
  return CGFloat(atan2f(Float(y), Float(x)))
}

func sqrt(a: CGFloat) -> CGFloat {
  return CGFloat(sqrtf(Float(a)))
}
#endif

extension CGPoint {
  
  func length() -> CGFloat {
    return sqrt(x*x + y*y)
  }
  
  func normalized() -> CGPoint {
    return self / length()
  }
  
  var angle: CGFloat {
    return atan2(y, x)
  }
}

//let pi = .pi

func shortestAngleBetween(_ angle1: CGFloat,
                          angle2: CGFloat) -> CGFloat {
    let twoπ = .pi * 2.0
    var angle = (angle2 - angle1).truncatingRemainder(dividingBy: (CGFloat)(twoπ))
    if (angle >= .pi) {
        angle = angle - CGFloat(twoπ)
  }
    if (angle <= -.pi) {
        angle = angle + CGFloat(twoπ)
  }
  return angle
}

extension CGFloat {
  func sign() -> CGFloat {
    return (self >= 0.0) ? 1.0 : -1.0
  }
}

extension CGFloat {
  static func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / Float(UInt32.max))
  }

  static func random(min: CGFloat, max: CGFloat) -> CGFloat {
    assert(min < max)
    return CGFloat.random() * (max - min) + min
  }
}

// MARK: Points and vectors
extension CGPoint {
    init(_ point: SIMD2<Float>) {
    self.init()
    x = CGFloat(point.x)
    y = CGFloat(point.y)
  }
}
extension SIMD2 {
  init(_ point: CGPoint) {
    self.init(x: Float(point.x) as! Scalar, y: Float(point.y) as! Scalar)
  }
}
