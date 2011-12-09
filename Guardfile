require 'guard/rspec'
extensions = ["Guard::RSpec", "Guard::Schema", "Guard::Routes"]

module ::Guard
  class Schema < ::Guard::Guard
    def run_on_change(_)
      UI.info "Clearing the way"
      system('rake db:test:prepare')
      UI.clear
      UI.info "Ready to lead the charge!"
    end

    def stop
      UI.clear
      UI.info "The battle is ended...\n"
      UI.info "Listing the wounded:"
      system('git status -s -b')
    end
  end

  class Routes < ::Guard::Guard
    def run_on_change(_)
      UI.info "Leading the way down new paths..."
      system 'rake routes'
    end
  end
end

# Remove annoying message from guard-rspec
::Guard::RSpec.class_eval do
  def start; end
  def run_all
    UI.info "Charging valiantly in to battle\^[r"
    system "rake spec"
  end
end

# Add support for focus tags -- Remove once hooks are implemented...
# https://github.com/guard/guard/issues/42
::Guard::RSpec::Runner.class_eval do
  class << self
    alias original_command rspec_command
    def rspec_command(paths, options={})
      command = original_command(paths, options)
      has_wip = paths.any? do |file|
        File.read(file) =~ /^\s*(describe|context|it).*?wip(:)?( =>)? true/ if File.file?(file)
      end
      command += " -t wip" if has_wip
      command
    end
  end
end

guard 'spork', :wait => 45, :cucumber => true, :rspec_env => { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('spec/spec_helper.rb')
	watch('spec/support/**/*.rb')
end

guard 'rspec', :all_on_start => false, :all_after_pass => false, :cli => "--color -f nested --drb" do
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^spec/factories/(.+)\.rb})                { "spec"}
  watch(%r{^app/(.+)\.rb})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb})  { |m| "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb" }
  watch(%r{^app/views/(.+)/(.*\.(erb|haml))$})          { |m| "spec/requests/#{m[1]}.#{m[2]}_spec.rb" }
end

if Dir.glob('**/*.feature')
  require 'guard/cucumber'
  ::Guard::Cucumber.class_eval do
    def run_all
      UI.info "Preparing to accept the battle's outcome"
      system "rake cucumber"
    end
  end

  guard 'cucumber', :all_on_start => false, :all_after_pass => false, :cli => "--drb -f pretty --no-profile --tags @wip:4" do
    watch(%r{^features/.+\.feature$})
    watch(%r{^features/support/.+$})                      { 'features' }
    watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
  end
  extensions << "Guard::Cucumber"
else
  @nocukes = true
end


guard('schema') { watch('db/schema.rb') }
guard('routes') { watch('config/routes.rb') }

::Guard::UI.clear
::Guard::UI.info "\e[34mThe Vangaurd marches forth with the following troops:\n \e[32m#{extensions.join("\n ")}"
::Guard::UI.info "\e[33mRunning without cucumber. If you need this, install guard-cucumber." if @nocukes

