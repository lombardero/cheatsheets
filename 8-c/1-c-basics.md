# C Basics

Convention:
- The `main()` function should be on the top of the file. To make that work, we need to
  add function hints (called prototypes) telling the compiler which functions we have
  defined. Example:

```c
include <stdio.h>

void hello(void);

int main(void)
{
    hello();
}

void hello()
{
    printf("Hello!\n);
}
```
> Note: `void` means that a function does not return anything, and is used to tell the
> interpreter functions does not take any argument

# 1 - Variable types

In `C`, any variable definition needs to let the interpreter know what type will be the
variable. For example:

```c
string my_string
```

The types supported in C are:
- `int`: integer (use `%i` to print it)
- `long`: long integer (using 64 bits, use `%li` to print it)
- `string`: multi-character string (use `%s` to print it) - use single quotes to compare
  strings
- `char`: a single character (use `%c` to print it)
- `float`: a floating comma number
- `double`: double-precision comma number (uses 64 bits)
- `long`
- `bool`

## Type casting

C supports type casting (cnverting one type to another on-the-fly). For example, we can
obtain the result of a fraction between two integers as a float by:
```c
int three = 3
int two = 2

float division = (float) two / (float) three
```
- `(float) three` type-casts the `three` integer into a `float`

# 2 - Operators

- `+`: sum
- `-`: substraction
- `*`: multiplication
- `/`: division (will return `int` if it is used between integers)
- `%`: remainder operation
- `==`: voolean comparison
- `||`: "or" operator


# 3 - Header files

Header files are libraries introducing functions and functionalities to the code, for
example, the `stdio.h` library provides a `printf` function to output something in the
termina.

To import:
```c
#include <stdio.h>
```

# 4 - Logical statements

## 4.1 `if` statements

```c
if (condition)
{
    // statement
}
else id (condition)
{
    // statement
}
else
{
    // statement
}
```

# 5 - Loops

## 5.1 While loops

### Regular while

```c
while (condition)
{
    // statement
}
```

### `do` - `while`

The `do`-`while` allows us to do some computation and check the `while` conditions
AFTER the computation is done.

```c
do
{
    // statement
}
while (condition);
```

> Note: declaring the counter value is required for `while` - `do`, since it needs
> to live in the same scope (curly braces)
> ```c
> int n;
> do
> {
>   n = // something
> }
> (while n < 1>);
> ```


# 5.2 For loops

```c
for (int i = 0; i < 50; i++)
{
    // statement
}
```
- Creates a `for` loop. The syntax is a s follows:
  1. variable initialisation
  2. condition to stop the for loop
  3. modification of variable after each iteration
