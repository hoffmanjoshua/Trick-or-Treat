//
//  DefaultView.swift
//  Trick or Treat
//
//  Created by Joshua Hoffman on 10/9/20.
//

import SwiftUI
import ConfettiView

struct DefaultView: View {
    
    @ObservedObject var viewModel = TrickOrTreatViewModel()
    @State var sheetPresented = false
    @State var confettiOn = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack(alignment: .center) {
                    Text(viewModel.chosenCostumeString)
                        .font(.system(size: 50))
                        .onTapGesture(count: 1, perform: {
                            sheetPresented = true
                        })
                    Spacer()
                    Text("\(viewModel.name)")
                        .font(.system(size: 30))
                        .bold()
                        .foregroundColor(Color(UIColor.systemPurple))
                }
                .padding()
                VStack {
                    VStack(spacing: 0) {
                        Text("🔮")
                            .font(.system(size: 200))
                            .overlay(
                                Text(String(viewModel.candyCount))
                                    .font(.system(size: 80, design: .rounded))
                                    .bold()
                                    .shadow(radius: 5)
                                    .foregroundColor(.white)
                                    .offset(y: -10)
                            )
                        Text("Pieces of Candy")
                            .offset(y: -15)
                            .padding(.bottom)
                    }
                    
                    VStack {
                        HStack {
                            Text("🚩 Next Goal:")
                                .font(.system(size: 20))
                            Text("\(viewModel.candyGoal)")
                                .bold()
                                
                        }
                        .font(.system(size: 20))
                    }
                    .padding()
                    .background(Color(UIColor.tertiarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .padding(.bottom)
                    
                    Spacer()
                    Button(action: {
                        let destination = URLComponents(string: "trickortreat://candy/\(viewModel.generateID())")
                        UIApplication.shared.open(URL(string: "sms:&body=\(destination!)")!, options: [:], completionHandler: nil)
                    }) {
                        Text("Send candy to a friend!")
                            .font(.system(size: 20))
                            .bold()
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                    }
                    Spacer()
                }
                if confettiOn {
                    ConfettiView( confetti: [.text("🍬"), .text("🍭")])
                }
            }
            .sheet(isPresented: $sheetPresented, onDismiss: {
                if viewModel.name == "" || viewModel.chosenCostumeID == -1 {
                    sheetPresented = true
                }
            }, content: {
                CharacterPicker(viewModel: viewModel, isPresented: $sheetPresented)
            })
            .onOpenURL{ url in
                let receivedCandy = url.receivedCandy
                if (receivedCandy != nil) {
                    if viewModel.addCandy(receivedCandy!) {
                        confettiOn = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                confettiOn = false
                            }
                        }
                    }
                }
            }
            .onAppear {
                if viewModel.name == "" {
                    sheetPresented = true
                }
        }
        }
    }
}

struct DefaultView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultView()
    }
}
