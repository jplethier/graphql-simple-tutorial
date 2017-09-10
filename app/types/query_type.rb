QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root for this schema"

  field :movies do
    type types[MovieType]
    argument :year, types.Int
    argument :partial_title, types.String
    argument :size, types.Int, default_value: 10
    resolve -> (obj, args, ctx) {
      movies = Movie.all
      movies = movies.where(year: args[:year]) if args[:year].present?
      movies = movies.where("title like '%#{args[:partial_title].gsub(' ', '%')}%'") if args[:partial_title].present?

      movies.limit(args[:size])
    }
  end

  field :movie do
    type MovieType
    argument :id, !types.ID
    resolve -> (obj, args, ctx) {
      Movie.find(args[:id])
    }
  end

  field :actor do
    type ActorType
    argument :id, !types.ID
    resolve -> (obj, args, ctx) {
      Actor.find(args[:id])
    }
  end
end
