//
//  TrickOrTreatViewModel.swift
//  Trick or Treat
//
//  Created by Joshua Hoffman on 10/9/20.
//
import SwiftUI
import Combine

class TrickOrTreatViewModel: ObservableObject {
    
    @Published private(set) var name = ""
    @Published private(set) var chosenCostumeID: Int = -1
    @Published private(set) var chosenCostumeString: String = ""
    
    @Published private(set) var candyCount = 0 {
        didSet {
            if candyCount >= 25 {
                candyGoal = 100
            } else if candyCount >= 100 {
                candyGoal = 250
            }
            UserDefaults.standard.set(candyGoal, forKey: "candyGoal")
        }
    }
    @Published private(set) var candyGoal = 25
    
    @Published private(set) var candyMeterRangeMax = 0
    
    init() {
        name = UserDefaults.standard.string(forKey: "userName") ?? ""
        chosenCostumeString = UserDefaults.standard.string(forKey: "chosenCostumeString") ?? "👻"
        chosenCostumeID = UserDefaults.standard.integer(forKey: "chosenCostumeID")
        candyCount = UserDefaults.standard.integer(forKey: "candyCount")
        candyGoal = UserDefaults.standard.integer(forKey: "candyGoal")
    }
    
    public var costumes = [
        Costume(emoji: "👻", id: 0, alias: "Ghost"),
        Costume(emoji: "👽", id: 1, alias: "Alien"),
        Costume(emoji: "🤠", id: 2, alias: "Cowboy"),
        Costume(emoji: "🧟‍♂️", id: 3, alias: "Zombie"),
        Costume(emoji: "🧚‍♀️", id: 4, alias: "Fairy"),
        Costume(emoji: "🦁", id: 5, alias: "Lion"),
        Costume(emoji: "🦄", id: 6, alias: "Unicorn"),
        Costume(emoji: "🤖", id: 7, alias: "Robot")]
    
    func chooseCostume(id: Int){
        chosenCostumeID = id
        chosenCostumeString = costumes.first(where: { $0.id == id })?.emoji ?? ""
        UserDefaults.standard.set(chosenCostumeID, forKey: "chosenCostumeID")
        UserDefaults.standard.set(chosenCostumeString, forKey: "chosenCostumeString" )
    }
    
    func updateName(name: String) {
        UserDefaults.standard.set(name, forKey: "userName")
        self.name = name
    }
    
    func addCandy() {
        candyCount += 1
        UserDefaults.standard.set(candyCount, forKey: "candyCount")
    }
    
    
}

