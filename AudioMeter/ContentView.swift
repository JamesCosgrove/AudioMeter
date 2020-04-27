//
//  ContentView.swift
//  AudioMeter
//
//  Created by James Cosgrove on 22/04/2020.
//  Copyright © 2020 James Cosgrove. All rights reserved.
//

import SwiftUI




struct ContentView: View {
	@State var levelOne: Double = 5.0
	@State var levelTwo: Double = 5.0
	@State var cells: Int = 10
	var colors: [Color] = [.red, .yellow, .green]
	var body: some View {
		VStack {
			
			HStack {
				AudioView(level: levelOne, cells: cells, colors: colors)
					.frame(minWidth: 0, idealWidth: 100, maxWidth: 150, minHeight: 0, idealHeight: CGFloat(32 * cells), maxHeight: CGFloat(34 * cells), alignment: .center)

			}
			HStack {
				Slider(value: $levelOne, in: 0...1, step: 0.1)
					.frame(width: 150)
			}.padding()
		}
	}
}

struct AudioView: View {
	let level: Double
	let cells: Int
	let labelLeading: Bool = true
	let colors: [Color]
    var body: some View {
		VStack(alignment: self.labelLeading ? .trailing : .leading) {
			ForEach(1...cells, id: \.self) { cell in
				HStack {
					if self.labelLeading {
						LabelView(cells: self.cells, cell: cell)
					}
					CellView(level: self.level, cell: cell, cells: self.cells, colors: self.colors)
					if !self.labelLeading {
						LabelView(cells: self.cells, cell: cell)
					}
				}
			}
		}
	}
}

struct LabelView: View {
	let cells: Int
	let cell: Int
	var body: some View {
		Text("\((self.cells + 1) - cell)")
			.font(.system(.headline, design: .monospaced))
			.frame(width: 30, height: 17, alignment: .trailing)

	}
}

struct CellView: View {
	let level: Double
	let cell: Int
	let cells: Int
	let colors: [Color]
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 5)
				.foregroundColor(.black)
			RoundedRectangle(cornerRadius: 5)
				.foregroundColor(Double(cell) <= 0.2 * Double(cells) ? colors[0] : (Double(cell) <= 0.4 * Double(cells) ? colors[1] : colors[2]))
				.opacity(Double(cell) <= Double(cells) - level * Double(cells) ? 0.32 : 1)
		}//.frame(maxWidth: 100, maxHeight: 30, alignment: .center)
			.animation(cell == 1 ? Animation.easeIn(duration: Double(cells + 1 - cell) == level * Double(cells) ? 0 : 0.2).delay(Double(cells + 1 - cell) == level * Double(cells) ? 0 : 0.5) : .none)
		
	}
	

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
    }
}
