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
            if candyCount >= 250 {
                candyGoal = 500
                candyImgNumber = 6
            } else if candyCount >= 100 {
                candyGoal = 250
                candyImgNumber = 5
            } else if candyCount >= 25 {
                candyGoal = 100
                candyImgNumber = 4
            } else if candyCount >= 10 {
                candyGoal = 25
                candyImgNumber = 3
            } else if candyCount >= 5 {
                candyGoal = 10
                candyImgNumber = 2
            } else if candyCount > 0 {
                candyGoal = 5
                candyImgNumber = 1
            } else {
                candyGoal = 5
                candyImgNumber = 0
            }
            UserDefaults.standard.set(candyGoal, forKey: "candyGoal")
            UserDefaults.standard.set(candyImgNumber, forKey: "candyImgNumber")
        }
    }
    @Published private(set) var candyGoal = 5
    @Published private(set) var candyImgNumber = 0
    
    @Published private(set) var candyMeterRangeMax = 0
    
    @Published private(set) var storedIDs: [String] = []
    
    init() {
        name = UserDefaults.standard.string(forKey: "userName") ?? ""
        chosenCostumeString = UserDefaults.standard.string(forKey: "chosenCostumeString") ?? "👻"
        chosenCostumeID = UserDefaults.standard.integer(forKey: "chosenCostumeID")
        candyCount = UserDefaults.standard.integer(forKey: "candyCount")
        candyGoal = UserDefaults.standard.integer(forKey: "candyGoal")
        storedIDs = UserDefaults.standard.stringArray(forKey: "storedIDs") ?? []
        candyImgNumber = UserDefaults.standard.integer(forKey: "candyImgNumber")
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
    
    func addCandy(_ candy: Candy) -> Bool{
        if storedIDs.contains(candy.id) {
            return false
        }
        candyCount += 1
        storeID(id: candy.id)
        UserDefaults.standard.set(candyCount, forKey: "candyCount")
        return true
    }
    
    func storeID(id: String) {
        storedIDs.append(id)
        UserDefaults.standard.set(storedIDs, forKey: "storedIDs")
    }
    
    func generateID() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let id = String((0..<6).map{ _ in letters.randomElement()! })
        storeID(id: id)
        print(id)
        return id
    }
    
    
}

