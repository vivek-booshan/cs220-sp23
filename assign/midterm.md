---
layout: mathjax
title: "Midterm Project"
---

<div class='admonition caution'>
<div class='title'>Caution</div>
<div class='content'>
<ul>
<li>You are expected to work in pairs.</li>
<li><strong>Due: Friday, March 17th at 11pm EST (Baltimore time).</strong></li>
<li><em>This assignment is worth 140 points.</em></li>
<li>Late submissions will <b>not</b> be accepted! Please plan accordingly</li>
</ul>
</div>
</div>

<div class='admonition success'>
<div class='title'>Objectives</div>
<div class='content'>
<ul>
<li>structs</li>
<li>binary file I/O</li>
<li>nested loops</li>
<li>data representations</li>
<li>dynamic memory allocation</li>
<li>makefile</li>
<li>development tools <code>gdb</code>, <code>valgrind</code>, <code>git</code></li>
<li>unit tests</li>
</ul>
</div>
</div>

# Overview

In this project, you will implement a program to perform operations
on a [15 Puzzle](https://en.wikipedia.org/wiki/15_puzzle), which is
a puzzle consisting of a square grid of tiles with one tile missing.
By sliding a tile into the "gap" left by the missing tile, the tiles
can be moved around. The goal is to rearrange the tiles so that each
one is in the correct position.

The program will read and carry out a series of commands. The commands
can be used to

* create a new puzzle
* set an initial configuration of tiles
* load a background image (to use when writing images that
  represent the state of the puzzle)
* slide tiles to manipulate the configuration of the puzzle
* check whether or not the puzzle has been solved
* compute a series of moves that will solve the puzzle
  (if a solution is possible)

# Getting Started

After you register your project team, or are assigned to a project team,
we will create a Github repository for your team to use. You should see
the repository listed when you visit <https://github.com/orgs/jhu-ip/repositories>
(assuming that you are logged into Github.) The repository will have
a name like `2023-spring-midterm-JHEDID1-JHEDID2` where `JHEDID1` and
`JHEDID2` are your and your partner's JHED IDs.

Clone your team repository with the commnad

```
git clone git@github.com:jhu-ip/2023-spring-midterm-JHEDID1-JHEDID2.git
```

replacing `JHEDID1` and `JHEDID2` as appropriate.

Next, run the command

```
git pull
```

in the course public repository to make sure it's up to date. Then, change
directory into your clone of your team repository, and run the commands

```
cp -r ~/cs220-sp23-public/project/midterm/* .
cp ~/cs220-sp23-public/project/midterm/.gitignore .
```

to copy the starter files to your team repository. Finally, use
`git add` and `git commit` to add an commit the starter code
(don't forget to add and commit the `.gitignore` file), and then
use `git push` to push the commit to the remote repository on Github.
Note that only one team member needs to add/commit/push the starter
files.

## Example of Program Functionality

<!--
TODO: brief example of program functionality (corresponding to one of
the test inputs in the starter code). Possible format could be:

* input file
* background image
* sequence of transformations on the puzzle (both tile locations
  and expected result image)
-->

This section shows a quick example of how the program works.

The example input shown here is in the file `test06.txt` included in
the starter files, so the following invocation could be used to run the
program with this input:

```
./puzzle test06.txt
```

The input file `test06.txt` has the following contents:

```
C 4
T 5 7 1 2 0 9 3 4 13 8 6 11 14 15 10 12
I ingo.ppm
W ingo_scrambled.ppm ingo_scrambled.txt
S l
S u
S l
S l
S r
S d
S r
S d
S l
S l
S u
S r
S u
S u
S r
S r
S d
S d
S d
S l
S l
S u
S r
S u
S l
S l
S u
W ingo_solved.ppm ingo_solved.txt
```

The meaning of each of these commands is fully described in the
[Input File Format](#input-file-format) section below. However, here is
a brief summary of what this input does:

1. Specifies that the puzzle is 4x4 (the `C` command)
2. Specifies a particular arrangement of tiles (the `T` command and
   the numbers that follow it)
3. Specifies that `ingo.ppm` is the background image for the puzzle
   (the `I` command)
4. Saves the initial (scrambled) configuration of the puzzle to image
   `ingo_scrambled.ppm` and text file `ingo_scrambled.txt` (the first `W` command)
5. Performs a series of moves (the `S` commands)
6. Saves the final solved configuration of the puzzle to the image
   `ingo_solved.ppm` and text file `ingo_solved.txt`
   (the second `W` command)

This is the background image (`ingo.ppm`):

<div class="puzzle_layout">
<a href="img/ingo.png"><img class="puzzle_img" src="img/ingo.png" alt="Picture of Ingo the cat"></a>
</div>

This is the initial scrambled puzzle configuration (the image is
`ingo_scrambled.ppm`):

<div class="puzzle_layout">
<table class="puzzle">
 <tr>
  <td>5</td><td>7</td><td>1</td><td>2</td>
 </tr>
 <tr>
  <td class="gap"></td><td>9</td><td>3</td><td>4</td>
 </tr>
 <tr>
  <td>13</td><td>8</td><td>6</td><td>11</td>
 </tr>
 <tr>
  <td>14</td><td>15</td><td>10</td><td>12</td>
 </tr>
</table>
<a href="img/ingo_scrambled.png"><img style="margin-left: 2em;" class="puzzle_img"  src="img/ingo_scrambled.png" alt="Scrambled puzzle image"></a>
</div>

After all of the "S" commands complete, the puzzle is in its
"solved" configuration (the image is `ingo_solved.ppm`):

<div class="puzzle_layout">
<table class="puzzle">
 <tr>
  <td>1</td><td>2</td><td>3</td><td>4</td>
 </tr>
 <tr>
  <td>5</td><td>6</td><td>7</td><td>8</td>
 </tr>
 <tr>
  <td>9</td><td>10</td><td>11</td><td>12</td>
 </tr>
 <tr>
  <td>13</td><td>14</td><td>15</td><td class="gap">12</td>
 </tr>
</table>
<a href="img/ingo_solved.png"><img style="margin-left: 2em;" class="puzzle_img"  src="img/ingo_solved.png" alt="Solved puzzle image"></a>
</div>

# Program Requirements

## Program Structure, Data Types

<!--
TODO: describe how source/header files are organized (data types
and function prototypes go in `puzzle.h`, helper functions go
in `puzzle_funcs.c`, main function goes in `puzzle.c`)
-->
The header file `puzzle.h` should have all of the common struct data types
and function declarations for the overall program.

<!--
TODO: it's a requirement to have a data type to represent the
instance of the puzzle (i.e., `typedef struct { /*...*/ } Puzzle;`
-->

The header file should define a struct data type called `Puzzle`.
An instance of this data type represents the current configuration
of the puzzle (it's size and the arrangements of the tiles.)
This data type can be defined something like this:

```c
typedef struct {
  // ...fields go here...
} Puzzle;
```

Puzzles will always be square, meaning that the number of rows
and columns will always be the same.  Each tile can be represented
by an integer value in the range $$1..N^{2}$$ (inclusive), where
$$N$$ is the number of rows/columns.  The value $$0$$ represents
the "gap" (missing tile).  A valid initialized puzzle should always
have exactly one gap tile. By convention, puzzles will omit
the tile numbered $$N^{2}$$, meaning that in a solved puzzle, the
gap will be in the lower right. However, your program should not
hard-code this assumption.

<!--
TODO: it's a requirement to have appropriate helper functions
to do operations on an instance of the puzzle data type
(could list a few suggestions, e.g., `puzzle_create`,
`puzzle_set_tile`, etc.)
-->

Your program is required to use functions to modularize the
overall functionality of the program. In particular, your program
should have a set of functions for creating, performing operations
on, and destroying instances of the `Puzzle` data type.
There are no specific requirements for which functions you implement
or how they work. However, here are a few suggestions which
you may use (or choose not to use):

```c
Puzzle *puzzle_create(int size);
void puzzle_destroy(Puzzle *p);
void puzzle_set_tile(Puzzle *p, int col, int row, int value);
int puzzle_get_tile(const Puzzle *p, int col, int row);
```

<!--
TODO: we expect that the program will use functions throughout the
program to simplify its implementation. For example, have one
function to implement each kind of supported command
(see the [Input File Format](#input-file-format) section)
-->

We also expect you to use functions to modularize the implementation
of the variuos commands suppored in the [Input File Format](#input-file-format).
For example (again, you may use these or choose not to):

```c
int handle_C_command(FILE *in, Puzzle **p);
int handle_T_command(FILE *in, Puzzle *p);
```

The source file `puzzle_funcs.c` should contain the definitions of
the functions defined in `puzzle.h`.  The source file `puzzle.c` should
define the program's `main` function.

Your program will use the [PPM image format](https://en.wikipedia.org/wiki/Netpbm).
The starter code provides you with files `ppm_io.h` and `ppm_io.c`.
The `ppm_io.h` header file defines a struct type named `Image` which
represents an image. Functions `ReadImage` and `WriteImage` support
reading and writing PPM image data, respectively.
(See the [Reading and Writing PPM Files](#reading-and-writing-ppm-files)
section for more information.)

## Input File Format

The input to the program (either read from a named file or read from
`stdin`) is a series of commands.  Each command consists of a capital
letter. Some specific commands also require argument values which follow
the command letter.

<!--
  // C <size>                         create puzzle of specified size
  // T <sequence of tile numbers...>  set initial state of puzzle
  // I <filename>                     set the base image filename
  // P                                print the current state of the puzzle (tile numbers)
  // W <img filename> <cfg filename>  write image file representing current state of puzzle
  // S <dir>                          slide free tile in given direction (u, d, l, or r)
  // K                                check to see whether the puzzle is in the "winning" configuration
  // Q                                quit the program
-->

Here is a list of commands and their arguments:

Command | Description
------- | -----------
<code class='highlighter-rouge'>C <i>size</i></code> | Create initial puzzle with <i>size</i> rows and columns
<code class='highlighter-rouge'>T <i>tile...</i></code> | Initialize puzzle configuration with series of tile numbers
<code class='highlighter-rouge'>I <i>filename</i></code> | Load the background image from specified PPM file
<code class='highlighter-rouge'>P</code> | Print sequence of tile numbers reflecting current puzzle configuration
<code class='highlighter-rouge'>W <i>filename1</i> <i>filename</i></code> | Write puzzle image to <i>filename1</i> and puzzle configuration to <i>filename2</i>
<code class='highlighter-rouge'>S <i>direction</i></code> | Slide a free tile in specified direction
<code class='highlighter-rouge'>K</code> | Check to see whether the puzzle is in the "winning" configuration
<code class='highlighter-rouge'>V</code> | Compute a series of moves to solve the puzzle
<code class='highlighter-rouge'>Q</code> | Quit the program

The `C` command creates the initial instance of the puzzle. The <i>size</i>
argument must be an integer in the range 2 to 20, inclusive, which specifies
the number of rows and columns. Each position in the puzzle must
be initialized with the value of the "gap". This means that the
puzzle is not "valid" until it has been explicitly initialized
with the `T` command.

The `T` command initializes the puzzle by assigning either a tile number
or the gap to each position. The <i>tile...</i> argument is a sequence
of integers in the range $$0 \ldots N^{2}$$ (inclusive) where $$N$$ is the
number of rows/columns with the value $$0$$ representing the gap. The numbers
specify the puzzle configuration in row major order. The `T` command
must be specified *after* the `C` command creating the puzzle.

The `I` command reads a PPM file from the specified filename. This iamge
will be used as the "background" image, and is the basis for the rendering
of the current puzzle configuration as an image performed by the
`W` command.

The `P` command prints the current puzzle configuration to `stdout` as a
sequnence of integer values. The format is exactly the same as the
<i>tile...</i> sequence specified in the `T` command, but should reflect
the current puzzle configuration based on any `S` commands that have
been executed to update the configuration of the puzzle.
The output should be printed as a single line of text ending with
a newline (`\n`) character.

The `W` command writes two output files, their names being specified
by the <i>filename1</i> and <i>filename2</i> arguments. The first
filename is the name of a PPM image file to be created as a rendering
of the current puzzle configuration. The gap should be rendered as
consisting of exclusively black pixels (with the red, green, and blue
color components being set to 0.) The other tiles should be copied from
the appropriate rectangular region of the background image loaded previously
with the `I` command. The background image is expected to have width
and height which are both exact multiples of the number of rows/columns
in the puzzle. The second filename is the name of a text file to
write with the current puzzle configuration, in exactly the same format as
the output written to `stdout` by the `P` command.

The `S` command slides the "free" tile in the direction specified by the
*dir* argument, which is one of the characters `u` (up), `d` (down), `l` (left),
or `r` (right). The "free" tile to be moved is the one adjacent to the single
gap position.

The `K` command checks to see whether the current puzzle configuration
is the "solved" configuration. A puzzle is considered solved if every
non-gap tile is in its expected position. For example, tile 1 should
be in the upper-left position, tile 2 should be immediate to its right,
etc. Based on whether or not the puzzle is solved, the program
should print either the output "`Solved`" or "`Not solved`" as
a single line of text ending with a newline (`\n`) character.

The `V` command computes a series of moves which solve the puzzle,
if the puzzle can be solved. *TODO: more description here*

The `Q` command quits the program. The program should exit with an
exit code of 0 when the `Q` command is executed.

TODO: more commands

For the `I` and `W` commands, you can assume that a filename will not consist of more
than 255 characters.

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
