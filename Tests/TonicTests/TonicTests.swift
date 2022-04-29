import XCTest
@testable import Tonic

final class TonicTests: XCTestCase {
    func testNoteSpelling() {
        let c = Note(noteNumber: 60)
        XCTAssertEqual(c.spelling, "C")
        XCTAssertEqual(c.letter, .C)

        let dFlat = Note(noteNumber: 61, accidental: .flat)
        XCTAssertEqual(dFlat.spelling, "D♭")
        XCTAssertEqual(dFlat.letter, .D)

        let cSharp = Note(noteNumber: 61, accidental: .sharp)
        XCTAssertEqual(cSharp.spelling, "C♯")

        let dDoubleFlat = Note(noteNumber: 60, accidental: .doubleFlat)
        XCTAssertEqual(dDoubleFlat.spelling, "D𝄫")

        let cDoubleSharp = Note(noteNumber: 62, accidental: .doubleSharp)
        XCTAssertEqual(cDoubleSharp.spelling, "C𝄪")
    }

    func testNoteShift() {
        let d = Note(noteNumber: 60).shift(.M2)
        XCTAssertEqual(d.spelling, "D")

        let eFlat = Note(noteNumber: 60).shift(.m3)
        XCTAssertEqual(eFlat.spelling, "E♭")

    }

    func testScales() {
        print("blues intervals \(Scale.blues.intervals)")
        print("pentatonic intervals \(Scale.pentatonicMinor.intervals)")
        print("major scale intervales \(Scale.major.intervals)")
        print("minor scale intervals \(Scale.minor.intervals)")
        print("chromatic scale intervals \(Scale.chromatic.intervals)")

        XCTAssertTrue(Scale.pentatonicMinor.isSubset(of: Scale.blues))
        XCTAssertTrue(Scale.pentatonicMinor.isSubset(of: Scale.minor))
        XCTAssertFalse(Scale.blues.isSubset(of: Scale.minor))
        XCTAssertTrue(Scale.minor.isSubset(of: Scale.chromatic))
        XCTAssertEqual(Scale.chromatic.intervals, Interval.allCases)
    }

    func testChords() {
        var chord = Chord()
        chord.add(note: Note(noteNumber: 60))
        chord.add(note: Note(noteNumber: 64))
        chord.add(note: Note(noteNumber: 67))
        XCTAssertTrue(chord.isTriad)
    }

    func testGenerateTriads() {
        let chords = generateTriads()
        print(chords.map({$0.notes.map({$0.spelling})}))
        XCTAssert(chords.allSatisfy({ $0.isTriad }))
    }

    func testChordHausdorff() {
        var C = Chord()
        C.add(note: Note(noteNumber: 60))
        C.add(note: Note(noteNumber: 64))
        C.add(note: Note(noteNumber: 67))

        XCTAssertEqual(C.hausdorff(to: C), 0)

        var Cm = Chord()
        Cm.add(note: Note(noteNumber: 60))
        Cm.add(note: Note(noteNumber: 63))
        Cm.add(note: Note(noteNumber: 67))

        XCTAssertEqual(C.hausdorff(to: Cm), 1)
    }
}
