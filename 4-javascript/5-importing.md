# Importing stuff

# 1 - Exporting

In JavaScript, it is necessary to `export` objects we want to access in other files. 

There are two ways of exporting:
- Regular export: export multiple things
- Default export: when there is only one thing on the file to export

Regular export:
```js
export const bassPlayer = () => 'Paul McCartney';
export function myFunction;
export class myClass;
```


```js
export default rhythmGuitarPlayer = () => 'John Lennon';
```

# 2 - Importing

The importing syntax is different for regular and default exports.

## Named imports

Named imports are needed for exports that do not use the `default` keyword.

Example syntax:
```js
import { bassPlayer } from './mccartney.js'
import { instrument } from './mcartney.js'
```
- The curly braces will look for the exact constant name

Additionally, we can rename the variables with the below syntax:
```js
import { bassPlayer as bass } from './mccartney.js'
```

Also, we can import everything in a bundle to access it later:
```js
import { * as mccartneyBundled } from './mccartney.js'
```

## Default imports



Default import:
```js
import guitarPlayer from './lennon.js'
```


