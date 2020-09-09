module Jets::Resource::Iam
  class PermissionsBoundary
    extend Memoist

    attr_reader :definition
    def initialize(definition)
      @definition = definition
    end

    def arn
      definition
    end
  end
end
