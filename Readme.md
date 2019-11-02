## Simple scp Sync

Simple perl script that can take a file name and based on a sync conf
file, send it to a series of remote hosts via the nifty scp tool

Inspired by the [Sublime Simple Sync](https://github.com/hydralien/SimpleSync)
package that works in more or less the same way

### Primary motivation
As mentioned above, I use the [Sublime Simple Sync](https://github.com/hydralien/SimpleSync)
package a lot when working with Sublime, but I also use vim heavily and in recent times, almost
exlusively. This makes my dev worflow much more different that I'm accustomed to and I'd like to
maintain the same dev worflow regardless of IDE

Additionally, I'd like to be able to have one configuration setting that can be used to sync to more
than one host to avoide dupplication which the Sublime version did not allow me to do without modifcation


### Setup
Please ass a file called `~/.simple_scp_sync_config` which is pretty much a json file of the format:
```
[
    // ...,

    {
        "hosts": [
            "kevinmurani.com"
        ],
        "username": "kmurani",  // optional, we can default to the user running the command if not needed
        "source_root_path": "/local/path/to/project/root/",
        "target_root_path": "/remote/path/to/project/root/",
        "scp_otions": "-P 22" // depends on you. If you do any extra scp options, this would be where to add them
    },

    // ...
]
```
NB: please be mindful of the validity of the JSON as it might not be parseable otherwise and the script will fail
### Run it

```
perl simple_scp.sync.pl --file simple_scp.sync.pl

```
