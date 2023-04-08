# Testing React code

# Unit testing


# Regression testing

## Storybook

[Storybook](https://storybook.js.org/docs/react/get-started/introduction) is a tool enabling us to visualize the components we build in the UI. In a "playground" manner, so that we can visualized them and customize them in isolation. We can also compare them easily.


## Loki

[Loki](https://github.com/oblador/loki) helps us keep track of the changes in the UI by taking snapshots (physical screen captures) of how the components would look in a given device, and comparing it to the current ones.

To trigger the snapshots of the components:
```sh
$ yarn loki update
```

Check current layout vs difference:
```sh
$ yarn loki test
```
