# Introduction
Pry Syntax Hacks adds a few short-hands to help when exploring ruby objects.

The word "hack" is in the name of the gem deliberately — using this will almost certainly bite you
in unexpected ways.

# Features

Accessing instance variables:

    pry (main)> User.new.@secret_password
    => "lollercoaster"

Calling private methods:

    pry (main)> User.new.!hash_password("foo")
    => "a4721n"

Accessing method objects:

    pry (main)> ["foo@bar.com"].map &User.:find_by_email

Accessing outer Pry bindings:

    pry (main)> cd (a = Object.new)
    pry (main)> puts ../a
    #<Object:0x195aca8>

# Issues

This will break regular expressions most often:

    pry (main)>  Users.all.map(&:email).grep /...@foo.com/

will still get rewritten to:

    pry (main)> Users.all.map(&:email).grep /..instance_variable_get('@foo').com/

which is probably not what you want.

# Meta-foo

Licensed under the MIT license. Contributions welcome.

