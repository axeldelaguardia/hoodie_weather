class SalarySerializer
  include JSONAPI::Serializer
  attributes :id, :destination, :forecast, :salaries
end
