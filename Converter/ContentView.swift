//
//  ContentView.swift
//  Converter
//
//  Created by Naga Tharun Makkena on 23/06/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputTemerature = 0.0
    @State private var inputUnit = "°C"
    @State private var outputTemperature = 0.0
    @State private var outputUnit = "°C"
    
    @FocusState private var inputIsFocused: Bool
    
    let units = ["°C", "°F", "K"]
    
    var convertTemeprature: Double {
        let inputTemp = inputTemerature

        if inputUnit == units[0] {
            if outputUnit == units[1] {
                return (inputTemp * 9 / 5) + 32
            } else if outputUnit == units[2] {
                return inputTemp + 273.15
            }
        } else if inputUnit == units[1] {
            if outputUnit == units[0] {
                return (inputTemp - 32) * 5 / 9
            } else if outputUnit == units[2] {
                return (inputTemp - 32) * 5 / 9 + 273.15
            }
        } else {
            if outputUnit == units[0] {
                return inputTemp - 273.15
            } else if outputUnit == units[1] {
                return (inputTemp - 273.15) * 9 / 5 + 32
            }
        }
        
        return inputTemp
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Input Temperature Unit:", selection: $inputUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Input Temperature Unit:")
                }
                
                Section {
                    TextField("Input Temperature", value: $inputTemerature, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Input temperature:")
                }
                
                Section {
                    Picker("Output Temperature Unit:", selection: $outputUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Output Temperature Unit:")
                }
                
                Section {
                    Text("\(convertTemeprature.formatted())")
                } header: {
                    Text("Output temperature:")
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
            .navigationTitle("Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
