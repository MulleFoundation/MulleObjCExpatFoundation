The trick how the library is renamed from libexpatdMT.lib is in
`dispense-mapper.sh.windows`.

The expat dependeny is marked as "no-inplace", therefore a dispense step
happens. This will look for the file in the chosen craftinfo directory, which
will be `dependency/share/mulle-craft`, where this is installing to.

