class Pafs::Api < Grape::API
  mount Pafs::Projects::ApiV1 => '/v1'
end
