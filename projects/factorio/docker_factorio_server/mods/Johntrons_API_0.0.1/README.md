
# gRPC

At it's core, this API uses the [RCON protocol]; however, this protocol
is only friendly to machines. Instead, this project uses [gRPC] as a
developer-friendly abstraction layer over RCON. In addition to making
developer's lives easier, gRPC offers tools to generate Factorio clients
in a variety of languages. This allows anyone with a little knowledge
of gRPC and some expertise in gRPC-supported language to port this
project to their preferred language.


# Todo

* How to return values from API
* How to organize code into "commands" or namespaces, with lua and JS side-by-side
* Identify main "namespaces", incl. native object tree
* Understand how to generate JS API from gRPC specs - https://github.com/grpc/grpc/issues/8432#issuecomment-255172025
* Understand how to generate RCON + JSON from JavaScript / gRPC - https://github.com/grpc/grpc/issues/8432#issuecomment-255172025
* Understand how to convert JSON to Lua commands
* Move stuff from on_load() to on_init()


# Credits

* [Lua JSON library]


[Lua JSON library]: https://github.com/rxi/json.lua
[RCON protocol]: https://developer.valvesoftware.com/wiki/Source_RCON_Protocol
[gRPC]: https://grpc.io/