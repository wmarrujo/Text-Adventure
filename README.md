#Text Adventure

An as yet unknown adventure. In Text!

##Useful Things

[Swift Documentation](http://swiftdoc.org)

##Specifics

- Written in Swift

##How to Run

0. Make sure you have the latest snapshot of swift
1. Run `swift build` in the root directory of the package (the one with the `Package.swift`)
2. The executable is in `.build/debug/Text-Adventure` (or whatever the target is called, depending on your filesystem)

##Structure

###Object Structure
```
Thing
├─ Location
├─ Portal
├─ Creature
│  └─ Player
└─ Item
   ├─ Container
   ├─ Food
   └─ Weapon
```
###Syntactic Structure
```
Lexical Categories

Verb
Noun
Adjective
Adverb
Preposition
Conjunction
Determiner

PhrasalCategories

NounPhrase
PrepositionalPhrase
VerbPhrase
```