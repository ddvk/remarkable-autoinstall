# Quick and dirty reMarkable2 KOReader toggler

## Install

```
sh -c "$(wget https://raw.githubusercontent.com/ddvk/remarkable-autoinstall/master/rm2/auto_rm2.sh -O-)" 
```

## Usage
Long swipe up (from bottom to top) to switch to KOReader (exit or swipe up to go back)


### Notes

As mentioned, just a quick and easy hack. Currently using a nightly build of koreader

**DON'T USE IT TOGETHER WITH THE RM2FB PACKAGE FROM TOLTEC**, i.e. uninstall this first.


For a more streamlined solution you can use [toltec](https://github.com/toltec-dev)


This will not touch xochitl, thus it should be pretty safe.

You can compile the touchinjector from source: https://github.com/ddvk/remarkable-touchgestures

To remove it and koreader, remove the touch service
```
systemctl stop touchinjector
rm /etc/systemd/system/touchinjector.service
rm -fr apps
rm -fr scripts
```

### Troubleshooting
For the logs
```
systemctl status touchinjector
journalctl -u touchinjector
```

to just test if it is staring: `~/scripts/ko.sh`
