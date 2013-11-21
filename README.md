# simple2quicken

A simple command line tool for converting [Simple](http://simple.com) CSV exported transactions into the QIF format suitable for import into Quicken.

## Usage

Note: this assumes you have a modernish ruby environment installed.  Right now I'm on `ruby 1.9.3p429 (2013-05-15 revision 40747) [x86_64-darwin12.3.0]` installed with rvm in `/Users/jdw5/.rvm/rubies/ruby-1.9.3-p429/bin/ruby`.  There's a good chance the following will work on your vanilla Mac OS > 10.6 or modernish Linux installation.  YMMV; send me an email if it doesn't and I'll try to help you.

```
$ bundle install
$ bundle exec simple2quicken.rb <transaction filename> <qif output filename> <quicken account name>
```

`quicken account name` can be a new or existing one.  See [this community forum post](https://qlc.intuit.com/questions/153976-how-to-import-qif-files-into-non-cash-accounts-post-q2004) for details on how to do the import.  `simple2quicken` prepends the proper header (per that article), so start with the "Then in Quicken" section.  I had to have a `cash` account created already.

## TODO

* making sure this works properly with new transactions (we currently don't de-dup, you'll have to do that manually)
* "Cleared" and "Categories"

## LICENSE

simple2quicken: converts Simple.com CSV transaction logs to QIF for import to Quicken

Copyright (C) 2013  Jason Woodward <jason@jwoodward.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/woodwardjd/simple2quicken/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

