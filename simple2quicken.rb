# simple2quicken: converts Simple.com CSV transaction logs to QIF for import to Quicken
# 
# Copyright (C) 2013  Jason Woodward <jason@jwoodward.com>
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'rubygems'
require 'bundler'
Bundler.require(:default)

require 'csv'

## Simple.com csv output (currently, 2013/11/21) looks like:
# [0] Date in dd/mm/yyyy
# [1] Recorded At
# [2] Scheduled For
# [3] Amount
# [4] Activity
# [5] Pending
# [6] Raw description
# [7] Description
# [8] Category folder
# [9] Category
# [10] Street address
# [11] City
# [12] State
# [13] Zip
# [14] Latitude
# [15] Longitude
# [16] Memo

raise "must provide an input filename" unless (input_filename = ARGV.shift)
raise "must provide an output filename" unless (output_filename = ARGV.shift)
raise "must provide a quicken account name" unless (quicken_account_name = ARGV.shift)

Qif::Writer.open(output_filename, type = 'Bank', format = 'mm/dd/yyyy') do |qif|
  ## handle https://qlc.intuit.com/questions/153976-how-to-import-qif-files-into-non-cash-accounts-post-q2004
  qif.instance_eval do 
    write_record "!Account\nN#{quicken_account_name}\nTBank"
  end
  CSV.read(input_filename).each do |row|
    row = row.map { |e| e.respond_to?(:strip) ? e.strip : e }  ## clear whitespace, if any
    next if row[0] == 'Date'  ## skip header row
    qif << Qif::Transaction.new(
      :date         => Date.parse(row[0]),
      :amount       => row[3].to_f,
      :memo         => row[16],
      :payee        => row[6],
      ## TODO: "cleared" (which doesn't appear to be supported by the qif gem)
      ## TODO: convert [9] and [8] (Simple "Categories") into standard Quicken "Categories"
      ## TODO: Convert [4]'s "ACH", "Signature purchase", "Check deposit" into standard Quicken "Categories"
    )
  end
end