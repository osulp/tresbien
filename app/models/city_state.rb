 class CityState < ApplicationRecord
   self.table_name = 'city_states'

   def self.countries_for_select
    CS.countries.map { |s| [s[1], s[1], { 'data-abbreviation' => s[0]}] }
   end

   def self.states_for_select(in_country)
    country_sym = CS.countries.find { |k, v| v == in_country }.first
    CS.get(country_sym).map { |s| [s[1], s[1], { 'data-abbreviation' => s[0]}] }
   end

   def self.cities_for_select(in_country, in_state, selected_city)
    country_sym = CS.countries.find { |k, v| v == in_country }
    return [selected_city, selected_city] if country_sym.nil?
    state = CS.get(country_sym.first).select { |k,v| v == in_state }
    return [selected_city, selected_city] if state.nil?
    cities = CS.cities(state.keys.first, country_sym).map { |city| [city, city] }
    return [selected_city, selected_city] if cities.empty?
    cities
   end
end
