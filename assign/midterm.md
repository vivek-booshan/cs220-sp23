---
layout: default
title: "Midterm Project"
---


<div class='admonition caution'>
<div class='title'>Caution</div>
<div class='content'>
<ul>
<li>You are expected to work in pairs.</li>
<li><strong>Due: Friday, March 17th at 11pm EST (Baltimore time).</strong></li>
<li><em>This assignment is worth 100 points.</em></li>
<li>Late submissions will <b>not</b> be accepted! Please plan accordingly</li>
</ul>
</div>
</div>

# Overview

TODO: What a 15 puzzle is.

TODO: Brief overview of what the program will do. (Note: the program needs to
be capable of manipulating arbitrary NxN puzzles.)

# Getting Started

TODO: Cloning your midterm project repository

TODO: Copying the starter code.

# Program Requirements

## Program Structure, Data Types

TODO: describe how source/header files are organized (data types
and function prototypes go in `puzzle.h`, helper functions go
in `puzzle_funcs.c`, main function goes in `puzzle.c`)

TODO: it's a requirement to have a data type to represent the
instance of the puzzle (i.e., `typedef struct { /*...*/ } Puzzle;`

TODO: it's a requirement to have appropriate helper functions
to do operations on an instance of the puzzle data type
(could list a few suggestions, e.g., `puzzle_create`,
`puzzle_set_tile`, etc.)

TODO: we expect that the program will use functions throughout the
program to simplify its implementation. For example, have one
function to implement each kind of supported command
(see the [Input File Format](#input-file-format) section)

## Input File Format

TODO: description of the input file format, with all of the commands

## Running the Program

TODO: invoking the program (0 args means read commands from stdin, 1 arg
means read commands from input file)

## Error Handling

TODO: the various kinds of errors that must be handled. Important
points:

* All error messages are printed to stderr
* All errors are "fatal" (cause the program to exit with exit code 1
  after printing the error message)
* Error message text is exact (we should give them a table based on
  the error messages from the reference solution)

## Reading and Writing PPM Files

TODO: brief description of PPM format (copy from image processing assignment?)

TODO: ways of viewing PPM files (remote X and feh program, view in VS Code)

TODO: brief description of how PPM files are used in the assignment,
in I command (read into memory) and W command (write an result image by
"carving up" the original image according to the current configuration of
the tiles in the puzzle)

## Memory Correctness

TODO: the program needs to be free of memory leaks and other memory errors
(such as out of bounds array accesses), should use valgrind when testing

# Testing

TODO: it's expected that there will be a test program (`puzzle_tests`)
which has unit tests for as many helper functions as possible. Basically,
any helper function that can be tested in a straightforward way
should have a test. Teams should expect to invest around the same amount
of effort in writing tests as in implementing the functions being tested.

## Packaging

TODO: the files submitted should include `puzzle.h`, `puzzle_funcs.c`,
`puzzle.c`, `puzzle_tests.c`, `Makefile`, `README`, and `gitlog.txt`.
Please do not include any PPM image files.

TODO: expectations for what targets the Makefile should have

TODO: describe what the README should contain

TODO: instructions for preparing a zipfile to upload to Gradescope
