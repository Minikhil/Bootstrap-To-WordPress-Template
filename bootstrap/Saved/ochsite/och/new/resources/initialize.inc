<%
	Const ALLOWED_IMAGES = 3
	Const D_DAY = "22-Aug-2008"
	Const DB_PATH = "c:/Inetpub/wwwroot/och/resources/databases/och.mdb"
	
	Dim fields_array: fields_array = Array("unit_type_id", "available_bedrooms", "total_bedrooms", "lease", "term", "rent", "security_deposit", "date_available", "comments", "street_number", "street", "apartment_number", "postal_code", "contact_name", "contact", "primary_phone", "secondary_phone", "best_time_to_call", "email", "area", "locality", "rent_for", "preferred_gender", "registered_with_rental_registry")


	Dim features_array: features_array = Array("heat", "gas", "water", "electric", "cable", "internet", "garbage_collection", "central_air", "stove", "refrigerator", "furnished", "washer", "dryer", "storm_windows", "insulated", "garage", "off-street_parking", "dogs_allowed", "cats_allowed")


	Dim occupancy_array: occupancy_array = Array("Verified") 

	Dim mandated_array: mandated_array = Array("working_smoke_detectors", "carbon_monoxide_detectors", "doors,_stairs,_fire_escapes_unobstructed_and_in_good_condition")
	
	Dim safety_checklist_array: safety_checklist_array = Array("building_and_surrounding_area_illuminated_at_night", "exterior_door_has_deadbolt", "fire_extinguishers", "security_system", "bedrooms_not_located_in_basement_or_attic")

	Dim preferences_array: preferences_array = Array("males_preferred", "females_preferred", "grad_students_preferred", "med_students_preferred", "dental_students_preferred", "law_students_preferred", "non-smoker_preferred", "any")
	
	Dim status_array: status_array = Array("Pending", "Active", "Inactive")
	
	
	
	Function ListingIsNew(date)
		ListingIsNew = (DateDiff("d", listing("date_listed"), D_DAY) < 0)
	End Function
%>