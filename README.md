# RailsCallbackEx

Insert/delete callbacks for rails.

## Dependencies

* ruby 3.0+
* rails 6.1+

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_callback_ex'
```

Then execute:

    $ bundle

## Usage

### Controller

Example:

```ruby
class SamplesController < ActionController::Base
  before_action :action1
  before_action :action2

  insert_before_action :new_action1, before: :action1
  insert_before_action :new_action2, after: :action1
end

SamplesController.__callbacks[:process_action].map(&:filter) #=> [:new_action1, :action1, :new_action2, :action2]

SamplesController.delete_before_action :new_action1

SamplesController.__callbacks[:process_action].map(&:filter) #=> [:action1, :new_action2, :action2]
```

### Model

Example:

```ruby
class Sample < ActiveRecord::Base
  before_save :action1
  before_save :action2

  insert_before_save :new_action1, before: :action1
  insert_before_save :new_action2, after: :action1
end

Sample.__callbacks[:save].map(&:filter) #=> [:new_action1, :action1, :new_action2, :action2]

Sample.delete_before_save :new_action1

Sample.__callbacks[:save].map(&:filter) #=> [:action1, :new_action2, :action2]
```

Supported callbacks are `validation`, `save`, `create`, `update` and `destroy`.

### Job

Example:

```ruby
class SampleJob < ActiveJob::Base
  before_perform :action1
  before_perform :action2

  insert_before_perform :new_action1, before: :action1
  insert_before_perform :new_action2, after: :action1
end

SampleJob.__callbacks[:perform].map(&:filter) #=> [:new_action1, :action1, :new_action2, :action2]

SampleJob.delete_before_perform :new_action1

SampleJob.__callbacks[:perform].map(&:filter) #=> [:action1, :new_action2, :action2]
```

Supported callbacks are `enqueue` and `perform`.

### Mailer

Example:

```ruby
class SampleMailer < ActionMailer::Base
  before_deliver :action1
  before_deliver :action2

  insert_before_deliver :new_action1, before: :action1
  insert_before_deliver :new_action2, after: :action1
end

SampleMailer.__callbacks[:deliver].map(&:filter) #=> [:new_action1, :action1, :new_action2, :action2]

SampleMailer.delete_before_deliver :new_action1

SampleMailer.__callbacks[:deliver].map(&:filter) #=> [:action1, :new_action2, :action2]
```

Supported callback is `deliver`. Note that `deliver` callbacks can be used on rails >= 7.1.

## Contributing

Bug reports and pull requests are welcome at https://github.com/kanety/rails_callback_ex.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
