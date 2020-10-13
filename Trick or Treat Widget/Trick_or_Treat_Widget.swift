//
//  Trick_or_Treat_Widget.swift
//  Trick or Treat Widget
//
//  Created by Joshua Hoffman on 10/13/20.
//

import WidgetKit
import SwiftUI

struct CandyEntry: TimelineEntry {
    let date: Date = Date()
    let candyCount: Int
    let candyImgNumber: Int
}

struct Provider: TimelineProvider {
    public typealias Entry = CandyEntry
    
    var userDefaults = UserDefaults(suiteName: "group.com.hoffmanjoshua.Trick-or-Treat")!
    
    func placeholder(in context: Context) -> CandyEntry {
        return CandyEntry(candyCount: 0, candyImgNumber: 0)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (CandyEntry) -> Void) {
        let entry = CandyEntry(candyCount: userDefaults.integer(forKey: "candyCount"), candyImgNumber: userDefaults.integer(forKey: "candyImgNumber"))
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<CandyEntry>) -> Void) {
        let entry = CandyEntry(candyCount: userDefaults.integer(forKey: "candyCount"), candyImgNumber: userDefaults.integer(forKey: "candyImgNumber"))
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct WidgetEntryView: View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            Color(red: 0.094, green: 0, blue: 0.25)
                .ignoresSafeArea()
            Image("Pumpkin-\(entry.candyImgNumber)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(10)
                .frame(maxWidth: .infinity)
                .overlay(
                    Text("\(entry.candyCount)")
                        .bold()
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                        .offset(y: 7)
                )
        }
        
    }
}

@main
struct WidgetMain: Widget {
    private let kind = "Trick_or_Treat_Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
    }
}


struct Trick_or_Treat_Widget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEntryView(entry: CandyEntry(candyCount: 50, candyImgNumber: 3))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewDisplayName("Trick or Treat")
    }
}
