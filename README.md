# Don't Break the Chain!

[Don't Break the Chain!](https://github.com/elloo/terminal_app/commits/master "GitHub repository") is a Ruby terminal application for tracking daily progress of [#100DaysOfCode](https://www.100daysofcode.com/).

## Functionality

## Instructions for Use

### Gems used

[TTY::Prompt](https://github.com/piotrmurach/tty-prompt "TTY::Prompt GitHub")
[TTY::Box](https://github.com/piotrmurach/tty-box "TTY::Box GitHub")

## Screenshots

## Brainstorming and Workflow
[Brainstoming notes](../docs/Brainstorm.pdf)

## Initial Design Specifications

### User Stories

- As Ewe Lin, I want to mark down the days I stick to a habit so that I can track my progress in #100DaysofCode
- As Ewe Lin, I want to be able to delete past entries so that I can make mistakes
- As Shun, I want to be able to change / update entries for previous days so that I don't have to worry about missing a day.
- As Shun, I want to be able to view all entries so that I can gain an overview of my past behaviour

## Project Plan & Timeline

### Higher Level Structure

### Trello Screenshots

## Technical Difficulties
1. Writing and reading the file

   One of the first difficulties encountered was learning to write and read from a file properly. From a suggestion for a previous class exercise, it was thought that YAML would be sufficient. However, this was corrected and a normal .txt file was used instead. This made things much more straightforward as YAML uses special structures for it's format whereas .txt files retain the familiar Ruby syntax.

   In order to add or delete a single, selected character within the 2D array that represented the grid, the file always had to be read directly before making a change to it.

   Another problem that occured with writing the file was that it would append to the file when trying to reset, even though it was in write mode. This was due to the use of `<<` within the `reset` method. It was easily fixed by assigning an empty array at the start of the method. 

## Future Improvements

## Discussion

### Legal, moral, ethical, cultural and safety issues

### Social, political, cultural, racial, gender and international issues
