### ERB

ERB is a pretty cool technology, and a great example of the power and versitility of Ruby.

But... it can be a pain to use.  Especially once you're used to Rails, which provides a great API for using ERB to render HTML templates.  ERB wants a binding, or a proc, and getting those to contain the values you want is a pain.

Enter... EasyRB.

#### EasyRB

EasyRB provides 3 convenience method that make it easy to render ERB templates:

- `String#erb(options = {})` turns the string it is called on into an ERB template, and renders it with the provided options.

- `File::erb(filename, options = {})` turns the contents of the file with the given filename, and renders it with the provided options.

- `File#erb(options = {})` turns the contents of the file into an ERB template, and renders it with the provided options.

In addition, you can manually create and run an ERB template using:

- `EasyRB::Runner.new(erb_template).run(options = {})`

Each of these methods may take any of the same 3 options:

- `:context` this is the object that is "self" for evaluating the template.  If none is provided, then a new Object is used.

- `:helpers` this is a module or array of modules that provides addition methods when evaluating the template.  Note that providing these does not change the `:context` object.

- `:locals` this is a hash whose keys will become local variables accessible when evaluating the template.  Note that providing these does not change the `:context` object.

Note: if the same method/key is provided in all three of the options, the priority is locals > helpers > context.  This is a Ruby thing, not explicitly a EasyRB thing.

#### Examples

```ruby
"Hello, #{ first_name } #{ last_name }".erb(locals: { first_name: "Mark", last_name: "Josef" })
# => "Hello, Mark Josef"
```

```ruby


