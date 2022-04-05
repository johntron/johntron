# Home network

## Configuring

1. Copy .rsc to device's flash using scp
2. Run `/system reset run-after-reset=flash/wap-primary-bedroom.rsc`
3. If config didn't take, run again

## Todo

1. Script for generating configs from templates
2. ... another for comparing a new export to the compiled template output and showing diffs
3. Store secrets securely
4. https://wiki.mikrotik.com/wiki/Manual:Securing_Your_Router
5. Enable auto upgrade of routerboard
6. Rotate accounts / passwords
7. Script that uses SSH to transfer config + reset + remove config
8. ... upload / import SSH public key
9. Script to update firmware and then change settings back
10. Auto updates?s
11. Script to backup config
12. Templating for WAPs
13. Certificates?