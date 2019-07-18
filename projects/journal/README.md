# Journal

This keeps my priorities straight by helping keep track of things I deal with in day-to-day life.


## Design

Data:

* Journal
* Month
* Day
* Item

Components:

* PanelManager - manages a single panel and transitions to other panel types
* SingleDayPanel -  simple todo list for a single day
* SingleMonthPanel - ... single month
* MultiMonthPanel - ... multiple months
* ConsolidationPanel - helps consolidate items from the various panel types
* MovePanel - helps move items to another panel
* List - list of things

Services:

* Serialization - converts data in memory to a serial format
* Persistence - enables offline
* Synchronization - enables sharing between devices


## Reference

* [Svelte 3 example](https://svelte.dev/examples#hacker-news)
