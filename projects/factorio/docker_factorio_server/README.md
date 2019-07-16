# Setup

* Factorio username to config/server-settings.json
* Login to factorio.com and retrieve a token from your profile
* Stick the token in the same config/server-settings.json
* Use a [strong password generator] to create an RCON password
* Place this password in config/rconpw
* Create a .env and place the same password in it


# Running

Start the server with:

```
sudo docker run -p 34197:34197/udp -p 27015:27015/tcp -v `pwd`:/factorio --rm dtandersen/factorio
```


# Security – don't be stupid!

This project is a serious attack vector – anyone with RCON access to a
server running the remote API can run any Factorio script they'd like.
For this reason, it's essential to use a strong RCON password – since
you won't be typing the password regularly, there's no reason you
shouldn't just generate a super-strong password using a [strong password
 generator].

 If you'd like to be better security in the future, let us know!


# To-do and notes

* How to return an error?
* Most common use case for now are custom commands – until I understand use cases better
* Use loadstring() to support dynamic commands for now – until I can flesh-out a more secure, low-level API
* Do devs need to initialize commands first before invoking?
* Raw commands - used for all commands, or only escape hatch?
* Metrics for usage analysis
* Should I provide some commands out-of-box?


[strong password generator]: https://www.google.com/search?q=strong+password+generator