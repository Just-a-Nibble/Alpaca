# Alpaca
*"Yeah, yeah, but your scientists were so preoccupied with whether or
not they could that they didn't stop to think if they should." - Jeff Goldblum,
Jurassic Park*

Like any sane person, I came up with this project to see how difficult
it actually is to implement a simple compiler in assembly. For future
reference, I believe it to be easier to implement a project in assembly
with some prior experience with assembly.

My hope is to eventually bootstrap, and then implement a compiler in
Alpaca (probably something like a B compiler).

## Structure

While most simple compilers follow the Lexer -> Parser -> Codegen
sequence, this compiler combines parsing and codegen by outputting
the result as it is parsing the input. For that reason, codegen
and parsing code will be found in parsers/XXX.S.

## Standard Library

The program is run by evoking 'main', and the return code is the
top-most value of the stack after the completion of 'main'. This
is handled by entry.S (which also contains the stack allocation).

The following are descriptions for the files in llama (the stdlib):
 * entry.S - On program execution, evoke 'main' and return top-most
   value on the stack
 * arithmetic.S - Signed/unsigned integer arithmetic
 * comparison.S - Equals/Not Equals/Less/Greater/etc functions
 * intrinsics.S - Forth-like intrinsics
 * io.S - File/stdio manipulation (in progress)
 * pointers.S - Pointer-based load/store
 * strings.S - What do you think?

## Examples

For syntax and examples, see ```examples/**```

## Building/Usage

Currently, the compiler uses/requires POSIX syscalls (sorry Windows
peeps), evoking looks like the following:

### Building the Compiler + Standard Library

```sh
make
```

Check to make sure that the ```compiler``` executable is present,
and that ```llama/std.o``` has compiler successfully.

### Generating Object File (using examples/hello_world.alpaca):

```sh
cat examples/hello_world.alpaca | ./compiler | as -o output.o
```

### Linking with standard library

```sh
ld output.o llama/std.o -o output
rm output.o # Don't need this anymore
```

And done, just run ```output```.

## TODO
 * Store strings in read-only segment (can't do .text because
   I don't like the possibility of jumping to a string, and because
   strings are defined in-line; see parsers/string_literal.S).
 * Defined macros for making codegen better
 * Be able to store data in .bss segment
 * Expand io.S and string.S
 * Bootstrap (shouldn't be too difficult)
 * See if we can directly output an object file (instead of needing
   the GNU assembler, which is more complex than Alpaca itself).
