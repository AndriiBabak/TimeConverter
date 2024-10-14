//
//  ContentView.swift
//  TimeConverter
//
//  Created by Andrey Babak on 14/10/2024.
//

import SwiftUI

enum TimeUnit: String, CaseIterable {
    case seconds = "SEC"
    case minutes = "MIN"
    case hours = "H"
    case days = "D"
    
    var inSeconds: Double {
        switch self {
            case .seconds: return 1
            case .minutes: return 60
            case .hours: return 3600
            case .days: return 86400
        }
    }
}

struct ContentView: View {
    @State private var inputValue = 0.0 // Было inputQuantity
    @State private var selectedUnit: TimeUnit = .seconds
    @State private var convertedUnit: TimeUnit = .seconds
    @FocusState private var amountIsFocused: Bool
    
    var convertedValue: Double {
        let valueInSeconds = inputValue * selectedUnit.inSeconds
        return valueInSeconds / convertedUnit.inSeconds
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Enter the Quantity") {
                    TextField("Quantity", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Select the Unit", selection: $selectedUnit) {
                        ForEach(TimeUnit.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Converted Value") {
                    Text(convertedValue, format: .number)
                    
                    Picker("Convert to", selection: $convertedUnit) {
                        ForEach(TimeUnit.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Time Converter")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
