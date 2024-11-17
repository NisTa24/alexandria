# app/representation_builders/hypermedia_builder.rb
class HypermediaBuilder
  def initialize(presenter)
    @presenter = presenter
    @template = HypermediaTemplate.new
  end

  def build
    # Just like caching, we make hypermedia optional
    # It has to be activated in the presenter
    if @presenter.class.hypermedia?
      @presenter.data[:links] ||= {}

      add_hypermedia_for_relationships
      add_hypermedia
    end

    @presenter
  end

  private

  # Add the 'self' link
  def add_hypermedia
    links = @template.entity(@presenter.class, @presenter.object.id)
    @presenter.data[:links][:self] = links
  end

  # Add the related entities links
  def add_hypermedia_for_relationships
    @presenter.class.relations.each do |relationship|
      # Get the presenter class for the related entity
      presenter = "#{relationship.singularize.capitalize}Presenter".constantize

      # Reflect on the associations to get the one matching the related
      # entity name
      association = @presenter.object.class.reflections[relationship]
      foreign_key = association.foreign_key

      # We check if the data on the other side of the relation is a collection
      # and call the appropriate method on HypermediaTemplate instance
      @presenter.data[:links][relationship] = if association.collection?
        @template.collection(presenter, @presenter.object.id, foreign_key)
      else # or not
        @template.entity(presenter, @presenter.object.send(foreign_key))
      end
    end
  end
end
