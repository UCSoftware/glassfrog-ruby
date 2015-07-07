# Glassfrog

[![Gem Version](https://badge.fury.io/rb/glassfrog.svg)](http://badge.fury.io/rb/glassfrog)

A Ruby interface for the GlassFrog API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'glassfrog'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install glassfrog

## Documentation

To generate local rdocs run:

    $ rdoc

## Configuration

The GlassFrog API requires a personally generated GlassFrog API key.

This can be passed into `Glassfrog::Client.new` as a String, Hash, or a Block.

```ruby
client = Glassfrog::Client.new("YOUR_API_KEY")
```

```ruby
client = Glassfrog::Client.new({ 
    api_key: "YOUR_API_KEY" 
})
```

```ruby
client = Glassfrog::Client.new do |config|
    config.api_key = "YOUR_API_KEY"
end
```

## Usage

This GlassFrog interface also has a caching feature which allows http requests to be cached and only sent once.

To set caching with the default (temporary) cache, pass `true` to the `caching` variable.

```ruby
client = Glassfrog::Client.new({ 
    api_key: "YOUR_API_KEY",
    caching: true
})
```

```ruby
client = Glassfrog::Client.new do |config|
    config.api_key = "YOUR_API_KEY"
    config.caching = true
end
```

You can change the location of the cache file (or storage type) by passing in a `caching_settings` Hash.

```ruby
client = Glassfrog::Client.new({ 
    api_key: "YOUR_API_KEY",
    caching: true,
    caching_settings: {
        :metastore   => 'file:/var/cache/rack/meta',
        :entitystore => 'file:/var/cache/rack/body'
    }
})
```

```ruby
client = Glassfrog::Client.new do |config|
    config.api_key = "YOUR_API_KEY"
    config.caching = true
    config.caching_settings: {
        :metastore   => 'file:/var/cache/rack/meta',
        :entitystore => 'file:/var/cache/rack/body'
    }
end
```

### Once the client has been configured:

#### GET all circles (or other objects)

```ruby
circles = client.get :circles
roles = client.get :roles
```

#### GET a specific circle (or other object) with an ID

```ruby
circle_1 = client.get :circle, 1
role_1 = client.get :role, 1
```

#### GET a specific circle (or other object) with an object with an ID

```ruby
circle_1 = client.get :circle, Glassfrog::Circle.new({ id: 1 })
role_1 = client.get :role, Glassfrog::Role.new({ id: 1 })
```

##### Note: Updating certain objects require specific keys (people requires admin access)

#### Create a checklist item, metric, person, or project with POST and an object

```ruby
new_person = client.post :person, Glassfrog::Person.new({ 
    name: 'Jim Bob', 
    email: 'jim.bob@example.org' 
})
```

#### Create a checklist item, metric, person, or project with POST and a Hash

```ruby
new_person = client.post :person, { 
    name: 'Jim Bob', 
    email: 'jim.bob@example.org' 
}
```

#### Update a checklist item, metric, person, or project with PATCH and an object (returns update object)

```ruby
updated_person = client.patch :person, Glassfrog::Person.new({
    id: 1, 
    email: 'jb@newemail.org' 
})
```

#### Update a checklist item, metric, person, or project with PATCH and a Hash (returns update options)

```ruby
updated_person = client.patch :person, { 
    id: 1
    email: 'jb@newemail.org' 
})
```

#### Update a checklist item, metric, person, or project with PATCH, a Hash (or an object), and a supplied identifier (returns update options)

```ruby
updated_person = client.patch :person, 1, {
    email: 'jb@newemail.org' 
})
```

#### Delete a checklist item, metric, person, or project with DELETE and an object (returns boolean)

```ruby
was_deleted = client.patch :person, { 
    id: 1
    email: 'jb@newemail.org' 
})
```

#### Delete a checklist item, metric, person, or projectw with DELETE and an identifier (returns boolean)

```ruby
was_deleted = client.patch :person, 1
```

#### Build a hierarchy from an array of circles and roles, or get them from GlassFrog

```ruby
root_circle = client.build_hierarchy circles, roles
root_circle_from_get = client.build_hierarchy
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/UCSoftware/glassfrog.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

