note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_QUERY
inherit
	ETF_ADD_QUERY_INTERFACE
create
	make
feature -- command
	add_query(cn: STRING ; fn: STRING ; ps: ARRAY[TUPLE[pn: STRING; pt: STRING]] ; rt: STRING)
		require else
			add_query_precond(cn, fn, ps, rt)
		local
			err: ERRORS
    	do
			-- perform some update on the model state
			if model.being_specified then
				model.set_error_msg (err.assignment_instruction_currently_being_specified (model.routine_being_specified.get_name,
				model.class_being_specified.get_name))
			elseif not model.class_name_exists (cn) then
				model.set_error_msg (err.class_non_existing (cn))
			elseif model.feature_exist_in_class (cn, fn) then
				model.set_error_msg (err.feature_to_be_added_exists (cn, fn))
			elseif not model.para_name_list_not_clash_with_class_names (ps) then
				model.set_error_msg (err.para_name_in_list_clash_with_classes (model.para_list_of_clashing_names (ps)))
			elseif not model.not_duplicate_para_names (ps) then
				model.set_error_msg (err.para_names_contain_duplicates (model.duplicate_para_list (ps)))
			elseif not model.para_not_incorrect_type (ps) then
				model.set_error_msg (err.para_type_invalid (model.para_invalid_types (ps)))
			elseif not model.valid_return_type (rt) then
				model.set_error_msg (err.return_type_invalid (rt))
			else
				model.add_query (cn, fn, rt, ps)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
