//
//  AccordinView.swift
//  MethodistMobile
//
//  Created by Q002 on 11/02/2024.
//

import SwiftUI

struct AccordinView: View {
    var body: some View {
        AccordionViewTest()
    }
}

struct AccordinView_Previews: PreviewProvider {
    static var previews: some View {
        AccordinView()
    }
}

struct AccordionView<Label, Content>: View
where Label : View, Content : View {
  @Binding var expandedIndex: Int?
  let sectionCount: Int
  @ViewBuilder let label: (Int) -> Label
  @ViewBuilder let content: (Int) -> Content

  var body: some View {
    VStack {
      ForEach(0..<sectionCount, id: \.self) { index in
        DisclosureGroup(isExpanded: .init(get: {
          expandedIndex == index
        }, set: { value in
          expandedIndex = value ? index : nil
        }), content: {
          content(index)
        }, label: {
          label(index)
        })
      }
    }
  }
}



struct AccordionViewTest: View {
  @State private var expandedIndex: Int? = nil
  private let sections = [
    SymbolGroup(title: "Weather",
                symbols: [
                  "sun.min", "sun.min.fill", "sun.max", "sunrise", "moon", "cloud.fog.fill", "cloud.hail"
                ]),
    SymbolGroup(title: "Devices",
                symbols: [
                  "keyboard", "airtag", "display", "pc", "macpro.gen2", "macmini", "flipphone"
                ]),
    SymbolGroup(title: "Transport",
                symbols: [
                  "airplane", "airplane.circle", "car.2", "tram.fill", "car.ferry", "bicycle", "sailboat.fill"
                ]),
    SymbolGroup(title: "Fitness",
                symbols: [
                  "figure.walk", "figure.boxing", "figure.golf", "figure.roll", "figure.outdoor.cycle", "dumbbell", "baseball.fill"
                ]),
    SymbolGroup(title: "Time",
                symbols: [
                  "clock", "clock.fill", "alarm", "deskclock", "timer.circle", "timer.square", "hourglass"
                ]),
  ]

  var body: some View {
    VStack {
      Text("Expanded index: \((expandedIndex == nil) ? "none" : "\(expandedIndex!)")")
      AccordionView(expandedIndex: $expandedIndex,
                    sectionCount: sections.count,
                    label: { index in
        Text(sections[index].title)
      },
                    content: { index in
        HStack {
          ForEach(sections[index].symbols, id: \.self) { symbol in
            Image(systemName: symbol)
              .frame(width: 32, height: 32)
          }
        }
      })
      Spacer()
    }
    .padding()
  }

  struct SymbolGroup {
    let title: String
    let symbols: [String]
  }
}
