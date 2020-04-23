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
				AudioView(level: $levelOne, cells: cells, labelsLeading: true)
				AudioView(level: $levelTwo, cells: cells, labelsLeading: false)
			}
			HStack {
				Slider(value: $levelOne, in: 0...Double(cells), step: 1)
				Slider(value: $levelTwo, in: 0...Double(cells), step: 1)
					
			}.padding()
		}
	}
}

struct AudioView: View {
	@Binding var level: Double
	@State var cells: Int
	@State var labelsLeading: Bool
    var body: some View {
		VStack {
			HStack {
				VStack {
					ForEach(1...cells, id: \.self) { cell in
						HStack {
							if self.labelsLeading {
								Text("\((self.cells + 1) - cell)")
									.frame(width: 30)
									.font(.system(.headline, design: .monospaced))
							}
							CellView(level: self.$level, cell: cell, cells: self.cells)
							if !self.labelsLeading {
								Text("\((self.cells + 1) - cell)")
									.frame(width: 30)
									.font(.system(.headline, design: .monospaced))
							}
						}
					}
				}
			}
		}
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
				.opacity(Double(cell) <= Double(cells) - level ? 0.32 : 1)
		}.frame(width: 100, height: 30, alignment: .center)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
    }
}
