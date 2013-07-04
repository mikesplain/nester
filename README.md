Nester
======

A web api wrapper for the Nest Thermostat ruby gem: https://github.com/ericboehs/nest_thermostat

---

Nester was written as a quick hack to provide a web api for the Nester Thermostat via the Nest Theromstat ruby gem.  I wanted it to fast and light so Heroku to spin up on demand.


## Routes

    yourhost.com/api/[nest email]/[nest password]/command

## Commands

```ruby
temp # => Current temperature
away # => Current away status

away/true # => Sets current away status to true
away/fase # => Sets current away status to false
```

## Todo

1.  Add more commands and expand
2.  Refactor to simplify
3.  Add authentication so u/p don't have to be passed in plain english
