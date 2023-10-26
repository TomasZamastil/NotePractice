//
//  ContentView.swift
//  Notytoty
//
//  Created by Kristen Yose on 4/6/23.
//

import SwiftUI
import CoreGraphics
import AVKit

class SoundManager {
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    func playSound(note: String) {
        
        guard let url = Bundle.main.url(forResource: note, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}

let restartButtonsTapped = Array(repeating: false, count: 21)

func clefDeterminant(noteNumber: Int, decider: Int) -> Int {
    if (noteNumber >= 30) {
        return 0
    } else if (noteNumber < 21) {
        return 1
    } else {
        return decider
    }
}

let notesWithAccidentals:[Int] = [2, 4, 7, 9, 11, 14, 16, 19, 21, 23, 26, 28, 31, 33, 35, 38, 40, 43, 45, 47]

//Returns True if the first supporting line above the original 5 is needed
func firstUpperLine(accidental: Int, note: Int, decider: Int) -> Bool {
    let clef = clefDeterminant(noteNumber: note, decider: decider)
    return (clef == 0 && (note >= 46 || (accidental == 0 && note == 45))) || (clef == 1 && note >= 25)
}

//Returns True if the second supporting line above the original 5 is needed
func secondUpperLine(accidental: Int, note: Int, decider: Int) -> Bool {
    let clef = clefDeterminant(noteNumber: note, decider: decider)
    return (clef == 0 && note == 49) || (clef == 1 && (note >= 29 || (accidental == 0 && note == 28)))
}

//Returns True if the first supporting line below the original 5 is needed
func firstLowerLine(accidental: Int, note: Int, decider: Int) -> Bool {
    let clef = clefDeterminant(noteNumber: note, decider: decider)
    return (clef == 0 && (note <= 25 || (accidental == 1 && note == 26))) || (clef == 1 && note <= 5)
}

//Returns True if the second supporting line below the original 5 is needed
func secondLowerLine(accidental: Int, note: Int, decider: Int) -> Bool {
    let clef = clefDeterminant(noteNumber: note, decider: decider)
    return (clef == 0 && (note <= 22 || (accidental == 1 && note == 23))) || (clef == 1 && (note == 1 || (accidental == 1 && note == 2)))
}

func paddingDeterminator(accidental: Int, note: Int, decider: Int) -> Bool {
    let clef = clefDeterminant(noteNumber: note, decider: decider)
    return (clef == 0 && note <= 30) || (clef == 1 && note <= 10)
}

//Decides the stem direction of the note based on how high/low the note is positioned
func stemDirection(accidental: Int, note: Int, decider: Int) -> Bool {
    let clef = clefDeterminant(noteNumber: note, decider: decider)
    return (clef == 1 && (note >= 15 || (accidental == 0 && note == 14))) || (clef == 0 && (note >= 36 || (accidental == 0 && note == 35)))
}

//Decides the position of a note based on the note (C2 - C6), the accidental (is it sharp # or flat b) and the clef
func notePosition(accidental: Int, note: Int, decider: Int) -> CGFloat  {
    let clef = clefDeterminant(noteNumber: note, decider: decider)
    switch note {
    case 1:
        return -5
    case 2:
        return accidental == 0 ? -4 : -5
    case 3:
        return -4
    case 4:
        return accidental == 0 ? -3 : -4
    case 5:
        return -3
    case 6:
        return -2
    case 7:
        return accidental == 0 ? -1 : -2
    case 8:
        return -1
    case 9:
        return accidental == 0 ? 0 : -1
    case 10:
        return 0
    case 11:
        return accidental == 0 ? 1 : 0
    case 12:
        return 1
    case 13:
        return 2
    case 14:
        return accidental == 0 ? 3 : 2
    case 15:
        return 3
    case 16:
        return accidental == 0 ? 4 : 3
    case 17:
        return 4
    case 18:
        return 5
    case 19:
        return accidental == 0 ? 6 : 5
    case 20:
        return 6
    case 21:
        if (clef == 0) {
            return accidental == 0 ? -5 : -6
        } else {
            return accidental == 0 ? 7 : 6
        }
    case 22:
        if (clef == 0) {
            return -5
        } else {
            return 7
        }
    case 23:
        if (clef == 0) {
            return accidental == 0 ? -4 : -5
        } else {
            return accidental == 0 ? 8 : 7
        }
    case 24:
        if (clef == 0) {
            return -4
        } else {
            return 8
        }
    case 25:
        if (clef == 0) {
            return -3
        } else {
            return 9
        }
    case 26:
        if (clef == 0) {
            return accidental == 0 ? -2 : -3
        } else {
            return accidental == 0 ? 10 : 9
        }
    case 27:
        if (clef == 0) {
            return -2
        } else {
            return 10
        }
    case 28:
        if (clef == 0) {
            return accidental == 0 ? -1 : -2
        } else {
            return accidental == 0 ? 11 : 10
        }
    case 29:
        if (clef == 0) {
            return -1
        } else {
            return 11
        }
    case 30:
        return 0
    case 31:
        return accidental == 0 ? 1 : 0
    case 32:
        return 1
    case 33:
        return accidental == 0 ? 2 : 1
    case 34:
        return 2
    case 35:
        return accidental == 0 ? 3 : 2
    case 36:
        return 3
    case 37:
        return 4
    case 38:
        return accidental == 0 ? 5 : 4
    case 39:
        return 5
    case 40:
        return accidental == 0 ? 6 : 5
    case 41:
        return 6
    case 42:
        return 7
    case 43:
        return accidental == 0 ? 8 : 7
    case 44:
        return 8
    case 45:
        return accidental == 0 ? 9 : 8
    case 46:
        return 9
    case 47:
        return accidental == 0 ? 10 : 9
    case 48:
        return 10
    case 49:
        return 11
    default:
        break
        
    }
    return -10
}

struct NoteLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        
        return path
    }
}
struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var score = 0
    @State var tapInProcess = false
    @State var buttonsTapped:[Bool] = restartButtonsTapped
    @State var chosenNote = Int.random(in:1..<50)
    @State var conflictingClefDecision = Int.random(in:0..<2)
    @State var sharpOrFlat = Int.random(in:0..<2)
    var body: some View {
        VStack {
            Text("Score: \(score)")
            Spacer()
            ZStack {
                NoteLine()
                    .stroke(style:(StrokeStyle(lineWidth: (firstUpperLine(accidental: sharpOrFlat, note: chosenNote, decider: conflictingClefDecision)) ? 1 : 0)))
                    .frame(maxWidth: 30, maxHeight:6)
                    .padding(.trailing, 8)
                    .padding(.bottom, 85)
                NoteLine()
                    .stroke(style:(StrokeStyle(lineWidth: (secondUpperLine(accidental: sharpOrFlat, note: chosenNote, decider: conflictingClefDecision)) ? 1 : 0)))
                    .frame(maxWidth: 30, maxHeight:6)
                    .padding(.trailing, 8)
                    .padding(.bottom, 115)
                NoteLine()
                    .stroke(style:(StrokeStyle(lineWidth: (firstLowerLine(accidental: sharpOrFlat, note: chosenNote, decider: conflictingClefDecision)) ? 1 : 0)))
                    .frame(maxWidth: 30, maxHeight:6)
                    .padding(.trailing, 8)
                    .padding(.top, 85)
                NoteLine()
                    .stroke(style:(StrokeStyle(lineWidth: (secondLowerLine(accidental: sharpOrFlat, note: chosenNote, decider: conflictingClefDecision)) ? 1 : 0)))
                    .frame(maxWidth: 30, maxHeight:6)
                    .padding(.trailing, 8)
                    .padding(.top, 115)
                Text(notesWithAccidentals.contains(chosenNote) ? sharpOrFlat == 0 ? "\u{266D}" : "\u{266F}" : "")
                    .font(.system(size:50))
                    .padding(.top, paddingDeterminator(accidental: sharpOrFlat, note: chosenNote, decider: conflictingClefDecision) ? sharpOrFlat == 0 ? 42 - (14 * notePosition(accidental: sharpOrFlat, note: chosenNote, decider: conflictingClefDecision)) : 48 - (14 * notePosition(accidental: sharpOrFlat, note: chosenNote, decider: conflictingClefDecision)) : 0)
                    .padding(.bottom, paddingDeterminator(accidental: sharpOrFlat, note: chosenNote, decider: conflictingClefDecision) ? 0 : sharpOrFlat == 0 ? -42 + (14 * notePosition(accidental: sharpOrFlat, note: chosenNote, decider: conflictingClefDecision)) : -48 + (14 * notePosition(accidental: sharpOrFlat, note: chosenNote, decider: conflictingClefDecision)))
                    .padding(.trailing, 65)
                
                Text(stemDirection(accidental: sharpOrFlat, note: chosenNote, decider: conflictingClefDecision) ? "" : "\u{2669}")
                    .font(.system(size:65))
                    .padding(.bottom, -2.5 + (14.25 * notePosition(accidental: sharpOrFlat, note: chosenNote, decider: conflictingClefDecision)))
                Text(stemDirection(accidental: sharpOrFlat, note: chosenNote, decider: conflictingClefDecision) ? "\u{2669}" : "")
                    .rotationEffect(.degrees(-180))
                    .font(.system(size:65))
                    .padding(.bottom, -84 + (14.25 * notePosition(accidental: sharpOrFlat, note: chosenNote, decider: conflictingClefDecision)))
                    .padding(.trailing, 16)
                Text(clefDeterminant(noteNumber: chosenNote, decider: conflictingClefDecision) == 0 ? "\u{1D11E}" : "\u{1D122}")
                    .font(.system(size:(clefDeterminant(noteNumber: chosenNote, decider: conflictingClefDecision) == 0 ? 120 : 80)))
                    .padding(.leading, 2)
                    .padding(.bottom, 9)
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack {
                    NoteLine()
                        .stroke(style:(StrokeStyle(lineWidth: 1)))
                        .frame(maxWidth: .infinity, maxHeight:6)
                    NoteLine()
                        .stroke(style:(StrokeStyle(lineWidth: 1)))
                        .frame(maxWidth: .infinity, maxHeight:6)
                    NoteLine()
                        .stroke(style:(StrokeStyle(lineWidth: 1)))
                        .frame(maxWidth: .infinity, maxHeight:6)
                    NoteLine()
                        .stroke(style:(StrokeStyle(lineWidth: 1)))
                        .frame(maxWidth: .infinity, maxHeight:6)
                    NoteLine()
                        .stroke(style:(StrokeStyle(lineWidth: 1)))
                        .frame(maxWidth: .infinity, maxHeight:6)
                }
            }
            Spacer()
            Grid {
                GridRow {
                    Button(action: {
                        score -= 1
                        buttonsTapped[0] = true
                        if (!tapInProcess) && (chosenNote == 2 || chosenNote == 14 || chosenNote == 26 || chosenNote == 38) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                        
                    }) {
                        Text("C\u{266F}")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[0] && (chosenNote == 2 || chosenNote == 14 || chosenNote == 26 || chosenNote == 38)) ? Color.green : (buttonsTapped[0]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                    
                    Button(action: {
                        score -= 1
                        buttonsTapped[1] = true
                        if (!tapInProcess) && (chosenNote == 4 || chosenNote == 16 || chosenNote == 28 || chosenNote == 40) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("D\u{266F}")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[1] && (chosenNote == 4 || chosenNote == 16 || chosenNote == 28 || chosenNote == 40)) ? Color.green : (buttonsTapped[1]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                    
                    Button(action: {
                        score -= 1
                        buttonsTapped[2] = true
                        if (!tapInProcess) && (chosenNote == 6 || chosenNote == 18 || chosenNote == 30 || chosenNote == 42) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("E\u{266F}")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[2] && (chosenNote == 6 || chosenNote == 18 || chosenNote == 30 || chosenNote == 42)) ? Color.green : (buttonsTapped[2]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                    
                    Button(action: {
                        score -= 1
                        buttonsTapped[3] = true
                        if (!tapInProcess) && (chosenNote == 7 || chosenNote == 19 || chosenNote == 31 || chosenNote == 43) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("F\u{266F}")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[3] && (chosenNote == 7 || chosenNote == 19 || chosenNote == 31 || chosenNote == 43)) ? Color.green : (buttonsTapped[3]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                    
                    Button(action: {
                        score -= 1
                        buttonsTapped[4] = true
                        if (!tapInProcess) && (chosenNote == 9 || chosenNote == 21 || chosenNote == 33 || chosenNote == 45) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("G\u{266F}")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[4] && (chosenNote == 9 || chosenNote == 21 || chosenNote == 33 || chosenNote == 45)) ? Color.green : (buttonsTapped[4]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                    
                    Button(action: {
                        score -= 1
                        buttonsTapped[5] = true
                        if (!tapInProcess) && (chosenNote == 11 || chosenNote == 23 || chosenNote == 35 || chosenNote == 47) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("A\u{266F}")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[5] && (chosenNote == 11 || chosenNote == 23 || chosenNote == 35 || chosenNote == 47)) ? Color.green : (buttonsTapped[5]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                    
                    Button(action: {
                        score -= 1
                        buttonsTapped[6] = true
                        if (!tapInProcess) && (chosenNote == 1 || chosenNote == 13 || chosenNote == 25 || chosenNote == 37 || chosenNote == 49) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("B\u{266F}")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[6] && (chosenNote == 1 || chosenNote == 13 || chosenNote == 25 || chosenNote == 37 || chosenNote == 49)) ? Color.green : (buttonsTapped[6]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                }
                GridRow {
                    Button(action: {
                        score -= 1
                        buttonsTapped[7] = true
                        if (!tapInProcess) && (chosenNote == 1 || chosenNote == 13 || chosenNote == 25 || chosenNote == 37 || chosenNote == 49) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("C")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[7] && (chosenNote == 1 || chosenNote == 13 || chosenNote == 25 || chosenNote == 37 || chosenNote == 49)) ? Color.green : (buttonsTapped[7]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                    
                    Button(action: {
                        score -= 1
                        buttonsTapped[8] = true
                        if (!tapInProcess) && (chosenNote == 3 || chosenNote == 15 || chosenNote == 27 || chosenNote == 39) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("D")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[8] && (chosenNote == 3 || chosenNote == 15 || chosenNote == 27 || chosenNote == 39)) ? Color.green : (buttonsTapped[8]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                    
                    Button(action: {
                        score -= 1
                        buttonsTapped[9] = true
                        if (!tapInProcess) && (chosenNote == 5 || chosenNote == 17 || chosenNote == 29 || chosenNote == 41) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("E")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[9] && (chosenNote == 5 || chosenNote == 17 || chosenNote == 29 || chosenNote == 41)) ? Color.green : (buttonsTapped[9]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                    
                    Button(action: {
                        score -= 1
                        buttonsTapped[10] = true
                        if (!tapInProcess) && (chosenNote == 6 || chosenNote == 18 || chosenNote == 30 || chosenNote == 42) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("F")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[10] && (chosenNote == 6 || chosenNote == 18 || chosenNote == 30 || chosenNote == 42)) ? Color.green : (buttonsTapped[10]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                    
                    Button(action: {
                        score -= 1
                        buttonsTapped[11] = true
                        if (!tapInProcess) && (chosenNote == 8 || chosenNote == 20 || chosenNote == 32 || chosenNote == 44) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("G")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[11] && (chosenNote == 8 || chosenNote == 20 || chosenNote == 32 || chosenNote == 44)) ? Color.green : (buttonsTapped[11]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                    
                    Button(action: {
                        score -= 1
                        buttonsTapped[12] = true
                        if (!tapInProcess) && (chosenNote == 10 || chosenNote == 22 || chosenNote == 34 || chosenNote == 46) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("A")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[12] && (chosenNote == 10 || chosenNote == 22 || chosenNote == 34 || chosenNote == 46)) ? Color.green : (buttonsTapped[12]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                    
                    Button(action: {
                        score -= 1
                        buttonsTapped[13] = true
                        if (!tapInProcess) && (chosenNote == 12 || chosenNote == 24 || chosenNote == 36 || chosenNote == 48) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("B")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[13] && (chosenNote == 12 || chosenNote == 24 || chosenNote == 36 || chosenNote == 48)) ? Color.green : (buttonsTapped[13]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                }
                GridRow {
                    Button(action: {
                        score -= 1
                        buttonsTapped[14] = true
                        if (!tapInProcess) && (chosenNote == 12 || chosenNote == 24 || chosenNote == 36 || chosenNote == 48) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("C\u{266D}")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[14] && (chosenNote == 12 || chosenNote == 24 || chosenNote == 36 || chosenNote == 48)) ? Color.green : (buttonsTapped[14]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                    
                    Button(action: {
                        score -= 1
                        buttonsTapped[15] = true
                        if (!tapInProcess) && (chosenNote == 2 || chosenNote == 14 || chosenNote == 26 || chosenNote == 38) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("D\u{266D}")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[15] && (chosenNote == 2 || chosenNote == 14 || chosenNote == 26 || chosenNote == 38)) ? Color.green : (buttonsTapped[15]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                    
                    Button(action: {
                        score -= 1
                        buttonsTapped[16] = true
                        if (!tapInProcess) && (chosenNote == 4 || chosenNote == 16 || chosenNote == 28 || chosenNote == 40) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("E\u{266D}")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[16] && (chosenNote == 4 || chosenNote == 16 || chosenNote == 28 || chosenNote == 40)) ? Color.green : (buttonsTapped[16]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                    
                    Button(action: {
                        score -= 1
                        buttonsTapped[17] = true
                        if (!tapInProcess) && (chosenNote == 5 || chosenNote == 17 || chosenNote == 29 || chosenNote == 41) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("F\u{266D}")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[17] && (chosenNote == 5 || chosenNote == 17 || chosenNote == 29 || chosenNote == 41)) ? Color.green : (buttonsTapped[17]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                    
                    Button(action: {
                        score -= 1
                        buttonsTapped[18] = true
                        if (!tapInProcess) && (chosenNote == 7 || chosenNote == 19 || chosenNote == 31 || chosenNote == 43) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("G\u{266D}")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[18] && (chosenNote == 7 || chosenNote == 19 || chosenNote == 31 || chosenNote == 43)) ? Color.green : (buttonsTapped[18]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                    
                    Button(action: {
                        score -= 1
                        buttonsTapped[19] = true
                        if (!tapInProcess) && (chosenNote == 9 || chosenNote == 21 || chosenNote == 33 || chosenNote == 45) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("A\u{266D}")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[19] && (chosenNote == 9 || chosenNote == 21 || chosenNote == 33 || chosenNote == 45)) ? Color.green : (buttonsTapped[19]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                    
                    Button(action: {
                        score -= 1
                        buttonsTapped[20] = true
                        if (!tapInProcess) && (chosenNote == 11 || chosenNote == 23 || chosenNote == 35 || chosenNote == 47) {
                            SoundManager.instance.playSound(note:"\(chosenNote)")
                            score += 2
                            tapInProcess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                chosenNote = Int.random(in: 1..<50)
                                conflictingClefDecision = Int.random(in:0..<2)
                                sharpOrFlat = Int.random(in:0..<2)
                                buttonsTapped = restartButtonsTapped
                                tapInProcess = false
                            }
                        }
                    }) {
                        Text("B\u{266D}")
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color(red: 0.20, green: 0.20, blue: 0.20))
                            .font(.system(size: 36))
                            .frame(maxWidth: .infinity)
                            .padding([.bottom, .top], 5)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.5,
                                    style: .continuous
                                )
                                .fill((buttonsTapped[20] && (chosenNote == 11 || chosenNote == 23 || chosenNote == 35 || chosenNote == 47)) ? Color.green : (buttonsTapped[20]) ? Color.red : (colorScheme == .dark ? Color(red: 0.20, green: 0.20, blue: 0.20) : Color(red: 0.80, green: 0.80, blue: 0.80)))
                            )
                    }
                }
            }
            Spacer()
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
