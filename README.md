# CSV Employees work history

This Ruby on Rails application is designed to process employee work histories from a CSV file and determine which pairs of employees have worked together the longest on the same projects.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- **rbenv**: You must have rbenv installed to manage Ruby versions. For installation instructions, visit [rbenv](https://github.com/rbenv/rbenv).

## Installation

### Setting Up Ruby Environment

1. **Install Ruby Using rbenv**:
   Install and set Ruby 3.3.1 as the global version:

   ```bash
   rbenv install 3.3.1
   rbenv global 3.3.1
   ```
   Verify the Ruby installation:
   ```bash
   ruby -v
   # Output should be 'ruby 3.3.1'
   ```
2. **Install Bundler:**
    Bundler manages gem dependencies for Ruby projects.
    ```bash
    gem install bundler
    ```
3. **Installing Project Dependencies**
    Navigate to the project directory and install the required gems:
    ```bash
    bundle install
    ```
4. **Running the Project**
    Start the application using Puma, the Rails default web server:
    ```bash
    bundle exec puma
    ```

## Sample Data
A sample CSV file named [employees.csv](./employees.csv) is included in the project root. Use this file to test the application's functionality without needing to create your own data initially.
