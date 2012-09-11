class Location
  include Mongoid::Document

  field :company_id, type: String
  field :contact_id, type: String
  field :street_number, type: Integer
  field :street_number_prefix, type: String
  field :street_name, type: String
  field :street_type, type: String
  field :street_direction, type: String
  field :address_type, type: String
  field :address_type_identifier, type: String
  field :minor_municipality, type: String
  field :major_municipality, type: String
  field :governing_district, type: String
  field :postal_area, type: String
  field :country, type: String
  field :combined_street, type: String
  

  belongs_to :opportunity
  belongs_to :contact
  belongs_to :company
end
