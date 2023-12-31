# C-headers to BQN FFI
parse.bqn is the main file, used on a header file to autogenerate bqn ffi code.

For how to use, you can look in examples. You may look at comments in parse.bqn for how each function works.

For documentation on FFI in BQN, look in https://mlochbaum.github.io/BQN/spec/system.html#foreign-function-interface

# Header file parsing
The parser scans input to get API information about defines, structs, aliases, enums, callbacks and functions.
All data is divided into pieces, usually as strings.

## CONSTRAINTS:
Functions are expected as a single line with the following structure:
```c
  <retType> <name>(<paramType[0]> <paramName[0]>, <paramType[1]> <paramName[1]>);  <desc>
```

### Be careful with functions broken into several lines, it breaks the process!
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
- Make parse.bqn's JsonToFFI just take in the data representation given by ParseHeader. This removes the json.bqn dependency.

# Credits
- raylib's [raylib_parser.c](https://github.com/raysan5/raylib/blob/710e811b2768e573b3c1a9eb4883f7a552d3d101/parser/raylib_parser.c) was translated to bqn then modified. Without this, this project wouldn't exist. Big thanks to raylib!