//
//  SelectDateView.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import SwiftUI

struct CalendarView: View {
    
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    @State private var selectedDate : Date = Date()
    @State private var solDay : String = ""
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var helperService = NasaAPIViewModel()
    
    var body: some View {
        VStack {
            Form{
                VStack {
                    DatePicker(selection: $selectedDate,
                               in: ...Date(),
                               displayedComponents: .date) {
                        Text("SelectDate")
                    }
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .border(Color.black.opacity(0.2))
                    .padding(.bottom,50)
                    
                    buttonRow
                }
                VStack(alignment: .leading) {
                    Text("Enter Sol Day")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.medium)
                    TextField("Sol Day", text: $solDay)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding(.bottom,20)
                        .padding(.top,5)
                    
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Back")
                                .font(.system(.title3, design: .rounded))
                                .bold()
                        })
                        .foregroundColor(.red)
                        
                        Spacer()

                        
                        Button(action: {
                            helperService.selectedMarsDate = Int(solDay) ?? 0
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Select")
                                .font(.system(.title3, design: .rounded))
                                .bold()
                        })
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                .padding(.top, 30)
            }
        }
    }
    
    var buttonRow : some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Back")
                    .font(.system(.title3, design: .rounded))
                    .bold()
            })
            .foregroundColor(.red)
            
            Spacer()
            
            Button(action: {
                selectedDate = Date()
            }, label: {
                Text("Today")
                    .font(.system(.title3, design: .rounded))
                    .bold()
            })
            Spacer()
            
            Button(action: {
                helperService.selectedEarthDate = dateFormatter.string(from: selectedDate)
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Select")
                    .font(.system(.title3, design: .rounded))
                    .bold()
            })
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct SelectDateView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
