require_relative 'lib/hal4r/version'

begin
  require 'hen'

  Hen.lay! {{
    gem: {
      name:         %q{hal4r},
      version:      Hal4R::VERSION,
      summary:      %q{Hyperspace analogue to language for Ruby.},
      description:  %q{HAL processing for Ruby.},
      author:       %q{Jens Wille},
      email:        %q{jens.wille@gmail.com},
      license:      %q{AGPL-3.0},
      homepage:     :blackwinter,
      dependencies: %w[rb-gsl],

      required_ruby_version: '>= 1.9.3'
    }
  }}
rescue LoadError => err
  warn "Please install the `hen' gem. (#{err})"
end
