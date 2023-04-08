# React basics

- [React basics](#react-basics)
  - [Single-page applications](#single-page-applications)
  - [React Native](#react-native)
  - [Extension](#extension)
  - [React patters](#react-patters)

React is a JavaScript library that makes user interfaces feel "reactive". In
web browsers, loading the whole HTML -if it is big- might hinder performance
of the page. That is where JavaScript and React come into the rescue.

> This happens because JavaScript runs in the browser, JavaScript can miodify
> what the user sees.

As it runs in the browser, it is considered a "client"-side library.

It splits the logic of building a UI into smaller components, making the code
more readable and maintainable.

## Single-page applications

Single-page Applications (SPAs) are applications (such as the Netflix page)
which renders an entire HTML page which is fully controlled dynamically by
JavaScript (React). It loads everything and displays what the user needs
dynamically.

This is different from the widget approach, in which different
parts of the pages are rendered and served by a backend.

## React Native

React native allows to have _almost_ one single codebase for IoS and Android. For some use-cases, such as accessing the camera, we might need to write wrappers in native code. Often, there are libraries for this. Sometimes we need to write our own.

## Extension

Download the React Chrome Extension to add React debugging!

## React patters

Smart and dumb components. Important to keep this in mind.
