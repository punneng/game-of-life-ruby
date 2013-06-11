require 'simplecov'
SimpleCov.start do
  add_group 'App', 'app'
end

require_relative '../app'

def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end