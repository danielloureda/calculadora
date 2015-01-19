//
//  InfixToPostfix.swift
//  Calculadora
//
//  Created by Daniel Loureda Arteaga on 19/1/15.
//  Copyright (c) 2015 Daniel Loureda Arteaga. All rights reserved.
//

import UIKit

class InfixToPostfix {

    var stack: Array<Character>
    let input: String
    var output: String
    
    init(inputString: String){
        input = inputString
        stack = Array()
        output = ""
    }
    
    func parse() -> String{
        for character in input{
            switch(character){
            case "+":
                operatorFound(character,prec: 1)
            case "-":
                operatorFound(character,prec: 1)
            case "*":
                operatorFound(character,prec: 2)
            case "/":
                operatorFound(character,prec: 2)
            case "(":
                stack.push(character)
            case ")":
                closingBracketFound(character)
            case " ": ()
            default:
                output.append(character)
            }
        }
        while !stack.isEmpty{
            output.append(Character(" "))
            output.append(stack.pop()!)
        }
        return output
    }
    
    func operatorFound(op: Character, prec: Int){
        output.append(Character(" "))
        while !stack.isEmpty{
            let topChar = stack.pop()!
            if topChar == "("{
                stack.push(topChar)
                break
            }else{
                var precTop: Int
                if topChar == "+" || topChar == "-"{
                    precTop = 1
                }else{
                    precTop = 2
                }
                if precTop < prec{
                    stack.push(topChar)
                    break
                }else{
                    output.append(topChar)
                    output.append(Character(" "))
                }
            }
        }
        stack.push(op)
    }

    func closingBracketFound(bracket: Character){
        while !stack.isEmpty{
            let char = stack.pop()!
            if char == "("{
                break
            }else{
                output.append(Character(" "))
                output.append(char)
            }
        }
    }    
}
