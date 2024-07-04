# Supermarket

This Ruby project implements a cashier system that supports various pricing rules such as Buy One Get One Free, Discounts, and Two-Thirds off.

## Installation

1. Clone the repository:

   ```sh
   git clone git@github.com:arnaub/supermarket.git
   cd supermarket
   ```

2. Install dependencies using Bundler:

   ```sh
   bundle install
   ```

## Usage

Follow the steps below to use the Cashier system in an interactive Ruby session:

1. Start an interactive Ruby session with Sorbet runtime:

   ```sh
   bundle exec irb -r sorbet-runtime
   ```

2. Require the necessary files:

   ```ruby
   require_relative "./cashier/items"
   require_relative "./cashier/checkout"
   ```

3. Initialize the rules and the checkout system:

   ```ruby
   rules = Cashier::Rules::Manager.new.list
   checkout = Cashier::Checkout.new(rules)
   ```

4. Find an item and scan it:

   ```ruby
   item = Cashier::Items.find('CF1')
   checkout.scan(item)
   ```

5. View scanned items:

   ```ruby
   checkout.items
   ```

6. Calculate the total:

   ```ruby
   checkout.total
   ```

## Example

Here's a full example of using the Cashier system:

```ruby
# Start IRB session with Sorbet runtime
bundle exec irb -r sorbet-runtime

# Require necessary files
require_relative "./cashier/items"
require_relative "./cashier/checkout"

# Initialize rules and checkout system
rules = Cashier::Rules::Manager.new.list
checkout = Cashier::Checkout.new(rules)

# Find and scan an item
item = Cashier::Items.find('CF1')
checkout.scan(item)

# View scanned items
checkout.items

# Calculate the total
checkout.total
```
