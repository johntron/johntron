# Platform for spacecraft engineering education

I'm a software engineer who's spent 15 yearsbuilding stuff like web apps for large enterprises, crawlers and analysis tools, security appliances, etc. This project is to try to understand how organizations like NASA and SpaceX build the avionics and various subsystems for spacecraft.

It's my understanding that these companies use simulations to facilitate testing and integration of all the various systems in use on spacecraft. From what I've studied, this process would look something like this:

 * An initial low-fidelity, software-only simulation of the spacecraft and its mission
 * As the planning progresses, this simulation becomes more and more detailed
 * At some point development begins on hardware, and this is integrated into the simulation (ideally early)
 * As the hardware becomes more robust, the various development teams learn more through simulation and eventually begin integrating with other subsystems for real-world testing
 * At some point the whole spacecraft is ready for testing, but simulations might still be used as a robust analysis tool when the mission changes or accidents happen

 Unfortunately, I have very little experience in things like 3D programming and physics, so starting from a low-fidelity software-only simulation would itself be a big achievement for me. Instead, I'm taking a bottom-up approach and working on each subsystem separately. I'm hoping this will allow me to pick up the skills I'd need in a more progressive pace, and also lets me spend some time on a long-standing hobby of mine: electronics and radio.


## Tools

I'll be using:
 * NASA's [trick] - awesomesauce
 * NASA's [IDF] – awesomerelish
 * [mbed]
 * ST's STM32 product – great features, software support, and prices
 * WiFi – maybe eventually some SDR stuff
 * Probably some Raspberry Pi's for convenience


## Tradeoffs

I don't have the resources of these larger organizations, so here's how I'm making this project more feasible:

* Agile planning – nobody's going to die, and it's just for fun anyways
* Cheap, commercial off-the-shelf (COTS) tools – no radiation hardened hardware like IC's with sapphire substrate, no Spacewire, and no data storage systems with transmission assurance (although I might experiment with some of these if possible)
* Focus on simulation as a design tool – less focus on space and domain-specific challenges like orbital mechanics / rendezvous, communication networks, etc.


## Subsystems

These are the things I'd like to explore:


[trick]: https://github.com/nasa/trick
[idf]: https://github.com/nasa/idf
[mbed]: http://mbed.org