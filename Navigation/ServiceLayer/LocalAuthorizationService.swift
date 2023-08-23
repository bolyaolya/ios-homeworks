//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Ольга Бойко on 23.08.2023.
//

import Foundation
import LocalAuthentication

final class LocalAuthorizationService {
    
    private lazy var context = LAContext()
    private lazy var canEvaluateBiometrics = false
    var error : NSError? = nil
    private let policy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
    lazy var typeOfBiometry : LABiometryType = .none
    
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool, Error?) -> Void) {
        
        canEvaluateBiometrics = context.canEvaluatePolicy(policy, error: &error)
        
        if canEvaluateBiometrics == true {
            context.evaluatePolicy(policy, localizedReason: "Авторизуйтесь для входа") { result, error in
                authorizationFinished(result, error)
            }
            
        } else {
            print("Биометрия отключена")
        }
    }
    
    func canEvaluate() -> Int {
        let result = context.canEvaluatePolicy(policy, error: &error)
        
        if result {
            typeOfBiometry = context.biometryType
            return typeOfBiometry.rawValue
        } else {
            return 0
        }
    }
}
