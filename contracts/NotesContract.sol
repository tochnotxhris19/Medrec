// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract NotesContract {
    uint256 public noteCount = 0;

    struct Note {
        uint256 id;
        string fee;
        string location;
        string notes;
        string vitals;
        string medicines;
        string advice;
    }

    mapping(uint256 => Note) public notes;

    event NoteCreated(
        uint256 id,
        string fee,
        string location,
        string notes,
        string vitals,
        string medicines,
        string advice
    );
    event NoteDeleted(uint256 id);

    function createNote(
        string memory _fee,
        string memory _location,
        string memory _notes,
        string memory _vitals,
        string memory _medicines,
        string memory _advice
    ) public {
        notes[noteCount] = Note(
            noteCount,
            _fee,
            _location,
            _notes,
            _vitals,
            _medicines,
            _advice
        );
        emit NoteCreated(
            noteCount,
            _fee,
            _location,
            _notes,
            _vitals,
            _medicines,
            _advice
        );
        noteCount++;
    }

    function deleteNote(uint256 _id) public {
        delete notes[_id];
        emit NoteDeleted(_id);
        noteCount--;
    }
}
