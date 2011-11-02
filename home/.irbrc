IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true

require 'rubygems'
require 'pp'

if defined?(::Bundler)
  module Bundler
    # Activate a gem from outside the Gemfile. Could be considered harmful.
    # Might be useful for .irbrc and friends. It's a slow activation, but
    # after activation, files from the activated gems will be available for
    # normal require.
    def self.outside(&block)
      # Bundler doesn't cripple this:
      if Gem::Specification.respond_to?(:reset)
        Gem::Specification.reset
      else
        Gem.source_index.refresh!
      end

      yield
    ensure
      # Re-enable the bundler lockdown via bundlers #initialize hack
      Gem.send(:class_variable_set, :@@source_index, nil)
    end
  end

  def outside(&block)
    Bundler.outside(&block)
  end
else
  def outside
    yield
  end
end

def suggest(lib, options = {})
  options = {
    :require => lib
  }.merge(options)

  begin
    if Gem::Specification.respond_to?(:find_by_path)
      gem = Gem::Specification.find_by_path(lib)
      gem.activate if gem
    else
      Gem.activate(lib)
    end

    require options[:require]

    yield if block_given?
  rescue LoadError
    puts "#{lib} not available."
  end
end

outside do
  # A collection of useful irbisms
  suggest 'irbtools', :require => 'irbtools/configure' do
    # suggest 'irbtools-more', :require => 'irbtools/more' do
    #   Irbtools.add_package :more
    # end

    Irbtools.remove_library :sketches
    Irbtools.add_library :sketches do
      vim = `which vim-wrapper`.strip
      vim = `which vim`.strip if vim.empty?

      Sketches.config :editor => vim,
        :background => true,
        :terminal => lambda {|cmd| "tmux split-window -v #{cmd.dump}" }
    end

    Irbtools.remove_library :wirb
    Irbtools.add_library :wirb, :thread => -1 do Wirb.start end

    Irbtools.remove_library :fancy_irb
    Irbtools.start

  end

  # awesome_print
  suggest 'awesome_print', :require => 'ap' do
    AwesomePrint.defaults = {
      :color => {
        :method => :cyanish
      }
    }
  end

  # Nice tables for rails models
  suggest 'hirb' do
    Hirb.enable
    def t(objects)
      puts Hirb::Helpers::AutoTable.render(objects)
    end
  end

  suggest 'bond' do
    Bond.start

    def library_paths
      paths = $LOAD_PATH.dup
      return paths unless Object.const_defined?(:Gem) && Gem::Specification.respond_to?(:each)

      Gem::Specification.each do |spec|
        spec.require_paths.each do |require_path|
          paths << "#{spec.full_gem_path}/#{require_path}"
        end
      end

      paths
    end

    def requirable_files_in(path)
      return [] unless path && File.exist?(path)

      `find '#{path}' -name '*.rb' -o -name '*.so'`.split("\n").map do |file|
        file.sub(%r{^#{path}/(.*)\.(rb|so)$}, '\1')
      end
    end

    # Pre-cache filename completion in a background thread
    filename_completion_thread = Thread.new do
      files = []

      library_paths.each do |path|
        files += requirable_files_in(path)
      end

      $bond_file_completions = files.uniq
    end

    Bond.recomplete(:method => "Kernel#require", :search => :files) do
      filename_completion_thread.join unless $bond_file_completions
      $bond_file_completions
    end
  end
end
