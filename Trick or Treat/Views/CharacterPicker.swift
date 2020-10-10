//
//  ContentView.swift
//  Trick or Treat
//
//  Created by Joshua Hoffman on 10/9/20.
//

import SwiftUI

struct CharacterPicker: View {
    @ObservedObject var viewModel: TrickOrTreatViewModel
    
    @Binding var isPresented: Bool
    
    @State var nameField: String = ""
    
    var body: some View {
        
        ZStack {
            
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Text("Choose your costume...")
                    .font(.system(size: 30))
                    .bold()
                LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]) {
                    ForEach(viewModel.costumes, id: \.id){ costume in
                        ZStack {
                            Circle()
                                .fill(Color(UIColor.systemGray))
                                .frame(width: viewModel.chosenCostumeID == costume.id ? 130 : 0)
                                .animation(.linear(duration: 0.76))
                            
                            Text(costume.emoji)
                                .font(.system(size: 80))
                                .onTapGesture {
                                    viewModel.chooseCostume(id: costume.id)
                                }
                        }
                        
                    }
                }
                TextField("Your First Name", text: $nameField)
                    .font(.system(size: 20))
                    .padding(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                    .multilineTextAlignment(.center)
                    .padding()
                Button(action: {
                    if nameField != "" {
                        viewModel.updateName(name: nameField)
                        isPresented = false
                    }
                }) {
                    Text("Continue")
                        .font(.system(size: 25))
                        .bold()
                        .shadow(radius: 0)
                        .padding()
                        .foregroundColor(.white)
                        .background(viewModel.chosenCostumeID == -1 || nameField == "" ? Color(UIColor.systemGray) : Color.orange)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .padding(.top)
                }
                .disabled(viewModel.chosenCostumeID == -1 || nameField == "")
                    
            }
            .padding()
        }
        .onAppear {
            nameField = viewModel.name
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterPicker()
//            .preferredColorScheme(.dark)
//    }
//}
