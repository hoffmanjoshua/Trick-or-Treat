//
//  CandyMeter.swift
//  Trick or Treat
//
//  Created by Joshua Hoffman on 10/9/20.
//

import SwiftUI

struct CandyMeterView: View {
    
    @ObservedObject var viewModel: TrickOrTreatViewModel
    
    var body: some View {
        Group {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 0.1, green: 0, blue: 1, opacity: 0.0))
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(UIColor.systemGray))
                    
                    HStack(spacing: 3) {
                        ForEach(0..<Int((Double(viewModel.candyCount) / Double(viewModel.candyGoal)) * 5)) {_ in
                            Text("🍬")
                                .font(.system(size: 30))
                                .padding(.horizontal,5)
                        }
                        if viewModel.candyCount != viewModel.candyGoal {
                            Spacer()
                        }
                    }
                }
                .frame(width: 250, height: 50)
                Text("\(viewModel.candyCount) / \(viewModel.candyGoal)")
                    .font(.system(size: 25, design: .rounded))
                    .bold()
            }
        }
    }
}
//
//struct CandyMeter_Previews: PreviewProvider {
//    static var previews: some View {
//        CandyMeterView(piecesOfCandy: 19, goal: 25)
//    }
//}
