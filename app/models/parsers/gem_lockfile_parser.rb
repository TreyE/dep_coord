module Parsers
  class GemLockfileParser
    Citrus.load(File.join(File.dirname(__FILE__), "gem_lockfile.citrus"))

    def initialize
      @parser = ::Parsers::GemLockfile
    end

    def parse(string)
      beautify(@parser.parse(string))
    end

    private

    def beautify(results)
      results.value.inject([]) do |acc, spec|
        acc + cast(spec)
      end
    end

    def cast(res)
      case res
      in [:GIT, gitspec]
        [gitspec]
      in [:PATH, pathspec]
        [gitspec]
      in [:GEMS, _, gemspecs]
        gemspecs.map { |gs| build_gem_spec(gs) }
      else
        res
      end
    end

    def build_gem_spec(gs)
      gs
    end
  end
end
