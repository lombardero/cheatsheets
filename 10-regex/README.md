# Regular expressions

Regular expressions are useful to match and identify patterns of text. They can be
used to assert a pattern is found in a given string, or to get an element from it.

Building blocks:
- basics:
  - `.`: Any character
  - `
  - `*`: Zero or more of previous characters
  - `\`: "Literal" - do not interpret next character as an operator (ex: `google\.com` s)
- Character matchers:
  - `.`: Any character
  - `\d`: Numeric digit (0 to 9)
  - `\D`: Anything that is not a digit (0 to 9)
  - `\w`: Word character (a-z, A-Z, 0-9, _)
  - `\W`: Not a word character
  - `\s`: Whitespace (space, tab, newline)
  - `\S`: Not a whitespace
- Quantifiers
  - `*`: 0 or more of previous matchers
  - `+`: 1 or more of the previous matchers
  - `?`: 0 or 1 of the previous matchers
  - `{n}`: Matches `n` of the previous matchers
  - `{n,m}`: Matches a min of `n` and a max of `m` of the previous matchers
- Boundaries
  - `\b`: Word boundary (ex: seach words starting with "Ma": `\bMa`, also works `nuel/b`)
  - `\B`: Not a word boundary
  - `^`: Beginning of a string
  - `$`: End of a string
- Matchers:
  - `[]`: Mathes characters inside brackets (ex: `[-.]` will match `-` and `.` - only
  one instance). No need to escape characters here (no need to do `\.`) Also: for ranges
  of numbers can do `[1-7]` for numbers 1 to 7, and `[a-z]` for lower letters from a to z
  - `[^ ]`: Matches characters not in brackets
  - `(|)`: either or (ex: `(r|s)` `r` or `s`)

