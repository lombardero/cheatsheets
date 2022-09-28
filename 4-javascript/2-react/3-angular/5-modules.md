# Module

Modules consolidate components, directives and pipes into cohsive blocks of functionality. It is the way we structure code in Angular; allows to define APIs.

Defining a module:
```ts
@NgModule({
  declarations: [ProductListComponent, ProductDetailComponent], // all the components in the module (need to define everything)
  imports: [
    CommonModule
  ],
  exports: [ProductListComponent] // Things that we are allowed to expose
})
export class ProductsModule { }
```
- `declarations`: the components, pipes, and directives defined in your module
- `imports`: needed by angular
- `exports`: objects that are visible from the outside world
- `providers`: Services that can be used in the module (if they are not defined as root)
