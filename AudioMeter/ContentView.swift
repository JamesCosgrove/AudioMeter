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
	var body: some View {
		VStack {
			HStack {
				AudioView(level: $levelOne, cells: cells, labelLeading: true)
				AudioView(level: $levelTwo, cells: cells, labelLeading: false)
			}
			HStack {
				Slider(value: $levelOne, in: 0...1, step: 0.1)
				Slider(value: $levelTwo, in: 0...1, step: 0.1)
			}.padding()
		}
	}
}

struct AudioView: View {
	@Binding var level: Double
	@State var cells: Int
	@State var labelLeading: Bool
    var body: some View {
		VStack {
			ForEach(1...cells, id: \.self) { cell in
				HStack {
					if self.labelLeading {
						LabelView(cells: self.cells, cell: cell)
					}
					CellView(level: self.$level, cell: cell, cells: self.cells)
					if !self.labelLeading {
						LabelView(cells: self.cells, cell: cell)
					}
				}
			}
		}
	}
}

struct LabelView: View {
	@State var cells: Int
	@State var cell: Int
	var body: some View {
		Text("\((self.cells + 1) - cell)")
			.frame(width: 30)
			.font(.system(.headline, design: .monospaced))
	}
}

struct CellView: View {
	@Binding var level: Double
	@State var cell: Int
	@State var cells: Int
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 8)
				.foregroundColor(.black)
			RoundedRectangle(cornerRadius: 8)
				.foregroundColor(Double(cell) <= 0.2 * Double(cells) ? .red : (Double(cell) <= 0.4 * Double(cells) ? .yellow : .green))
				.opacity(Double(cell) <= Double(cells) - level * Double(cells) ? 0.32 : 1)
		}.frame(width: 100, height: 30, alignment: .center)
			.animation(cell == 1 ? Animation.easeIn(duration: Double(cells + 1 - cell) == level * Double(cells) ? 0 : 0.5).delay(Double(cells + 1 - cell) == level * Double(cells) ? 0 : 1) : .none)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
    }
}
