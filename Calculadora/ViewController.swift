//
//  ViewController.swift
//  Calculadora
//
//  Created by Daniel Loureda Arteaga on 19/1/15.
//  Copyright (c) 2015 Daniel Loureda Arteaga. All rights reserved.
//

import UIKit

typealias Operador = (Double, Double) -> (Double)

extension String{
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var txInput: UITextField!
    @IBOutlet weak var lbResult: UILabel!

    @IBAction func solvePressed() {
        //well formed expression is considered
        let input = txInput.text!
        let result = supercalculadora(input)
        lbResult.text = result.description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func supercalculadora(input:String) -> Double{
        //convert infix notation to postfix notation (RPN)
        var itp = InfixToPostfix(inputString: input)
        let output = itp.parse()
        
        //split the string in order to get numbers and operators
        let ops = output.componentsSeparatedByString(" ")
        
        //put expression into a stack to evaluate them
        var stack = Array<String>()
        for string in ops{
            stack.push(string)
        }
        
        //evaluate the RPN
        return calculate(&stack)
    }
    
    func calculate(inout stack: Array<String>) -> Double{
        let token = stack.pop()!
        var x,y : Double
        x = 0
        if token.doubleValue == 0{
            y = calculate(&stack)
            x = calculate(&stack)
            switch token{
            case "+":
                x = calculadora(x, op2: y, operador: suma)
            case "-":
                x = calculadora(x, op2: y, operador: resta)
            case "*":
                x = calculadora(x, op2: y, operador: multiplicacion)
            case "/":
                x = calculadora(x, op2: y, operador: division)
            case "^":
                x = calculadora(x, op2: y, operador: potencia)
            default:()
            }
        }else{
            x = token.doubleValue
        }
        return x
    }
    
    func calculadora(op1:Double, op2:Double, operador: Operador) -> Double{
        return operador(op1, op2)
    }

    func suma(op1: Double, op2: Double) -> Double{
        return op1+op2
    }
    
    func resta(op1: Double, op2: Double) -> Double{
        return op1-op2
    }
    func multiplicacion(op1: Double, op2: Double) -> Double{
        return op1*op2
    }
    
    func division(op1: Double, op2: Double) -> Double{
        return op1/op2
    }
    func potencia(op1: Double, op2: Double) -> Double{
        return pow(op1, op2)
    }
}

