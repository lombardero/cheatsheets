# Services

Services are bits of logic that do certain things (they do one thing, and do it well: SRP). Can be a function, a value or a class.

Components are passed in these services as dependencies, and defined with the `@Injectable` decorator

Usual use-cases:
- Validating user input
- Fetching data from a server
- State management 

Defining a service:
```ts
@Injectable({
  providedIn: 'root', // Service will be available in all the App
})
export class ProductsService {
  constructor() {}

  getProducts(): Product[] {
    return []
  }
}
```
- `providedIn` avoids needing to add the service in the providers array of the module definition

Adding a service:

```sh
$ ng g service <service name>
```

Using a component
```ts
export class ProductListComponent implements OnInit {
    constructor(private productsService: ProductsService) {}

    products: Product[];

    ngOnInit(): void {
        this.products = this.productsService.getProducts()
    }
}
```



