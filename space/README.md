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
 * ST's STM32 – great features, software support, and prices (Nucleo F401RE)
 * ESP32 for WiFi – keeping it simple, but maybe some SDR stuff later on (Sparkfun ESP32 Thing)
 * TB6612FNG for DC motor control (5-5.5V or so)
 * Some Pololu step-up/down voltage regulators (S7V8A and/or S18V20ALV)
 * Some generic tank chassis with tracks and two DC gear motors (~$15-20 stuff I had laying around)
 * Probably a Raspberry Pi for convenience


## Tradeoffs

I don't have the resources of these larger organizations, so here's how I'm making this project more feasible:

* Agile planning – nobody's going to die, and it's just for fun anyways
* Cheap, commercial off-the-shelf (COTS) tools – no radiation hardened hardware like IC's with sapphire substrate, no Spacewire, and no data storage systems with transmission assurance (although I might experiment with some of these if possible)
* Focus on simulation as a design tool – less focus on space and domain-specific challenges like orbital mechanics / rendezvous, communication networks, etc.


## Subsystems

These are the things I'd like to explore:

* Navigation: where am I withing my environment (point A) and where are the things I care about (potential B's)
* Guidance: planning path for getting from A to B
* [Control]: operating motion systems to follow predetermined path
* [Communications]: what commands do I accept / issue and how is a message transmitted (physical / digital / application interfaces)
* [Power]: do I have enough?

Note: initially navigation and guidance will be simulation-only and messages from these systems will be sent remotely


![Subsystems][subsystem diagram]

## Motion

![simple move][simple move]

## Todo

* ~~Familiarize myself with Trick~~
* ~~Familiarize myself with mbed~~
* ~~Figure out how to use ESP32 with toolchain~~
* ~~Setup STM32, TB6612FNG, and tank chassis for motor control testing~~
* ~~Connect motion (5V, 1A) and comms (3.3V, mA range) subsystems to a common power supply~~
* Mount components on chassis for mobility
* Add emergency shutoff switch
* Figure out how _roughly_ to integrate Trick and the subsystems
* Figure out how I should use IDF – at least use as abstraction layer to enable easy transition from remote guidance / navigation to on-board


[trick]: https://github.com/nasa/trick
[idf]: https://github.com/nasa/idf
[mbed]: http://mbed.org
[SIM_wheelbot]: https://github.com/nasa/trick/tree/9335b9cff8939b28168f9854720d165d75e65c94/trick_sims/SIM_wheelbot
[Control]: ./subsystems/control/README.md
[Communications]: ./subsystems/comms/README.md
[Power]: ./subsystems/power/README.md
[subsystem diagram]: ./docs/subsystems.png
[simple move]: ./docs/simple-move.png
