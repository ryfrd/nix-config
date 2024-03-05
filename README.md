`hostname.nix` - config i want exclusively on that machine

`common.nix` - config i want on all machines; imported into all `hostname.nix` files

config i want on multiple but not all machines split out into modules that are imported in `hostname.nix` file eg.

```nix
imports = [
  ./docker/default.nix
];
```
