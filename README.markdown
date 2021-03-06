# Enterprise Time Extensions

Enterprisey extensions to Ruby's Time class.  How else will you know when it's
OK to stop avoiding work, and you can actually leave work?

Example:

## Un-Fun, All-Business Instance Method Examples

```ruby
    t = Time.now #=> Fri Jan 09 22:12:31 0100 2009
    # Enterprisey methods in action!:
    t.after_hours? #=> false
    t.holiday? #=> false

    t = Time.local(2009, 12, 25) #=>  Fri Dec 25 00:00:00 0100 2009
    t.after_hours? #=> true -- because it's a holiday
    t.holiday? #=> true -- I told you!

    t = Time.local(2009, 1, 9, 18, 30) #=> Fri Jan 09 18:30:00 0100 2009
    t.after_hours? #=> true -- Business hours are 8AM to 6PM ... SHARP!
    t.holiday? #=> false
```

There are question mark methods for the holidays that are paid-time-off for
slaves of The Enterprise.

* new_years_day?
* mlk_jr_day?
* memorial_day?
* independence_day?
* labor_day?
* thanksgiving?
* christmas_day?

_If you need/want more, let me know!  You're welcome
to do it yourself, if you wish._

## Frank, Straight-Shooting Class Methods

```ruby
  # Countdown to the next football game?
  Time.next_sunday #=> Sun Jan 11 00:00:00 0100 2009
  # The big one:
  Time.nth_wday(3, 6, 7, 2009) #=> Sat Jul 18 00:00:00 0200 2009
```

Time::nth_wday could probably use some explanation.  Time::nth_wday will find the 'nth' week day of a month.  Above, we found the 3th (hehe) Saturday of July 2009.  This is actually used often in the various holiday methods from above.  For instance, Thanksgiving is on the 4th Thursday of November.  The method looks like this:

```ruby
  def self.nth_wday(n, wday, month, year)
    # ...
  end
```

*Enjoy!*
