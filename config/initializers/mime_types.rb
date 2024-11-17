Mime::Type.register "application/vnd.alexandria.v1+json", :alexandria_json_v1

# If we need to do some versioning
# Mime::Type.register "application/vnd.alexandria.v2+json", :alexandria_json_v2
# Or use a different base format
# Mime::Type.register "application/vnd.alexandria.v1+xml", :alexandria_json_v1

ActionController::Renderers.add :alexandria_json_v1 do |obj, options|
  # We set the content type here
  self.content_type = Mime::Type.lookup("application/vnd.alexandria.v1+json")
  self.response_body  = obj
end
