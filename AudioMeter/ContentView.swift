//
//  ContentView.swift
//  AudioMeter
//
//  Created by James Cosgrove on 22/04/2020.
//  Copyright © 2020 James Cosgrove. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State var level = 6.0
	var colors: [Color] = [.green, .green, .green, .green, .green, .green, .yellow, .yellow, .red, .red]
    var body: some View {
		VStack {
			ForEach(0..<10, id: \.self) { cell in
				HStack {
					Text("\(10 - cell)")
						.frame(width: 30)
						.font(.system(.body, design: .monospaced))
					ZStack {
						RoundedRectangle(cornerRadius: 10)
							.frame(width: 100, height: 30, alignment: .center)
							.foregroundColor(.black)
						RoundedRectangle(cornerRadius: 10)
							.frame(width: 100, height: 30, alignment: .center)
							.opacity(10.0 - Double(cell) <= self.level ? 1 : 0.4)
							.foregroundColor(self.colors[9 - cell])
					}
				}
			}
			Slider(value: $level, in: 1...10, step: 1)
			.padding()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
