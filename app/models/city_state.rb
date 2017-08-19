 class CityState < ApplicationRecord
   self.table_name = 'city_states'

   def self.states_for_select
    CS.get(:us).map { |s| [s[1], s[1], { 'data-abbreviation' => s[0]}] }
   end

   def self.cities_for_select(in_state)
    return [] if in_state.nil?
    state = CS.get(:us).select { |k,v| v == in_state }.keys.first
    CS.cities(state, :us).map { |city| [city, city] }
   end
end
