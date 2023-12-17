# 3 Basic Data Types and Functions

We won't cover all of the preliminaries of `leo` lang, but the most essential ones for this workshop.

This is more of a cheat sheet of basic data types and functions that we will be using to get started. Would definitely recommend to check out the original developer documentation about leo language, please check out [here](https://developer.aleo.org/leo/language).

## Basic Data Types

- `bool`: either `true` or `false`
- `i8`, `i16`, `i32`, `i64`: integer.
- `u8`, `u16`, `u32`, `u64`: unsigned integer.
- `address`: type for wallet address/public address.
- **Array**: type for static arrays. Arrays are declared as [type; length] and can be nested. Arrays cannot be empty nor modified.
- `mapping`: A mapping is declared as mapping {name}: `{key-type} => {value-type}`. Mappings contain key-value pairs. Mappings are stored on chain.
- `record`: A record data type is declared as record {name} {}. Records contain component declarations `{visibility} {name}: {type}`. Record data structures must contain the `owner` component

## Function Types

- `transition`: Your code for offchain computation.
- `finalize`: Your code for onchain computation. Will be ran right after the transition function execution offchain. When declaring it in Leo program, it must be immediately follow a transition function, and must have the same name.
- `function`: Helper function, can only be called within transition, finalize, or helper function.
- `inline`: can only be called within transition, finalize, helper, or inline function.