Below is the best summary I've seen – stolen from the [experts at Wurth Electric] (thank you!). The [Apple iPhone charger teardown](http://www.righto.com/2012/05/apple-iphone-charger-teardown-quality.html) was what got me interested in switching topologies. I can't wait to see the next generation of power supplies built on Galium Nitride (GaN).


## Buck

Buck converters are one of the simplest, cheapest and most common topologies. While this topology is not suited for applications where isolation is required, it is ideal as a DC to DC converter used to step- down voltages. Not only can you achieve high efficiency levels, but also high power levels using a buck converter, especially with poly-phase topologies. The down side to buck converters is that the input current is always discontinuous, resulting in higher EMI.

However, EMI issues can be addressed with filter components such as chip beads, common mode chokes and filter chokes.

The buck topology only requires a single inductor for single-phase applications, and catalog inductors for a wide range of applications are available. In addition, custom inductors can be developed for those special inductance versus current values that are required, as well as for applications requiring extra windings for sensing or supplying power to the controller.


## Boost

The boost topology, like the buck topology, is non-isolating. Unlike the buck topology, the boost steps up the voltage rather than stepping it down. Because the boost topology draws current in a continuous, even manner when operating in continuous conduction mode, it is an ideal choice for Power Factor Correction circuits. Like the buck topology, there are many catalog choices for the inductor used in boost circuits, and where there is a special need, custom inductors are available as well.


## Buck-Boost

The buck-boost topology can either step the voltage up or down. This topology is particularly useful in battery powered applications, where the input voltage varies over time but has the disadvantage of inverting the output voltage. Another disadvantage to the buck-boost topology is that the switch does not have a ground, which complicates the drive circuit. Using only a single inductor like the buck and the boost topologies, the buck-boost inductor and EMI components are readily available.


## SEPIC/Ćuk

The SEPIC and Ćuk topologies both use capacitors for energy storage in addition to two inductors. The two inductors can be either separate inductors or a single component in the form of a coupled inductor. Both topologies are similar to the buck-boost topology in that they can step-up or step-down the input voltage, making them ideal for battery applications.

The SEPIC has the additional advantage over both the Ćuk and the buck-boost in that its output is non-inverting. An advantage to the SEPIC/ Ćuk topologies is that the capacitor can offer some limited isolation. Catalog coupled inductors are available for the SEPIC and Ćuk topologies, and custom inductors are readily available for special needs.


## Flyback

The flyback topology is essentially the buck-boost topology that is isolated by using a transformer as the storage inductor. The transformer not only provides isolation, but by varying the turns ratio, the output voltage can be adjusted. Since a transformer is used, multiple outputs are possible. The flyback is the simplest and most common of the isolated topologies for low-power applications. While they are well suited for high-output voltages, the peak currents are very high, and the topology does not lend itself well to output current above 10A.

One advantage of the flyback topology over the other isolated topologies is that many of them require a separate storage inductor. Since the flyback transformer is in reality the storage inductor, no separate inductor is needed. This, coupled with the fact that the rest of the circuitry is simple, makes the flyback topology a cost effective and popular topology.


##  Forward

The forward converter is really just a transformer isolated buck converter. Like the flyback topology, the forward converter is best suited for lower power applications. While efficiency is comparable to the flyback, it does have the disadvantage of having an extra inductor on the output and is not well suited for high voltage outputs. The forward converter does have the advantage over the flyback converter when high output currents are required. Since the output current is non-pulsating, it is well suited for applications where the current is in excess of 15A.


## Push-Pull

The push-pull topology is essentially a forward converter with two primary windings used to create a dual drive winding. This utilizes the core of the transformer much more efficiently than the flyback or the forward converters.

On the other hand, only half the copper is being used at a time, thereby increasing the copper losses significantly in a similar sized transformer. For similar power levels, the push-pull converter will have smaller filters compared to the forward converter.

However the advantage that push-pull converters have over flyback and forward converters is that they can be scaled up to higher powers. Switching control can be difficult with push-pull converters, because care has to be taken not to turn on both switches at the same time. Doing so will cause the equal and opposite flux in the transformer, resulting in a low impedance and a very large shoot-through current through the switch, potentially destroy- ing it.

The other disadvantage to the push-pull topology is that the switch stresses are very high (2∙VIN), which makes the topology undesirable for 250VAC and PFC applications.


## Half-Bridge

The half-bridge topology, like push-pull topologies, can be scaled up well to higher power levels and is based on the forward converter topology. This topology also has the same issue of the shoot-through current, if both switches are on at the same time. In order to control this, there needs to be a dead-time between the on-time of each switch. This limits the duty-cycle to about 45%. Beneficially, the half-bridge topology switching stresses are equal to the input voltage and make it much more suited to 250VAC and PFC applications.

On the flip side, the output cur- rents are much higher than the push-pull topology, thereby making it less suited for high current outputs.


## Resonant LLC

The resonant LLC topology is a half-bridge topology that uses a resonant technique to reduce the switching losses due to zero voltage switching, even in no-load conditions. This topology scales up well to high power levels and has very low losses in devices that are on at all times. This topology is not as well suited for stand-by mode power supplies, as the resonant tank circuit needs to be energized continuously.

The resonant LLC also has the advantage over both push-pull and half-bridge topologies of being suitable for a wide range of input voltages. The down side to the resonant LLC topology is its complexity and cost.


[Wurth Electric]: https://www.we-online.com/web/en/passive_components_custom_magnetics/blog_pbcm/blog_detail_electronics_in_action_45887.php