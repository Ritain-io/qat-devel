[![Build Status](https://travis-ci.org/readiness-it/qat-devel.svg?branch=master)](https://travis-ci.org/readiness-it/qat-devel)

# QAT::Devel

- Welcome to the QAT Devel gem!
- This gem provides interaction with Gitlab api and DoD metrics.

## Table of contents 
- This gem have functionalities such as:
    - Get all gitlab milestone issues;
    - Validate gitlab issues status;
    - Generate release note for gitlab milestone;
    - Create a gitlab milestone tag;
    - Check that the version in development is greater than the last existing tag;
    - DoD code documentation metric;
    - DoD code static analysis metric;
    - Run all the tests.
     
- In order to execute all the above, ```qat:devel``` requires dependency automatically from other gems: 
```
'cucumber'
'rake'
'yard'
'kramdown'
'rubycritic'
'simplecov'
'simplecov-json'
'simplecov-rcov'
'minitest'
'aruba'
'retriable'
'nokogiri'
'nexus'
'gitlab'
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'qat-devel'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install qat-devel
    
# Usage
```ruby
require 'qat/devel/tasks'
```

##Get all gitlab milestone issues:
In order to get all milestone issues in gitlab it is necessary to initialize the client and then call the associated method:
```ruby
gitlab_client = QAT::Devel::GitLab::Client.new(gitlab_endpoint, gitlab_token, project_id)
gitlab_client.get_milestone_id(milestone_title)
```

##Validate gitlab issues status:
In order to validate the issues status it is necessary to run the following rake task:
```ruby
qat:devel:gitlab:milestone_issues_closed
``` 
##Generate release note for gitlab milestone:
In order to generate release note for milestone it is necessary to run the following rake task:
```ruby
qat:devel:gitlab:milestone_release_note
```
##Create a gitlab milestone tag:
In order to create a milestone tag it is necessary to run the following rake task:
```ruby
qat:devel:gitlab:milestone_tag
```
##Check that the version in development is greater than the last existing tag:
In order to check that the version in development is greater than the last existing tag it is necessary to run the following rake task:
```ruby
qat:devel:gitlab:check_version_tags
```
##DoD code documentation metric:
In order to DoD(Definition of Done) code documentation metric it is necessary to run the following rake task:
```ruby
qat:devel:validate_yard_doc[project]
```
##DoD code static analysis metric:
In order to DoD(Definition of Done) code static analysis metric it is necessary to run the following rake task:
```ruby
qat:devel:static_analysis:validation['filter']
```
##Run all the tests:
In order to run all the cucumber tests it is necessary to run the following rake task:
```ruby
qat:devel:tests:run
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/readiness-it/qat-devel. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the QAT::Devel project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/qa-toolkit/qat-devel/blob/master/CODE_OF_CONDUCT.md). 
