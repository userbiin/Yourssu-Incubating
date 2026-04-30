//
//  ContentView.swift
//  Calculator
//
//  Created by Subin on 4/30/26.
//


import SwiftUI
import SwiftData

struct ContentView: View {
    enum CalcOperator {
        case add, subtract, multiply, divide
    }
    
    @State var display: String = "버튼을 눌러주세요!"
    @State var input1: String = "" // TextField 에는 String binding 이 필요함 (Binding<String>)
    @State var input2: String = "" // @State 로 선언 시 초기값 지정 필요
    @State var res: Int = 0
    
    
    func addValue(a: String, b: String) {
        if let x = Int(a), let y = Int(b) {
            res = x + y
            display = "\(a) + \(b) = \(res)"
        }
        else {
            display = "숫자를 모두 입력해주세요."
        }
    }
    
    func subtractValue(a: String, b: String) {
        if let x = Int(a), let y = Int(b) {
            res = x - y
            display = "\(a) - \(b) = \(res)"
        }
        else {
            display = "숫자를 모두 입력해주세요."
        }

    }
    
    func divideValue(a: String, b: String) {
        if let x = Int(a), let y = Int(b) {
            if y == 0  {
                display = "0으로 나눌 수 없습니다."
            }
            else {
                res = x / y
                display = "\(a) / \(b) = \(res)"
            } }
        else {
            display = "숫자를 모두 입력해주세요."
        }

    }
    
    func multiplyValue(a: String, b: String) {
        if let x = Int(a), let y = Int(b) {
            res = x * y
            display = "\(a) x \(b) = \(res)"
        }
        else {
            display = "숫자를 모두 입력해주세요."
        }

    }

    
    var body: some View {
        VStack() {
            TextField("첫 번째 숫자를 입력해주세요", text: $input1) // binding($) 인자 필요
                .keyboardType(.decimalPad)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(Color(.systemGray))
                .frame(maxWidth: 300, alignment: .leading)
                .padding(10)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(radius: 5)
            
            TextField("두 번째 숫자를 입력해주세요", text: $input2)
                .keyboardType(.decimalPad)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(Color(.systemGray))
                .frame(maxWidth: 300, alignment: .leading)
                .padding(10)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(radius: 5)
            
            Text(display)
                .padding(20)
            
            Button("더하기"){
                addValue(a: input1, b: input2)
            }
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(Color(.white))
                .frame(maxWidth: 300, alignment: .center)
                .padding(10)
                .background(Color(.systemTeal))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(radius: 5)
            
            Button("빼기") {
                subtractValue(a: input1, b: input2)
            }
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(Color(.white))
                .frame(maxWidth: 300, alignment: .center)
                .padding(10)
                .background(Color(.systemTeal))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(radius: 5)
            
            Button("곱하기") {
                multiplyValue(a: input1, b: input2)
            }
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(Color(.white))
                .frame(maxWidth: 300, alignment: .center)
                .padding(10)
                .background(Color(.systemTeal))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(radius: 5)
            
            Button("나누기") {
                divideValue(a: input1, b: input2)
            }
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(Color(.white))
                .frame(maxWidth: 300, alignment: .center)
                .padding(10)
                .background(Color(.systemTeal))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(radius: 5)
            
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}


