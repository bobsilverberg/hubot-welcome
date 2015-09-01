# Hubot Welcome

A hubot script for welcoming users to your IRC channel.

See [`src/welcome.coffee`](src/welcome.coffee) for full documentation.

This contains some code/logic borrowed from the excellent [hubot-contributejson][] project.

Designed specifically for use with the hubot [IRC][] adaptor.

## Features

* Will greet a new user who enters the IRC channel.
* Remembers every nick it sees (even nick changes) and won't greet anyone twice 
  (remembers over a restart as well if a persistent brain is used).
* Discovers who's in a channel when it joins and won't welcome any of them if they rejoin.

## Installation

In your hubot project repo, run:

`npm install hubot-welcome --save`

Then add **hubot-welcome** to your `external-scripts.json`:

```json
[
  "hubot-welcome"
]
```

### NOTE

It is ***highly*** recommended that you use a persistent hubot brain store (like [hubot-redis-brain][]).

[hubot-contributejson]: https://github.com/pmclanahan/hubot-contributejson
[IRC]: https://github.com/nandub/hubot-irc
[hubot-redis-brain]: https://github.com/hubot-scripts/hubot-redis-brain/
