//
//  SelectDateView.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var service : RoversViewModel

    var body: some View {
        NavigationView{
            Form{
                VStack {
                    DatePicker(selection: $selectedDate,
                               in: ...Date(),
                               displayedComponents: .date) {}
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .border(Color.black.opacity(0.2))
                        .padding(.bottom,50)
                    
                    buttonRow
                }
            }
            .navigationTitle("Select Date")
        }
    }
    
    var buttonRow : some View {
        HStack {
            Button(action: {
                service.roverPhotoDate = nil
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
                presentationMode.wrappedValue.dismiss()
                service.roverPhotoDate = service.dateFormatter.string(from: selectedDate)
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
        CalendarView(selectedDate: .constant(Date()))
    }
}

