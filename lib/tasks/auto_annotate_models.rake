if Rails.env.development?
  task :set_annotation_options do
    Annotate.set_defaults(
      models: 'true',
      exclude_tests: 'true',
      exclude_fixtures: 'true',
      exclude_factories: 'false',
      exclude_serializers: 'true',
    )
  end
  Annotate.load_tasks
end