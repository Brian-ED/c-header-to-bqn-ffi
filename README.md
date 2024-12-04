# C-headers to BQN FFI
parse.bqn is the main file, used on a header file to autogenerate bqn ffi code.

For how to use, you can look in examples. You may look at comments in parse.bqn for how each function works.

For documentation on FFI in BQN, look in https://mlochbaum.github.io/BQN/spec/system.html#foreign-function-interface

# Output ffi file
The outputted bqn code has some special code alongside your ffi functions.
First, it automatically terminates null-terminating strings (type "*i8:c8") with null. This is to make using c-strings more seamless and less error prone. The outputted ffi file also has error handling, and allows giving 𝕨 to the MakeImporter function, and if 𝕨 is 1 then it prints every use of an ffi function. Like super print debugging.

The functions may have some duplicates, with names ending with Ref or Raw. When a function name ends with Ref, and assuming no name collisions happened, the mutable pointers of the function are instead using &ptr in the decloration. In basic terms, you can give a bqn array instead of a pointer and the mutated result gets given instead of mutating input. There are plenty of reasons to use either version so both are left in the output. The Raw postfix means that a pointer's type was const, so type "*i8" can be used instead of a pointer, and you may want either option so both are left in.

# Header file parsing
The parser scans input to get API information about defines, structs, aliases, enums, callbacks and functions.
All data is divided into pieces, usually as strings.

## CONSTRAINTS:
Functions are expected as a single line with the following structure:
```c
  <retType> <name>(<paramType[0]> <paramName[0]>, <paramType[1]> <paramName[1]>);  <desc>
```

Be careful with functions broken into several lines, it breaks the process!

Structs are expected as several lines with the following form:
```c
<desc>
typedef struct <name> {
    <fieldType[0]> <fieldName[0]>;  <fieldDesc[0]>
    <fieldType[1]> <fieldName[1]>;  <fieldDesc[1]>
    <fieldType[2]> <fieldName[2]>;  <fieldDesc[2]>
} <name>;
```
Enums are expected as several lines with the following form:
```c
<desc>
typedef enum {
    <valueName[0]> = <valueInteger[0]>, <valueDesc[0]>
    <valueName[1]>,
    <valueName[2]>, <valueDesc[2]>
    <valueName[3]>  <valueDesc[3]>
} <name>;
```
NOTE: 
Multiple options are supported for enums:
- If value is not provided, `lastValue + 1` is assigned
- Value description is optional

## TODO list
- Work on simplifying parse.bqn. It can be improved a ton.
- Work on removing some constraints.
- Work on inProgress/oneTimeUse.bqn, for users who may not know bqn and want to just make an ffi file right away.

# Credits
- raylib's [raylib_parser.c](https://github.com/raysan5/raylib/blob/710e811b2768e573b3c1a9eb4883f7a552d3d101/parser/raylib_parser.c) was translated to bqn then modified. Without this, this project wouldn't exist. Big thanks to raylib!
