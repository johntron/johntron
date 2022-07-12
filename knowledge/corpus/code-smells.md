# Code smells

It's important to develop an eye for bad code. There are objective tools for this, but there are a few subjective methods as well.

## Subjective

* Changes in shape: lots of nested indentation – often from conditionals
* Changes in color: differences in code highlighting due to mixing of operations
* Magic numbers / strings

## Objective

Cyclomatic complexity (see plato.js)

## Refactoring process

* For really ugly / complicated code, refactor first, so you can improve design next.
* Refactor only when tests are passing. Make siplest change to get them passing, then consider next refactoring step

## Tips

* Prefer duplication over wrong abstration. Duplication is cheaper than the wrong abstraction. Focusing on DRY too early can lead to wrong patterns.
* Reach for open / closed. Make the change easy, then make the easy change
* Make small things
* Following these processes highlights similarity and patterns in code
* Refactoring often temporarily increases duplication and complexity, but pays off after completion. This is OK
* Methods / symbols with common suffixes means should have a set of classes with one common method / property
* Methods / symbols with common prefixes means should have one class with multiple methods / properties
* Just watch [RailsConf 2014 - All the Little Things by Sandi Metz](https://www.youtube.com/watch?v=8bZh5LMaSmE)
