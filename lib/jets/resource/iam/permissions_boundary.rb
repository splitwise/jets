module Jets::Resource::Iam
  class PermissionsBoundary
    extend Memoist

    attr_reader :definition
    def initialize(definition)
      @definition = definition
    end

    def arn
      standardize(definition)
    end
    memoize :arn # only process arn once

    # AmazonEC2ReadOnlyAccess => arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess
    def standardize(definition)
      return definition if definition.nil? || definition.include?('iam::aws:policy')

      "arn:aws:iam::aws:policy/#{definition}"
    end
  end
end
